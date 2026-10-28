import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:transkriptor_uz/features/export/domain/transcript_export.dart';

/// A PDF from the export blocks, laid out as the web's print sheet
/// (`.printdoc` in `tr-frontend/src/styles/app.css`): A4, 11 pt text at
/// 1.55 line height, a 16 pt heading, grey time, bold name. The web prints
/// through the browser; here the file is drawn on the phone.
abstract final class PdfExport {
  static const int maxPages = 1000;

  /// [regular] and [bold] are TrueType files that cover Cyrillic and
  /// U+02BB / U+02BC — the PDF's built-in fonts cover neither.
  static Future<Uint8List> build(
    String title,
    List<ExportBlock> blocks, {
    required ByteData regular,
    required ByteData bold,
  }) {
    final base = pw.Font.ttf(regular);
    final strong = pw.Font.ttf(bold);
    final doc = pw.Document(title: title)
      ..addPage(
        pw.MultiPage(
          pageTheme: pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            // 20 mm, the DOCX margin (1134 twips).
            margin: const pw.EdgeInsets.all(20 * PdfPageFormat.mm),
            theme: pw.ThemeData.withFont(base: base, bold: strong).copyWith(
              defaultTextStyle: pw.TextStyle(
                font: base,
                fontBold: strong,
                fontSize: 11,
                lineSpacing: 11 * 0.55,
              ),
            ),
          ),
          // The default is 20 pages; two hours of speech is about 45.
          maxPages: maxPages,
          // Spacing is a SizedBox, not Padding: a bare RichText with
          // TextOverflow.span is what MultiPage can split across pages
          // («Bitta paragraf» is one block).
          build: (_) => [
            pw.Text(title, style: pw.TextStyle(font: strong, fontSize: 16)),
            pw.SizedBox(height: 12),
            for (final b in blocks) ...[
              _paragraph(b, strong),
              pw.SizedBox(height: 8),
            ],
          ],
        ),
      );
    return doc.save();
  }

  static pw.Widget _paragraph(ExportBlock b, pw.Font strong) {
    final time = b.time;
    return pw.RichText(
      overflow: pw.TextOverflow.span,
      text: pw.TextSpan(
        children: [
          if (time != null)
            pw.TextSpan(
              text: '[$time] ',
              style: const pw.TextStyle(color: PdfColor.fromInt(0xFF666666)),
            ),
          if (b.speaker.isNotEmpty)
            pw.TextSpan(
              text: '${b.speaker}: ',
              style: pw.TextStyle(font: strong),
            ),
          pw.TextSpan(text: b.text),
        ],
      ),
    );
  }
}
