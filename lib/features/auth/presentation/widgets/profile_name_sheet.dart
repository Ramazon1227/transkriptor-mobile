import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/application/profile_name_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/name_rules.dart';

/// Profil › name: one field, saved with `PATCH /me`. On success the
/// account everywhere (Studio greeting, settings header) shows the new
/// name and the sheet closes.
Future<void> showProfileNameSheet(BuildContext context, String current) {
  final account = context.read<AccountCubit>();
  final messenger = ScaffoldMessenger.maybeOf(context);
  final saved = context.l10n.profileNameSaved;
  return showAppSheet<void>(
    context,
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: account),
        BlocProvider(create: (_) => getIt<ProfileNameCubit>()),
      ],
      child: ProfileNameSheet(
        initial: current,
        onSaved: () => messenger
          ?..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(saved))),
      ),
    ),
  );
}

class ProfileNameSheet extends StatefulWidget {
  const ProfileNameSheet({required this.initial, this.onSaved, super.key});

  final String initial;
  final VoidCallback? onSaved;

  @override
  State<ProfileNameSheet> createState() => _ProfileNameSheetState();
}

class _ProfileNameSheetState extends State<ProfileNameSheet> {
  late final _field = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _field.dispose();
    super.dispose();
  }

  void _submit() =>
      unawaited(context.read<ProfileNameCubit>().save(_field.text));

  String? _error(AppLocalizations l10n, ProfileNameState state) {
    return switch (state.invalid) {
      NameError.empty => l10n.profileNameEmpty,
      NameError.tooLong => l10n.profileNameTooLong,
      null => state.failure?.message(l10n),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<ProfileNameCubit, ProfileNameState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (context, state) {
        final user = state.user;
        if (state.status != ProfileNameStatus.success || user == null) return;
        context.read<AccountCubit>().userUpdated(user);
        widget.onSaved?.call();
        Navigator.of(context).maybePop();
      },
      builder: (context, state) {
        final busy = state.status == ProfileNameStatus.saving;
        return AppSheet(
          title: l10n.profileNameEdit,
          footer: FilledButton(
            key: const Key('profile_name_save'),
            onPressed: busy ? null : _submit,
            child: busy
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.profileNameSave),
          ),
          child: TextField(
            key: const Key('profile_name_field'),
            controller: _field,
            enabled: !busy,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: l10n.profileName,
              errorText: _error(l10n, state),
              errorMaxLines: 3,
            ),
          ),
        );
      },
    );
  }
}
