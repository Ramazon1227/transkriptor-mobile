/// The small formatting set of a model's answer: `## ` heading, `- ` /
/// `1. ` lists (two spaces nest an item) and `**bold**`. Everything else
/// (tables, HTML, code) stays plain text.
///
/// A port of `tr-frontend/src/lib/rich-text.ts`; both pass the same cases
/// (`test/fixtures/rich_text_cases.json` is a copy of the web's
/// `rich-text.fixtures.json` — copy it again, do not edit it by hand).
library;

class RichRun {
  const RichRun(this.text, {this.bold = false});

  final String text;
  final bool bold;
}

sealed class RichBlock {
  const RichBlock();
}

final class RichHeading extends RichBlock {
  const RichHeading(this.runs);

  final List<RichRun> runs;
}

final class RichParagraph extends RichBlock {
  const RichParagraph(this.runs);

  final List<RichRun> runs;
}

final class RichList extends RichBlock {
  const RichList({
    required this.ordered,
    required this.start,
    required this.items,
  });

  final bool ordered;
  final int start;
  final List<RichItem> items;
}

class RichItem {
  const RichItem(this.runs, [this.sub]);

  final List<RichRun> runs;
  final RichList? sub;
}

final _heading = RegExp(r'^ {0,3}#{1,6}\s+(.+?)\s*#*\s*$');
final _item = RegExp(r'^( *)(?:[-*•+]|(\d{1,3})[.)])\s+(.*)$');
final _rule = RegExp(r'^ {0,3}([-*_])(\s*\1){2,}\s*$');
final _bold = RegExp(r'\*\*(?=\S)([\s\S]*?\S)\*\*|__(?=\S)([\s\S]*?\S)__');
final _indented = RegExp('^ {2,}');

/// `**bold**` pairs; an unclosed one (an answer still being written) stays
/// plain text.
List<RichRun> richRuns(String text) {
  final out = <RichRun>[];
  var last = 0;
  for (final m in _bold.allMatches(text)) {
    if (m.start > last) out.add(RichRun(text.substring(last, m.start)));
    out.add(RichRun(m.group(1) ?? m.group(2)!, bold: true));
    last = m.end;
  }
  if (last < text.length) out.add(RichRun(text.substring(last)));
  return out;
}

class _RawItem {
  _RawItem(this.raw);

  String raw;
  _RawList? sub;
}

class _RawList {
  _RawList({required this.ordered, required this.start});

  final bool ordered;
  final int start;
  final items = <_RawItem>[];
}

class _RawBlock {
  _RawBlock.text(this.kind, this.raw) : list = null;
  _RawBlock.list(_RawList this.list) : kind = 'list', raw = '';

  final String kind;
  String raw;
  final _RawList? list;
}

List<RichBlock> parseRich(String text) {
  final blocks = <_RawBlock>[];
  // stack[d] is the open list at depth d; empty when no list is open.
  var stack = <_RawList>[];
  _RawBlock? para;
  var blank = false;

  final lines = text
      .replaceAll(RegExp(r'\r\n?'), '\n')
      .replaceAll('\t', '  ')
      .split('\n');
  for (final line in lines) {
    if (line.trim().isEmpty || _rule.hasMatch(line)) {
      para = null;
      blank = true;
      continue;
    }
    final heading = _heading.firstMatch(line);
    if (heading != null) {
      blocks.add(_RawBlock.text('heading', heading.group(1)!));
      stack = [];
      para = null;
      blank = false;
      continue;
    }
    final item = _item.firstMatch(line);
    if (item != null) {
      final number = item.group(2);
      final ordered = number != null;
      final start = ordered ? int.parse(number) : 1;
      final depth = (item.group(1)!.length ~/ 2).clamp(0, stack.length);
      if (depth == 0 && (stack.isEmpty || stack[0].ordered != ordered)) {
        final list = _RawList(ordered: ordered, start: start);
        blocks.add(_RawBlock.list(list));
        stack = [list];
      } else if (depth == stack.length) {
        final parent = stack[depth - 1].items.last;
        final sub = parent.sub ??= _RawList(ordered: ordered, start: start);
        stack = [...stack, sub];
      } else {
        stack = stack.sublist(0, depth + 1);
      }
      stack[depth].items.add(_RawItem(item.group(3)!));
      para = null;
      blank = false;
      continue;
    }
    // A list item going on: no blank line before it and indented.
    if (stack.isNotEmpty && !blank && _indented.hasMatch(line)) {
      stack.last.items.last.raw += ' ${line.trim()}';
      continue;
    }
    stack = [];
    if (para != null && !blank) {
      para.raw += '\n${line.trim()}';
    } else {
      para = _RawBlock.text('para', line.trim());
      blocks.add(para);
    }
    blank = false;
  }

  RichList list(_RawList l) => RichList(
    ordered: l.ordered,
    start: l.start,
    items: [
      for (final i in l.items)
        RichItem(richRuns(i.raw.trim()), i.sub == null ? null : list(i.sub!)),
    ],
  );
  return [
    for (final b in blocks)
      switch (b.kind) {
        'list' => list(b.list!),
        'heading' => RichHeading(richRuns(b.raw)),
        _ => RichParagraph(richRuns(b.raw)),
      },
  ];
}

String _plainRuns(List<RichRun> runs) => runs.map((r) => r.text).join();

List<String> _plainList(RichList l, int depth) {
  final pad = '  ' * depth;
  return [
    for (var i = 0; i < l.items.length; i++) ...[
      [
        '$pad${l.ordered ? '${l.start + i}.' : '-'}',
        _plainRuns(l.items[i].runs),
      ].join(' '),
      if (l.items[i].sub != null) ..._plainList(l.items[i].sub!, depth + 1),
    ],
  ];
}

/// What «Nusxalash» puts on the clipboard: no markers, lists as `- ` and
/// renumbered `1. `.
String richPlain(String text) => parseRich(text)
    .map(
      (b) => switch (b) {
        RichList() => _plainList(b, 0).join('\n'),
        RichHeading(:final runs) ||
        RichParagraph(:final runs) => _plainRuns(runs),
      },
    )
    .join('\n\n');
