import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';

/// Bottom navigation: three tabs and the record button. Active tab is a
/// saffron bar on top of it, never a filled pill.
class AppShell extends StatelessWidget {
  const AppShell({required this.shell, super.key});

  final StatefulNavigationShell shell;

  void _go(int index) =>
      shell.goBranch(index, initialLocation: index == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
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
                  icon: Icons.home_outlined,
                  label: l10n.navHome,
                  selected: shell.currentIndex == 0,
                  onTap: () => _go(0),
                ),
                _Tab(
                  icon: Icons.folder_outlined,
                  label: l10n.navFiles,
                  selected: shell.currentIndex == 1,
                  onTap: () => _go(1),
                ),
                Expanded(
                  child: Center(
                    child: Semantics(
                      button: true,
                      label: l10n.navRecord,
                      excludeSemantics: true,
                      child: Material(
                        color: AppColors.accent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => context.push(Routes.record),
                          child: const SizedBox.square(
                            dimension: 56,
                            child: Icon(
                              Icons.mic_rounded,
                              color: AppColors.accentText,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _Tab(
                  icon: Icons.person_outline_rounded,
                  label: l10n.navProfile,
                  selected: shell.currentIndex == 2,
                  onTap: () => _go(2),
                ),
              ],
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
                Text(label, style: TextStyle(fontSize: 11, color: color)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
