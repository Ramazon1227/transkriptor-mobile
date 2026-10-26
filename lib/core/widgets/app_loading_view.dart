import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(semanticsLabel: context.l10n.loading),
    );
  }
}
