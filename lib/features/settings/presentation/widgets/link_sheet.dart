import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';

/// Shows a public web page's address with a copy button. The app has no
/// way to open a browser itself (no `url_launcher`), so the person copies
/// it. A null [url] means the page does not exist yet: «Tez orada».
Future<void> showLinkOrSoon(
  BuildContext context, {
  required String title,
  required String? url,
}) async {
  if (url == null) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.comingSoon)));
    return;
  }
  await showAppSheet<void>(
    context,
    builder: (_) => _LinkSheet(title: title, url: url),
  );
}

class _LinkSheet extends StatelessWidget {
  const _LinkSheet({required this.title, required this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppSheet(
      title: title,
      footer: FilledButton.icon(
        icon: const Icon(Icons.copy_rounded),
        label: Text(l10n.shareCopy),
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: url));
          if (!context.mounted) return;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.shareCopied)));
          Navigator.of(context).pop();
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.settingsLinkBody, style: AppText.caption),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.sf2,
              borderRadius: BorderRadius.circular(AppRadii.button),
            ),
            child: SelectableText(url, style: AppText.body),
          ),
        ],
      ),
    );
  }
}
