import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';

/// Opens [builder] as a modal bottom sheet in the app's style. The theme
/// draws the handle; wrap the content in [AppSheet] for the title row and
/// a scrollable body.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool useRootNavigator = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: useRootNavigator,
    builder: builder,
  );
}

/// Bottom sheet scaffold: title, optional close button, a body that
/// scrolls when it does not fit, and optional [footer] pinned below it
/// (primary actions). Never taller than 90% of the screen.
class AppSheet extends StatelessWidget {
  const AppSheet({
    required this.child,
    this.title,
    this.showClose = true,
    this.footer,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    super.key,
  });

  final String? title;
  final bool showClose;
  final Widget child;
  final Widget? footer;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final title = this.title;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: media.size.height * .9),
      child: Padding(
        // The keyboard pushes the sheet up instead of covering a field.
        padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null || showClose)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: title == null
                            ? const SizedBox.shrink()
                            : Text(title, style: AppText.title),
                      ),
                      if (showClose)
                        IconButton(
                          tooltip: context.l10n.close,
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                    ],
                  ),
                ),
              Flexible(
                child: SingleChildScrollView(padding: padding, child: child),
              ),
              if (footer != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: footer,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
