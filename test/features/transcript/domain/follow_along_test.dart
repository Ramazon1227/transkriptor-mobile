import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/follow_along.dart';

Segment _s(String id, int start, int end) => Segment(
  id: id,
  start: Duration(seconds: start),
  end: Duration(seconds: end),
  text: id,
);

void main() {
  final segments = [_s('a', 0, 5), _s('b', 5, 9), _s('c', 12, 20)];
  String? at(int s, [List<Segment>? list]) =>
      FollowAlong.activeId(list ?? segments, Duration(seconds: s));

  test('the segment that has started and not ended', () {
    expect(at(0), 'a');
    expect(at(4), 'a');
    expect(at(5), 'b');
    expect(at(15), 'c');
  });

  test('nothing in a silent gap, before the first, after the last', () {
    expect(at(10), isNull);
    expect(at(20), isNull);
    expect(at(99), isNull);
    expect(
      FollowAlong.activeId([_s('x', 3, 6)], const Duration(seconds: 1)),
      isNull,
    );
    expect(FollowAlong.activeId(const [], Duration.zero), isNull);
  });

  test('a short segment inside a long one does not hide the long one', () {
    final overlap = [_s('long', 0, 30), _s('short', 5, 7)];
    expect(at(6, overlap), 'short');
    expect(at(10, overlap), 'long');
  });

  test('a filtered list follows only what is shown', () {
    expect(at(6, [segments[0], segments[2]]), isNull);
  });
}
