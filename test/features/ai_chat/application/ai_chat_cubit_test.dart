import 'dart:async';
import 'dart:collection';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/ai_chat/application/ai_chat_cubit.dart';
import 'package:transkriptor_uz/features/ai_chat/application/ai_chat_poll_policy.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/i_ai_chat_facade.dart';

/// Answers from queues, each call optionally held on a completer, so a
/// test decides when (and in which order) answers arrive.
class _FakeFacade implements IAiChatFacade {
  final Queue<Completer<Either<Failure, AiChat>>> histories = Queue();
  final Queue<Either<Failure, AiExchange>> asks = Queue();
  Either<Failure, Unit> clearResult = const Right(unit);
  int historyCalls = 0;
  final List<String> asked = [];

  /// Queues an answer that arrives at once.
  void answer(Either<Failure, AiChat> r) =>
      histories.add(Completer()..complete(r));

  /// Queues an answer the test completes later.
  Completer<Either<Failure, AiChat>> heldHistory() {
    final c = Completer<Either<Failure, AiChat>>();
    histories.add(c);
    return c;
  }

  @override
  Future<Either<Failure, AiChat>> history(String transcriptId) {
    historyCalls++;
    if (histories.isEmpty) return Completer<Either<Failure, AiChat>>().future;
    return histories.removeFirst().future;
  }

  @override
  Future<Either<Failure, AiExchange>> ask(
    String transcriptId,
    String content,
  ) async {
    asked.add(content);
    return asks.removeFirst();
  }

  @override
  Future<Either<Failure, Unit>> clear(String transcriptId) async => clearResult;
}

AiMessage q(String id, String text) => AiMessage(
  id: id,
  role: AiRole.user,
  status: AiMessageStatus.done,
  content: text,
);

AiMessage a(String id, AiMessageStatus status, [String text = '']) =>
    AiMessage(id: id, role: AiRole.assistant, status: status, content: text);

Future<void> settle([int ms = 30]) =>
    Future<void>.delayed(Duration(milliseconds: ms));

void main() {
  late _FakeFacade facade;
  final fast = AiChatPollPolicy.custom(
    first: const Duration(milliseconds: 2),
    max: const Duration(milliseconds: 6),
  );

  setUp(() => facade = _FakeFacade());

  test('loads an empty chat', () async {
    facade.answer(const Right(AiChat()));
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');
    expect(cubit.state.status, AiChatStatus.success);
    expect(cubit.state.items, isEmpty);
  });

  test('a failed first load is a failure state; reload recovers', () async {
    facade
      ..answer(const Left(Failure.network()))
      ..answer(const Right(AiChat()));
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');
    expect(cubit.state.status, AiChatStatus.failure);
    await cubit.reload();
    expect(cubit.state.status, AiChatStatus.success);
  });

  test('send shows the question at once, then polls until answered', () async {
    facade
      ..answer(const Right(AiChat()))
      ..asks.add(
        Right(
          AiExchange(
            question: q('q1', 'Kim?'),
            answer: a('a1', AiMessageStatus.pending),
          ),
        ),
      )
      ..answer(
        Right(
          AiChat(
            items: [q('q1', 'Kim?'), a('a1', AiMessageStatus.pending)],
            pending: true,
          ),
        ),
      )
      ..answer(
        Right(
          AiChat(
            items: [
              q('q1', 'Kim?'),
              a('a1', AiMessageStatus.done, 'Maʼruzachi 1 [00:12]'),
            ],
          ),
        ),
      );
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');

    final states = <AiChatState>[];
    final sub = cubit.stream.listen(states.add);
    addTearDown(sub.cancel);
    final accepted = cubit.send('  Kim?  ');
    // Optimistic: the bubble and a pending answer before the server.
    expect(cubit.state.items.map((m) => m.local), [true, true]);
    expect(cubit.state.items.first.content, 'Kim?');
    expect(cubit.state.pending, isTrue);
    expect(await accepted, isTrue);
    expect(cubit.state.items.first.id, 'q1');

    await settle();
    expect(cubit.state.pending, isFalse);
    expect(cubit.state.items.last.content, 'Maʼruzachi 1 [00:12]');
    final calls = facade.historyCalls;
    await settle();
    // Answered: polling stopped.
    expect(facade.historyCalls, calls);
  });

  test('send is refused while an answer is pending', () async {
    facade.answer(
      Right(
        AiChat(
          items: [q('q1', 'x'), a('a1', AiMessageStatus.pending)],
          pending: true,
        ),
      ),
    );
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');
    expect(await cubit.send('yana'), isFalse);
    expect(facade.asked, isEmpty);
  });

  test('a refused send drops the optimistic rows and keeps a notice', () async {
    facade
      ..answer(const Right(AiChat()))
      ..asks.add(const Left(Failure.server(statusCode: 503)));
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');
    expect(await cubit.send('Savol'), isFalse);
    expect(cubit.state.items, isEmpty);
    expect(cubit.state.sending, isFalse);
    expect(cubit.state.actionFailure, const Failure.server(statusCode: 503));
  });

  test('a late poll does not overwrite a cleared chat', () async {
    facade.answer(
      Right(
        AiChat(
          items: [q('q1', 'x'), a('a1', AiMessageStatus.pending)],
          pending: true,
        ),
      ),
    );
    final held = facade.heldHistory();
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');
    await settle(); // the poll is now in flight, held
    expect(facade.historyCalls, 2);

    await cubit.clear();
    expect(cubit.state.items, isEmpty);

    held.complete(
      Right(AiChat(items: [q('q1', 'x'), a('a1', AiMessageStatus.done, 'y')])),
    );
    await settle();
    expect(cubit.state.items, isEmpty);
  });

  test('a FAILED answer can be retried: its question is sent again', () async {
    facade
      ..answer(
        Right(
          AiChat(
            items: [q('q1', 'Qarorlar?'), a('a1', AiMessageStatus.failed)],
          ),
        ),
      )
      ..asks.add(
        Right(
          AiExchange(
            question: q('q2', 'Qarorlar?'),
            answer: a('a2', AiMessageStatus.pending),
          ),
        ),
      )
      ..answer(
        Right(
          AiChat(
            items: [
              q('q1', 'Qarorlar?'),
              a('a1', AiMessageStatus.failed),
              q('q2', 'Qarorlar?'),
              a('a2', AiMessageStatus.done, 'Uchta qaror'),
            ],
          ),
        ),
      );
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');
    expect(await cubit.retry('a1'), isTrue);
    expect(facade.asked, ['Qarorlar?']);
    await settle();
    expect(cubit.state.items.last.content, 'Uchta qaror');
  });

  test('a transient poll failure keeps polling and keeps the chat', () async {
    facade
      ..answer(
        Right(
          AiChat(
            items: [q('q1', 'x'), a('a1', AiMessageStatus.pending)],
            pending: true,
          ),
        ),
      )
      ..answer(const Left(Failure.timeout()))
      ..answer(
        Right(
          AiChat(items: [q('q1', 'x'), a('a1', AiMessageStatus.done, 'y')]),
        ),
      );
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');
    await settle(40);
    expect(cubit.state.items.last.content, 'y');
    expect(cubit.state.pollFailure, isNull);
  });

  test('a failed clear keeps the chat and says so', () async {
    facade
      ..answer(
        Right(AiChat(items: [q('q1', 'x'), a('a1', AiMessageStatus.done)])),
      )
      ..clearResult = const Left(Failure.network());
    final cubit = AiChatCubit(facade, fast);
    addTearDown(cubit.close);
    await cubit.load('t1');
    await cubit.clear();
    expect(cubit.state.items, hasLength(2));
    expect(cubit.state.actionFailure, const Failure.network());
  });

  test('closing stops polling', () async {
    facade.answer(
      Right(
        AiChat(
          items: [q('q1', 'x'), a('a1', AiMessageStatus.pending)],
          pending: true,
        ),
      ),
    );
    final cubit = AiChatCubit(facade, fast);
    await cubit.load('t1');
    await cubit.close();
    final calls = facade.historyCalls;
    await settle();
    expect(facade.historyCalls, calls);
  });
}
