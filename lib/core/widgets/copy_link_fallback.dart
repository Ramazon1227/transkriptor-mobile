import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';

/// What a tap on a link does when the phone could not open it: the link
/// goes to the clipboard and a SnackBar says so — never a silent nothing.
Future<void> copyLinkInstead(BuildContext context, String url) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final text = context.l10n.linkOpenFailedCopied;
  await Clipboard.setData(ClipboardData(text: url));
  messenger
    ?..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
