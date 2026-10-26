import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart';

/// The three ways in: record (the main one, full width), file, link.
class EntryCards extends StatelessWidget {
  const EntryCards({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final picking = context.select<PickFileCubit, bool>(
      (c) => c.state.status == PickFileStatus.picking,
    );
    return Column(
      children: [
        _Card(
          onTap: () => context.push(Routes.record),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mic_rounded,
                  color: AppColors.accentText,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.homeRecordTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(l10n.homeRecordSubtitle, style: AppText.muted),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _SmallCard(
                icon: Icons.upload_rounded,
                title: l10n.homeUploadTitle,
                subtitle: l10n.homeUploadSubtitle,
                busy: picking,
                onTap: () => context.read<PickFileCubit>().pick(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SmallCard(
                icon: Icons.link_rounded,
                title: l10n.homeLinkTitle,
                subtitle: l10n.homeLinkSubtitle,
                onTap: () => context.push(Routes.link),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.sf1,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.card),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  const _SmallCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.busy = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return _Card(
      onTap: busy ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox.square(
            dimension: 22,
            child: busy
                ? const CircularProgressIndicator(strokeWidth: 2)
                : Icon(icon, color: AppColors.accent),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppText.muted.copyWith(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
