import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/initials_avatar.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';

/// Settings › Profil: who is signed in and how. Read-only for now — name
/// and password are changed on the web.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final user = context.select<AccountCubit, AppUser?>(
      (c) => c.state.account?.user,
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ContentWidth(
        child: user == null
            ? const SizedBox.shrink()
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                children: [
                  Center(
                    child: InitialsAvatar(
                      name: user.fullName,
                      fallback: user.email,
                      radius: 36,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ActionGroup(
                    children: [
                      if (user.fullName.trim().isNotEmpty)
                        ActionRow(
                          icon: Icons.badge_outlined,
                          label: l10n.profileName,
                          value: user.fullName.trim(),
                        ),
                      ActionRow(
                        icon: Icons.mail_outline_rounded,
                        label: l10n.profileEmail,
                        value: user.email,
                      ),
                      ActionRow(
                        icon: Icons.key_outlined,
                        label: l10n.profileSignIn,
                        value: user.hasPassword
                            ? l10n.profileSignInPassword
                            : l10n.profileSignInGoogle,
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
