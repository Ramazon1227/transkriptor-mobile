import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/infrastructure/facades/ai_chat_facade.dart';
import 'package:transkriptor_uz/features/ai_chat/infrastructure/repositories/ai_chat_repository.dart';

import '../../../helpers/fake_http_adapter.dart';

void main() {
  const path = '/api/v1/transcript/t1/chat';

  AiChatFacade facade(Map<String, (int, Object?)> routes) =>
      AiChatFacade(AiChatRepository(fakeDio(FakeHttpAdapter(routes))));

  test('history parses roles, statuses and unknown values', () async {
    final f = facade({
      'GET $path': (
        200,
        ok({
          'items': [
            {
              'id': 'q1',
              'role': 'USER',
              'status': 'DONE',
              'content': 'Kim gapirdi?',
              'created_at': '2026-10-29T10:00:00Z',
            },
            {
              'id': 'a1',
              'role': 'ASSISTANT',
              'status': 'PENDING',
              'content': '',
            },
            {'id': 'x', 'role': 'SYSTEM', 'status': 'WEIRD'},
          ],
          'pending': false,
        }),
      ),
    });
    final chat = (await f.history('t1')).getOrElse(() => throw StateError(''));
    expect(chat.items, hasLength(3));
    expect(chat.items[0].role, AiRole.user);
    expect(chat.items[0].createdAt, DateTime.utc(2026, 10, 29, 10));
    expect(chat.items[1].status, AiMessageStatus.pending);
    expect(chat.items[2].role, AiRole.unknown);
    expect(chat.items[2].status, AiMessageStatus.unknown);
    // A PENDING row keeps polling even if the flag says otherwise.
    expect(chat.pending, isTrue);
  });

  test('a failed answer carries the server sentence', () async {
    final f = facade({
      'GET $path': (
        200,
        ok({
          'items': [
            {
              'id': 'a1',
              'role': 'ASSISTANT',
              'status': 'FAILED',
              'error': 'Javob kelmadi — savolni qayta yuboring.',
            },
          ],
        }),
      ),
    });
    final chat = (await f.history('t1')).getOrElse(() => throw StateError(''));
    expect(chat.items.single.error, startsWith('Javob kelmadi'));
    expect(chat.pending, isFalse);
  });

  test('ask posts {content} and reads question + answer', () async {
    final adapter = FakeHttpAdapter({
      'POST $path': (
        202,
        ok({
          'question': {
            'id': 'q1',
            'role': 'USER',
            'status': 'DONE',
            'content': 'Savol',
          },
          'answer': {'id': 'a1', 'role': 'ASSISTANT', 'status': 'PENDING'},
        }),
      ),
    });
    final f = AiChatFacade(AiChatRepository(fakeDio(adapter)));
    final ex = (await f.ask(
      't1',
      'Savol',
    )).getOrElse(() => throw StateError(''));
    expect(adapter.sent.single.body, {'content': 'Savol'});
    expect(ex.question.id, 'q1');
    expect(ex.answer.isPendingAnswer, isTrue);
  });

  test('a 409 and a mis-shaped body become failures', () async {
    final busy = facade({
      'POST $path': (409, {'status': 'CONFLICT', 'description': 'kuting'}),
    });
    expect(
      (await busy.ask('t1', 'x')).fold((l) => l, (_) => null),
      const Failure.server(statusCode: 409, message: 'kuting'),
    );
    final bad = facade({
      'POST $path': (202, ok({'question': 'x'})),
    });
    expect(
      (await bad.ask('t1', 'x')).fold((l) => l, (_) => null),
      const Failure.parsing(),
    );
  });

  test('clear sends DELETE', () async {
    final adapter = FakeHttpAdapter({
      'DELETE $path': (200, ok({'deleted': true})),
    });
    final f = AiChatFacade(AiChatRepository(fakeDio(adapter)));
    expect((await f.clear('t1')).isRight(), isTrue);
    expect(adapter.sent.single.options.method, 'DELETE');
  });
}
