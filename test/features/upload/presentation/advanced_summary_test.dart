import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/advanced_settings_tile.dart';

void main() {
  final l10n = AppLocalizationsUz();
  const account = Account(
    user: AppUser(id: 'u1', email: 'a@misol.uz'),
    workspaces: [
      Workspace(id: 'w1', name: 'Shaxsiy', isPersonal: true),
      Workspace(id: 'w2', name: 'Jamoa'),
    ],
  );

  test('the no-folder place is «Mening fayllarim» only in the personal '
      'workspace; a team one is shared by every member', () {
    expect(destinationPersonal(account, 'w1'), isTrue);
    expect(destinationPersonal(account, 'w2'), isFalse);
    expect(
      advancedSummary(
        l10n,
        AdvancedOptions.initial(workspaceId: 'w1', workspaceName: 'Shaxsiy'),
        'w1',
        personal: true,
      ),
      'Mening fayllarim · ${l10n.advancedSummarySpeakersAuto}',
    );
    expect(
      advancedSummary(
        l10n,
        AdvancedOptions.initial(workspaceId: 'w2', workspaceName: 'Jamoa'),
        'w1',
        personal: false,
      ),
      '«Jamoa» › Umumiy fayllar · ${l10n.advancedSummarySpeakersAuto}',
    );
  });
}
