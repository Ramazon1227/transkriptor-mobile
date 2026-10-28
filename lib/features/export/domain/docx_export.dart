import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:transkriptor_uz/features/export/domain/transcript_export.dart';

/// A Word document from the export blocks. A port of
/// `tr-frontend/src/lib/docx.ts`: three XML parts in a zip, no font named —
/// Word takes its own default, which covers Cyrillic. [documentXml] is
/// the web's byte for byte; the zip around it is `archive`'s, so the file
/// bytes differ while what Word reads does not.
abstract final class DocxExport {
  static const _w =
      'http://schemas.openxmlformats.org/wordprocessingml/2006/main';

  // XML parts are joined lists: the pieces are tags with no space
  // between them, which adjacent string literals would be linted for.
  static const _xmlHead =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';

  static final String _contentTypes = [
    _xmlHead,
    '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">',
    '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>',
    '<Default Extension="xml" ContentType="application/xml"/>',
    '<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>',
    '</Types>',
  ].join();

  static final String _rels = [
    _xmlHead,
    '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">',
    '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>',
    '</Relationships>',
  ].join();

  static const _sectPr =
      '<w:sectPr><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:top="1134" w:right="1134" w:bottom="1134" w:left="1134" w:header="709" w:footer="709" w:gutter="0"/></w:sectPr>';

  static Uint8List build(String title, List<ExportBlock> blocks) {
    final archive = Archive();
    void add(String name, String xml) {
      final data = utf8.encode(xml);
      archive.addFile(ArchiveFile(name, data.length, data));
    }

    add('[Content_Types].xml', _contentTypes);
    add('_rels/.rels', _rels);
    add('word/document.xml', documentXml(title, blocks));
    return Uint8List.fromList(ZipEncoder().encode(archive));
  }

  static String documentXml(String title, List<ExportBlock> blocks) {
    final heading = _p(240, _run(title, '<w:b/><w:sz w:val="32"/>'));
    return [
      _xmlHead,
      '<w:document xmlns:w="$_w"><w:body>',
      heading,
      ...blocks.map(_paragraph),
      _sectPr,
      '</w:body></w:document>',
    ].join();
  }

  static String _paragraph(ExportBlock b) {
    final time = b.time;
    final parts = [
      if (time != null) _run('[$time] ', '<w:color w:val="808080"/>'),
      if (b.speaker.isNotEmpty) _run('${b.speaker}: ', '<w:b/>'),
      _run(b.text),
    ];
    return _p(160, parts.join());
  }

  static String _p(int after, String runs) =>
      '<w:p><w:pPr><w:spacing w:after="$after"/></w:pPr>$runs</w:p>';

  static String _run(String text, [String props = '']) {
    final rPr = props.isEmpty ? '' : '<w:rPr>$props</w:rPr>';
    return '<w:r>$rPr<w:t xml:space="preserve">${_esc(text)}</w:t></w:r>';
  }

  // Control characters XML 1.0 does not allow are dropped — one of them
  // makes the whole document unopenable.
  static final _forbidden = RegExp(
    '[\u0000-\u0008\u000B\u000C\u000E-\u001F\uFFFE\uFFFF]',
  );

  static String _esc(String text) => text
      .replaceAll(_forbidden, '')
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');
}
