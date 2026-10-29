import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/copy_link_fallback.dart';
import 'package:transkriptor_uz/features/links/application/links_cubit.dart';

/// Opens [url] in the browser; when nothing opens it, copies it instead.
/// A null [url] is a page that does not exist yet: «Tez orada».
Future<void> openLinkOrCopy(BuildContext context, String? url) async {
  if (url == null) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.comingSoon)));
    return;
  }
  final opened = await context.read<LinksCubit>().open(url);
  if (!opened && context.mounted) await copyLinkInstead(context, url);
}

/// iOS: the app's page in the Settings app. A refusal says where to go.
Future<void> openAppSettings(BuildContext context) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final failed = context.l10n.openPhoneSettingsFailed;
  final opened = await context.read<LinksCubit>().openAppSettings();
  if (!opened) {
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(failed)));
  }
}
