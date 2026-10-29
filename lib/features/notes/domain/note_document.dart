import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_document.freezed.dart';

enum NoteBlockKind { heading, paragraph, listItem, code }

/// One line of a note as the app shows it, read-only. The stored body is
/// Tiptap (ProseMirror) JSON; the app has no rich-text editor, so marks
/// (bold, links, colours) are dropped and only the structure stays.
@freezed
abstract class NoteBlock with _$NoteBlock {
  const factory NoteBlock({
    required NoteBlockKind kind,
    @Default('') String text,

    /// 1–3 for a heading, 0 otherwise.
    @Default(0) int level,

    /// «•» or «3.» on a list item's first line; empty on its other lines.
    @Default('') String marker,

    /// List nesting, 0 outside a list.
    @Default(0) int depth,

    /// Inside a blockquote.
    @Default(false) bool quoted,
  }) = _NoteBlock;
}

/// Reads the Tiptap document the backend stores (`models.CleanNoteBody`
/// accepts exactly these nodes). Unknown nodes are skipped rather than
/// failing the note: the server's schema may grow before the app does.
abstract final class NoteDocument {
  static List<NoteBlock> parse(Object? doc) {
    final out = <NoteBlock>[];
    if (doc is Map<String, dynamic>) _walk(doc, 0, false, out);
    return out;
  }

  /// The note as plain text, as the server's `noteText` writes it: one
  /// block per line, list items with «• » or «N. », nested ones indented.
  static String plainText(List<NoteBlock> blocks) => blocks
      .map((b) {
        if (b.kind != NoteBlockKind.listItem) return b.text;
        final indent = '  ' * b.depth;
        return b.marker.isEmpty
            ? '$indent  ${b.text}'
            : '$indent${b.marker} ${b.text}';
      })
      .join('\n')
      .trim();

  static void _walk(
    Map<String, dynamic> node,
    int depth,
    bool quoted,
    List<NoteBlock> out,
  ) {
    switch (node['type']) {
      case 'paragraph':
        out.add(
          NoteBlock(
            kind: NoteBlockKind.paragraph,
            text: _inline(node),
            quoted: quoted,
          ),
        );
      case 'heading':
        final attrs = node['attrs'];
        final level = attrs is Map ? attrs['level'] : 1;
        out.add(
          NoteBlock(
            kind: NoteBlockKind.heading,
            text: _inline(node),
            level: level is num ? level.toInt().clamp(1, 3) : 1,
            quoted: quoted,
          ),
        );
      case 'codeBlock':
        out.add(
          NoteBlock(
            kind: NoteBlockKind.code,
            text: _inline(node),
            quoted: quoted,
          ),
        );
      case 'bulletList' || 'orderedList':
        _list(node, depth, quoted, out);
      case 'blockquote':
        for (final child in _children(node)) {
          _walk(child, depth, true, out);
        }
      default:
        for (final child in _children(node)) {
          _walk(child, depth, quoted, out);
        }
    }
  }

  static void _list(
    Map<String, dynamic> list,
    int depth,
    bool quoted,
    List<NoteBlock> out,
  ) {
    final ordered = list['type'] == 'orderedList';
    final attrs = list['attrs'];
    final start = attrs is Map ? attrs['start'] : null;
    var n = start is num && start > 0 ? start.toInt() : 1;
    for (final item in _children(list)) {
      final marker = ordered ? '${n++}.' : '•';
      var first = true;
      for (final child in _children(item)) {
        final type = child['type'];
        if (type == 'paragraph' || type == 'heading' || type == 'codeBlock') {
          out.add(
            NoteBlock(
              kind: NoteBlockKind.listItem,
              text: _inline(child),
              marker: first ? marker : '',
              depth: depth,
              quoted: quoted,
            ),
          );
        } else {
          _walk(child, depth + 1, quoted, out);
        }
        first = false;
      }
    }
  }

  static Iterable<Map<String, dynamic>> _children(Map<String, dynamic> node) {
    final content = node['content'];
    if (content is! List) return const [];
    return content.whereType<Map<String, dynamic>>();
  }

  static String _inline(Map<String, dynamic> node) {
    final b = StringBuffer();
    for (final c in _children(node)) {
      switch (c['type']) {
        case 'text':
          final t = c['text'];
          if (t is String) b.write(t);
        case 'hardBreak':
          b.write('\n');
      }
    }
    return b.toString();
  }
}

/// `models.CleanNoteTitle`: one line, at most [maxTitle] characters. An
/// empty title is allowed — the list then shows the start of the text.
abstract final class NoteRules {
  static const int maxTitle = 200;

  static String? normalizeTitle(String raw) {
    final title = raw.trim().split(RegExp(r'\s+')).join(' ');
    return title.runes.length > maxTitle ? null : title;
  }
}
