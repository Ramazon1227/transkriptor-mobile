import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/capture_actions.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/source_sheet.dart';
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart';

/// Bottom navigation: Studio and Files, with the large saffron «+» in the
/// middle that opens the source sheet. The active tab has a saffron bar on
/// top of it, never a filled pill.
///
/// The shell owns the file picker, so «Fayl yuklash» works the same from
/// the sheet and from the home cards.
class AppShell extends StatelessWidget {
  const AppShell({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PickFileCubit>(),
      child: _ShellView(shell: shell),
    );
  }
}

class _ShellView extends StatelessWidget {
  const _ShellView({required this.shell});

  final StatefulNavigationShell shell;

  void _go(int index) =>
      shell.goBranch(index, initialLocation: index == shell.currentIndex);

  Future<void> _openSources(BuildContext context) async {
    final source = await showSourceSheet(context);
    if (source != null && context.mounted) startCapture(context, source);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<PickFileCubit, PickFileState>(
      listener: (context, state) {
        final file = state.file;
        if (state.status == PickFileStatus.picked && file != null) {
          context.read<PickFileCubit>().consumed();
          unawaited(context.push(Routes.send, extra: file));
        } else if (state.status == PickFileStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.failure!.message(l10n))));
        }
      },
      child: Scaffold(
        body: shell,
        bottomNavigationBar: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.sf0,
            border: Border(top: BorderSide(color: AppColors.sf2)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 64,
              child: Row(
                children: [
                  _Tab(
                    icon: Icons.dashboard_outlined,
                    label: l10n.navStudio,
                    selected: shell.currentIndex == 0,
                    onTap: () => _go(0),
                  ),
                  _PlusButton(
                    label: l10n.navNew,
                    onTap: () => _openSources(context),
                  ),
                  _Tab(
                    icon: Icons.folder_outlined,
                    label: l10n.navFiles,
                    selected: shell.currentIndex == 1,
                    onTap: () => _go(1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlusButton extends StatelessWidget {
  const _PlusButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final busy = context.select<PickFileCubit, bool>(
      (c) => c.state.status == PickFileStatus.picking,
    );
    return SizedBox(
      width: 96,
      child: Center(
        child: Semantics(
          button: true,
          label: label,
          excludeSemantics: true,
          child: Material(
            color: AppColors.accent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: busy ? null : onTap,
              child: SizedBox.square(
                dimension: 56,
                child: busy
                    ? const Padding(
                        padding: EdgeInsets.all(18),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.accentText,
                        ),
                      )
                    : const Icon(
                        Icons.add_rounded,
                        color: AppColors.accentText,
                        size: 32,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.accent : AppColors.mutedDark;
    return Expanded(
      child: Semantics(
        selected: selected,
        button: true,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: selected ? AppColors.accent : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(height: 3),
                // The bar's height is fixed; large text must not push the
                // label out of it.
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaler: MediaQuery.textScalerOf(context)
                      .clamp(maxScaleFactor: 1.3),
                  style: AppText.caption.copyWith(fontSize: 11, color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
