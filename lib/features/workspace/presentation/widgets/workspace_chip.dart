import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/workspace/presentation/widgets/workspace_switcher_sheet.dart';

/// The current workspace's name; tap to switch.
class WorkspaceChip extends StatelessWidget {
  const WorkspaceChip({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.select<AccountCubit, String?>(
      (c) => c.state.account?.currentWorkspace?.name,
    );
    if (name == null) return const SizedBox.shrink();
    final radius = BorderRadius.circular(AppRadii.button);
    return Semantics(
      button: true,
      label: '${context.l10n.workspaceSwitchTitle}: $name',
      excludeSemantics: true,
      child: Material(
        color: AppColors.sf1,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: () => showWorkspaceSwitcher(context),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 40),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyMedium.copyWith(fontSize: 14),
                    ),
                  ),
                  const Icon(
                    Icons.expand_more_rounded,
                    size: 20,
                    color: AppColors.mutedDark,
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
