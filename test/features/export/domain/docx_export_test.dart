import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/export/domain/docx_export.dart';
import 'package:transkriptor_uz/features/export/domain/transcript_export.dart';

// tr-frontend/src/lib/docx.ts `documentXML` on the same title and blocks,
// run in Node 2026-10-28 (`node:22-alpine`, `--experimental-strip-types`).
// The BEL (U+0007) in the first block is dropped, `<`, `>`, `&` escaped.
const _xml =
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:body><w:p><w:pPr><w:spacing w:after="240"/></w:pPr><w:r><w:rPr><w:b/><w:sz w:val="32"/></w:rPr><w:t xml:space="preserve">Majlis &lt;1&gt; &amp; «oʻquv»</w:t></w:r></w:p><w:p><w:pPr><w:spacing w:after="160"/></w:pPr><w:r><w:rPr><w:color w:val="808080"/></w:rPr><w:t xml:space="preserve">[00:00:05] </w:t></w:r><w:r><w:rPr><w:b/></w:rPr><w:t xml:space="preserve">Ali: </w:t></w:r><w:r><w:t xml:space="preserve">Salom &lt;b&gt;&amp;&lt;/b&gt;</w:t></w:r></w:p><w:p><w:pPr><w:spacing w:after="160"/></w:pPr><w:r><w:t xml:space="preserve">Ikkinchi  </w:t></w:r></w:p><w:sectPr><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:top="1134" w:right="1134" w:bottom="1134" w:left="1134" w:header="709" w:footer="709" w:gutter="0"/></w:sectPr></w:body></w:document>';

const _title = 'Majlis <1> & «oʻquv»';
const _blocks = [
  ExportBlock(time: '00:00:05', speaker: 'Ali', text: 'Salom\u0007 <b>&</b>'),
  ExportBlock(time: null, speaker: '', text: 'Ikkinchi  '),
];

void main() {
  test('document.xml matches the web', () {
    expect(DocxExport.documentXml(_title, _blocks), _xml);
  });

  test('the zip holds the three parts, document.xml as above', () {
    final zip = ZipDecoder().decodeBytes(DocxExport.build(_title, _blocks));
    expect(zip.files.map((f) => f.name), [
      '[Content_Types].xml',
      '_rels/.rels',
      'word/document.xml',
    ]);
    expect(utf8.decode(zip.findFile('word/document.xml')!.content), _xml);
    expect(
      utf8.decode(zip.findFile('_rels/.rels')!.content),
      contains('Target="word/document.xml"'),
    );
  });
}
