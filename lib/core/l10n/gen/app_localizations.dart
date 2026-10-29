import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('uz')];

  /// No description provided for @appTitle.
  ///
  /// In uz, this message translates to:
  /// **'Transkriptor'**
  String get appTitle;

  /// No description provided for @retry.
  ///
  /// In uz, this message translates to:
  /// **'Qayta urinish'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In uz, this message translates to:
  /// **'Yuklanmoqda'**
  String get loading;

  /// No description provided for @cancel.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilish'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In uz, this message translates to:
  /// **'Yopish'**
  String get close;

  /// No description provided for @back.
  ///
  /// In uz, this message translates to:
  /// **'Orqaga'**
  String get back;

  /// No description provided for @errorNetwork.
  ///
  /// In uz, this message translates to:
  /// **'Internetga ulanib boʻlmadi. Aloqani tekshiring.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In uz, this message translates to:
  /// **'Server javob bermadi. Birozdan keyin qayta urining.'**
  String get errorTimeout;

  /// No description provided for @errorUnauthorized.
  ///
  /// In uz, this message translates to:
  /// **'Sessiya tugadi. Qaytadan kiring.'**
  String get errorUnauthorized;

  /// No description provided for @errorServer.
  ///
  /// In uz, this message translates to:
  /// **'Serverda xatolik yuz berdi.'**
  String get errorServer;

  /// No description provided for @errorParsing.
  ///
  /// In uz, this message translates to:
  /// **'Serverdan kutilmagan javob keldi.'**
  String get errorParsing;

  /// No description provided for @errorUnknown.
  ///
  /// In uz, this message translates to:
  /// **'Nimadir notoʻgʻri ketdi.'**
  String get errorUnknown;

  /// No description provided for @errorMicPermission.
  ///
  /// In uz, this message translates to:
  /// **'Mikrofonga ruxsat berilmagan. Telefon sozlamalarida ruxsat bering.'**
  String get errorMicPermission;

  /// No description provided for @errorStorage.
  ///
  /// In uz, this message translates to:
  /// **'Faylni saqlab yoki oʻqib boʻlmadi.'**
  String get errorStorage;

  /// No description provided for @errorCaptureUnsupported.
  ///
  /// In uz, this message translates to:
  /// **'Ekran ovozini yozish Android 10 va undan yangi versiyalarda ishlaydi.'**
  String get errorCaptureUnsupported;

  /// No description provided for @errorCaptureConsent.
  ///
  /// In uz, this message translates to:
  /// **'Ekranni yozishga ruxsat berilmadi.'**
  String get errorCaptureConsent;

  /// No description provided for @errorCaptureBusy.
  ///
  /// In uz, this message translates to:
  /// **'Yozib olish allaqachon ketmoqda.'**
  String get errorCaptureBusy;

  /// No description provided for @errorCaptureFailed.
  ///
  /// In uz, this message translates to:
  /// **'Ekran ovozini yozib boʻlmadi. Baʼzi ilovalar (koʻpincha qoʻngʻiroq ilovalari) oʻz ovozini yozishga ruxsat bermaydi.'**
  String get errorCaptureFailed;

  /// No description provided for @errorNoBalance.
  ///
  /// In uz, this message translates to:
  /// **'Balansda daqiqa qolmagan.'**
  String get errorNoBalance;

  /// No description provided for @errorTooLarge.
  ///
  /// In uz, this message translates to:
  /// **'Fayl juda katta.'**
  String get errorTooLarge;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In uz, this message translates to:
  /// **'Juda koʻp urinish. Bir daqiqadan keyin qayta urining.'**
  String get errorTooManyRequests;

  /// No description provided for @navFiles.
  ///
  /// In uz, this message translates to:
  /// **'Fayllar'**
  String get navFiles;

  /// No description provided for @loginTitle.
  ///
  /// In uz, this message translates to:
  /// **'Ovozni matnga'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In uz, this message translates to:
  /// **'Oʻzbekcha nutq uchun transkripsiya. Hisobingizga kiring.'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In uz, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In uz, this message translates to:
  /// **'Parol'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In uz, this message translates to:
  /// **'Kirish'**
  String get loginButton;

  /// No description provided for @loginEmailRequired.
  ///
  /// In uz, this message translates to:
  /// **'Emailni kiriting'**
  String get loginEmailRequired;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In uz, this message translates to:
  /// **'Parolni kiriting'**
  String get loginPasswordRequired;

  /// No description provided for @loginWrongCredentials.
  ///
  /// In uz, this message translates to:
  /// **'Email yoki parol notoʻgʻri.'**
  String get loginWrongCredentials;

  /// No description provided for @showPassword.
  ///
  /// In uz, this message translates to:
  /// **'Parolni koʻrsatish'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In uz, this message translates to:
  /// **'Parolni yashirish'**
  String get hidePassword;

  /// No description provided for @loginNoAccount.
  ///
  /// In uz, this message translates to:
  /// **'Hisobingiz yoʻqmi?'**
  String get loginNoAccount;

  /// No description provided for @registerTitle.
  ///
  /// In uz, this message translates to:
  /// **'Hisob ochish'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In uz, this message translates to:
  /// **'Email va parol yetarli. Hisob ochilgach darhol kirasiz.'**
  String get registerSubtitle;

  /// No description provided for @registerName.
  ///
  /// In uz, this message translates to:
  /// **'Ism'**
  String get registerName;

  /// No description provided for @registerNameHint.
  ///
  /// In uz, this message translates to:
  /// **'Ixtiyoriy — transkriptlarda va jamoada koʻrinadi'**
  String get registerNameHint;

  /// No description provided for @registerEmailInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Email shakli notoʻgʻri'**
  String get registerEmailInvalid;

  /// No description provided for @registerEmailTaken.
  ///
  /// In uz, this message translates to:
  /// **'Bu email bilan hisob allaqachon bor. Kirib koʻring.'**
  String get registerEmailTaken;

  /// No description provided for @registerButton.
  ///
  /// In uz, this message translates to:
  /// **'Roʻyxatdan oʻtish'**
  String get registerButton;

  /// No description provided for @registerHaveAccount.
  ///
  /// In uz, this message translates to:
  /// **'Hisobingiz bormi?'**
  String get registerHaveAccount;

  /// No description provided for @passwordRules.
  ///
  /// In uz, this message translates to:
  /// **'Kamida 10 belgi: harf va kamida bitta raqam yoki belgi'**
  String get passwordRules;

  /// No description provided for @passwordTooShort.
  ///
  /// In uz, this message translates to:
  /// **'Parol kamida 10 belgi boʻlishi kerak'**
  String get passwordTooShort;

  /// No description provided for @passwordTooLong.
  ///
  /// In uz, this message translates to:
  /// **'Parol juda uzun (koʻpi bilan 72 bayt)'**
  String get passwordTooLong;

  /// No description provided for @passwordNeedsMix.
  ///
  /// In uz, this message translates to:
  /// **'Parolda harf va kamida bitta raqam yoki belgi boʻlishi kerak'**
  String get passwordNeedsMix;

  /// No description provided for @loginForgot.
  ///
  /// In uz, this message translates to:
  /// **'Parolni unutdingizmi?'**
  String get loginForgot;

  /// No description provided for @forgotTitle.
  ///
  /// In uz, this message translates to:
  /// **'Parolni tiklash'**
  String get forgotTitle;

  /// No description provided for @forgotSubtitle.
  ///
  /// In uz, this message translates to:
  /// **'Hisobingiz pochtasini kiriting — tiklash havolasini yuboramiz.'**
  String get forgotSubtitle;

  /// No description provided for @forgotSubmit.
  ///
  /// In uz, this message translates to:
  /// **'Havola yuborish'**
  String get forgotSubmit;

  /// No description provided for @forgotSentTitle.
  ///
  /// In uz, this message translates to:
  /// **'Pochtangizni tekshiring'**
  String get forgotSentTitle;

  /// No description provided for @forgotSentBody.
  ///
  /// In uz, this message translates to:
  /// **'Agar {email} bilan hisob boʻlsa, unga parolni tiklash havolasi yuborildi.'**
  String forgotSentBody(String email);

  /// No description provided for @forgotSentHint.
  ///
  /// In uz, this message translates to:
  /// **'Havola brauzerda ochiladi: yangi parolni oʻsha yerda oʻrnatib, shu ilovaga qayta kiring. U faqat bir marta ishlaydi, muddati xatda yozilgan. Xat kelmasa, «Spam» papkasini koʻring yoki bir daqiqadan keyin qayta soʻrang.'**
  String get forgotSentHint;

  /// No description provided for @forgotSendAgain.
  ///
  /// In uz, this message translates to:
  /// **'Qayta yuborish'**
  String get forgotSendAgain;

  /// No description provided for @forgotRemembered.
  ///
  /// In uz, this message translates to:
  /// **'Parol esingizga tushdimi?'**
  String get forgotRemembered;

  /// No description provided for @forgotUnavailable.
  ///
  /// In uz, this message translates to:
  /// **'Parolni tiklash hozircha ishlamaydi — pochta xizmati ulanmagan.'**
  String get forgotUnavailable;

  /// No description provided for @homeRecent.
  ///
  /// In uz, this message translates to:
  /// **'Soʻnggi fayllar'**
  String get homeRecent;

  /// No description provided for @homeSeeAll.
  ///
  /// In uz, this message translates to:
  /// **'Hammasi'**
  String get homeSeeAll;

  /// No description provided for @balanceLabel.
  ///
  /// In uz, this message translates to:
  /// **'Balans'**
  String get balanceLabel;

  /// No description provided for @minutesShort.
  ///
  /// In uz, this message translates to:
  /// **'{minutes} daq'**
  String minutesShort(int minutes);

  /// No description provided for @loginOr.
  ///
  /// In uz, this message translates to:
  /// **'yoki'**
  String get loginOr;

  /// No description provided for @loginGoogle.
  ///
  /// In uz, this message translates to:
  /// **'Google bilan kirish'**
  String get loginGoogle;

  /// No description provided for @loginGoogleUnverified.
  ///
  /// In uz, this message translates to:
  /// **'Google bu pochtani tasdiqlamagan — email va parol bilan kiring.'**
  String get loginGoogleUnverified;

  /// No description provided for @loginGoogleRejected.
  ///
  /// In uz, this message translates to:
  /// **'Google kirishi tasdiqlanmadi. Qaytadan urinib koʻring.'**
  String get loginGoogleRejected;

  /// No description provided for @loginGoogleDisabled.
  ///
  /// In uz, this message translates to:
  /// **'Google bilan kirish serverda yoqilmagan.'**
  String get loginGoogleDisabled;

  /// No description provided for @loginGoogleUnavailable.
  ///
  /// In uz, this message translates to:
  /// **'Google hozir javob bermayapti. Birozdan keyin urinib koʻring.'**
  String get loginGoogleUnavailable;

  /// No description provided for @loginGoogleFailed.
  ///
  /// In uz, this message translates to:
  /// **'Google bilan kirib boʻlmadi. Telefonda Google Play xizmatlari borligini tekshiring.'**
  String get loginGoogleFailed;

  /// No description provided for @filesTitle.
  ///
  /// In uz, this message translates to:
  /// **'Fayllar'**
  String get filesTitle;

  /// No description provided for @filesEmptyTitle.
  ///
  /// In uz, this message translates to:
  /// **'Hali fayl yoʻq'**
  String get filesEmptyTitle;

  /// No description provided for @filesEmptyBody.
  ///
  /// In uz, this message translates to:
  /// **'Birinchi suhbatni yozib oling yoki telefoningizdagi audio faylni yuklang. Natija shu yerda paydo boʻladi.'**
  String get filesEmptyBody;

  /// No description provided for @filesAll.
  ///
  /// In uz, this message translates to:
  /// **'Hammasi'**
  String get filesAll;

  /// No description provided for @filesFolderEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Papka boʻsh.'**
  String get filesFolderEmpty;

  /// No description provided for @filesFolderEmptyHint.
  ///
  /// In uz, this message translates to:
  /// **'Faylni bosib turing va «Papkaga koʻchirish»ni tanlang.'**
  String get filesFolderEmptyHint;

  /// No description provided for @filesTagAll.
  ///
  /// In uz, this message translates to:
  /// **'Teg: hammasi'**
  String get filesTagAll;

  /// No description provided for @filesForbidden.
  ///
  /// In uz, this message translates to:
  /// **'Bu ish maydonida fayllarni oʻzgartirish huquqingiz yoʻq.'**
  String get filesForbidden;

  /// No description provided for @folderNew.
  ///
  /// In uz, this message translates to:
  /// **'Papka'**
  String get folderNew;

  /// No description provided for @folderCreateTitle.
  ///
  /// In uz, this message translates to:
  /// **'Yangi papka'**
  String get folderCreateTitle;

  /// No description provided for @folderRenameTitle.
  ///
  /// In uz, this message translates to:
  /// **'Papkani qayta nomlash'**
  String get folderRenameTitle;

  /// No description provided for @folderNameHint.
  ///
  /// In uz, this message translates to:
  /// **'Papka nomi'**
  String get folderNameHint;

  /// No description provided for @folderNameInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Nom boʻsh boʻlmasin va {max} belgidan oshmasin.'**
  String folderNameInvalid(int max);

  /// No description provided for @folderExists.
  ///
  /// In uz, this message translates to:
  /// **'Shu nomli papka allaqachon bor yoki papkalar soni chegarasiga yetgan.'**
  String get folderExists;

  /// No description provided for @folderRename.
  ///
  /// In uz, this message translates to:
  /// **'Nomini oʻzgartirish'**
  String get folderRename;

  /// No description provided for @folderDelete.
  ///
  /// In uz, this message translates to:
  /// **'Oʻchirish'**
  String get folderDelete;

  /// No description provided for @folderDeleteTitle.
  ///
  /// In uz, this message translates to:
  /// **'Papkani oʻchirish'**
  String get folderDeleteTitle;

  /// No description provided for @folderDeleteBody.
  ///
  /// In uz, this message translates to:
  /// **'«{name}» papkasi oʻchadi. Ichidagi {count} ta fayl oʻchmaydi — papkasiz qoladi va «Hammasi»da koʻrinadi.'**
  String folderDeleteBody(String name, int count);

  /// No description provided for @folderDeleteEmptyBody.
  ///
  /// In uz, this message translates to:
  /// **'«{name}» papkasi oʻchadi. Papka boʻsh.'**
  String folderDeleteEmptyBody(String name);

  /// No description provided for @folderNone.
  ///
  /// In uz, this message translates to:
  /// **'Papkasiz'**
  String get folderNone;

  /// No description provided for @folderGone.
  ///
  /// In uz, this message translates to:
  /// **'Papka topilmadi — u boshqa joyda oʻchirilgan boʻlishi mumkin. Roʻyxatni yangilang.'**
  String get folderGone;

  /// No description provided for @fileMove.
  ///
  /// In uz, this message translates to:
  /// **'Papkaga koʻchirish'**
  String get fileMove;

  /// No description provided for @fileTags.
  ///
  /// In uz, this message translates to:
  /// **'Teglar'**
  String get fileTags;

  /// No description provided for @tagNewHint.
  ///
  /// In uz, this message translates to:
  /// **'Yangi teg'**
  String get tagNewHint;

  /// No description provided for @tagAdd.
  ///
  /// In uz, this message translates to:
  /// **'Qoʻshish'**
  String get tagAdd;

  /// No description provided for @tagInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Teg boʻsh boʻlmasin, vergul boʻlmasin va {max} belgidan oshmasin.'**
  String tagInvalid(int max);

  /// No description provided for @tagTooMany.
  ///
  /// In uz, this message translates to:
  /// **'Bir faylda koʻpi bilan {max} ta teg.'**
  String tagTooMany(int max);

  /// No description provided for @tagsNone.
  ///
  /// In uz, this message translates to:
  /// **'Teglar yoʻq'**
  String get tagsNone;

  /// No description provided for @actionSave.
  ///
  /// In uz, this message translates to:
  /// **'Saqlash'**
  String get actionSave;

  /// No description provided for @statusQueued.
  ///
  /// In uz, this message translates to:
  /// **'Navbatda'**
  String get statusQueued;

  /// No description provided for @statusRunning.
  ///
  /// In uz, this message translates to:
  /// **'Ishlanmoqda'**
  String get statusRunning;

  /// No description provided for @statusDone.
  ///
  /// In uz, this message translates to:
  /// **'Tayyor'**
  String get statusDone;

  /// No description provided for @statusFailed.
  ///
  /// In uz, this message translates to:
  /// **'Xato'**
  String get statusFailed;

  /// No description provided for @statusCancelled.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilingan'**
  String get statusCancelled;

  /// No description provided for @statusSaved.
  ///
  /// In uz, this message translates to:
  /// **'Saqlangan'**
  String get statusSaved;

  /// No description provided for @sourceUpload.
  ///
  /// In uz, this message translates to:
  /// **'Yuklangan'**
  String get sourceUpload;

  /// No description provided for @sourceRecording.
  ///
  /// In uz, this message translates to:
  /// **'Yozib olingan'**
  String get sourceRecording;

  /// No description provided for @sourceYoutube.
  ///
  /// In uz, this message translates to:
  /// **'YouTube'**
  String get sourceYoutube;

  /// No description provided for @sourceDrive.
  ///
  /// In uz, this message translates to:
  /// **'Google Drive'**
  String get sourceDrive;

  /// No description provided for @sourceDropbox.
  ///
  /// In uz, this message translates to:
  /// **'Dropbox'**
  String get sourceDropbox;

  /// No description provided for @sourceLink.
  ///
  /// In uz, this message translates to:
  /// **'Havola'**
  String get sourceLink;

  /// No description provided for @sourceApi.
  ///
  /// In uz, this message translates to:
  /// **'API'**
  String get sourceApi;

  /// No description provided for @kindVideo.
  ///
  /// In uz, this message translates to:
  /// **'video'**
  String get kindVideo;

  /// No description provided for @kindAudio.
  ///
  /// In uz, this message translates to:
  /// **'audio'**
  String get kindAudio;

  /// No description provided for @recorderReady.
  ///
  /// In uz, this message translates to:
  /// **'Yozishga tayyor'**
  String get recorderReady;

  /// No description provided for @recorderStarting.
  ///
  /// In uz, this message translates to:
  /// **'Mikrofon ochilmoqda…'**
  String get recorderStarting;

  /// No description provided for @recorderRecording.
  ///
  /// In uz, this message translates to:
  /// **'Yozilmoqda'**
  String get recorderRecording;

  /// No description provided for @recorderPaused.
  ///
  /// In uz, this message translates to:
  /// **'Pauza'**
  String get recorderPaused;

  /// No description provided for @recorderStart.
  ///
  /// In uz, this message translates to:
  /// **'Boshlash'**
  String get recorderStart;

  /// No description provided for @recorderPause.
  ///
  /// In uz, this message translates to:
  /// **'Pauza'**
  String get recorderPause;

  /// No description provided for @recorderResume.
  ///
  /// In uz, this message translates to:
  /// **'Davom etish'**
  String get recorderResume;

  /// No description provided for @recorderStop.
  ///
  /// In uz, this message translates to:
  /// **'Tugatish'**
  String get recorderStop;

  /// No description provided for @recorderFormat.
  ///
  /// In uz, this message translates to:
  /// **'AAC · 16 kGs · mono'**
  String get recorderFormat;

  /// No description provided for @recorderDiscardTitle.
  ///
  /// In uz, this message translates to:
  /// **'Yozuv oʻchirilsinmi?'**
  String get recorderDiscardTitle;

  /// No description provided for @recorderDiscardBody.
  ///
  /// In uz, this message translates to:
  /// **'Yozib olingan ovoz saqlanmaydi.'**
  String get recorderDiscardBody;

  /// No description provided for @recorderDiscardConfirm.
  ///
  /// In uz, this message translates to:
  /// **'Oʻchirish'**
  String get recorderDiscardConfirm;

  /// No description provided for @recorderKeep.
  ///
  /// In uz, this message translates to:
  /// **'Yozishni davom ettirish'**
  String get recorderKeep;

  /// No description provided for @recordingName.
  ///
  /// In uz, this message translates to:
  /// **'Yozuv {date}'**
  String recordingName(String date);

  /// No description provided for @sendTitle.
  ///
  /// In uz, this message translates to:
  /// **'Yuborish'**
  String get sendTitle;

  /// No description provided for @sendName.
  ///
  /// In uz, this message translates to:
  /// **'Nomi'**
  String get sendName;

  /// No description provided for @sendRecorded.
  ///
  /// In uz, this message translates to:
  /// **'Yozib olingan'**
  String get sendRecorded;

  /// No description provided for @sendPicked.
  ///
  /// In uz, this message translates to:
  /// **'Tanlangan fayl'**
  String get sendPicked;

  /// No description provided for @sizeMb.
  ///
  /// In uz, this message translates to:
  /// **'{size} MB'**
  String sizeMb(String size);

  /// No description provided for @speakersLabel.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachilar soni'**
  String get speakersLabel;

  /// No description provided for @speakersAuto.
  ///
  /// In uz, this message translates to:
  /// **'Avto'**
  String get speakersAuto;

  /// No description provided for @speakersHint.
  ///
  /// In uz, this message translates to:
  /// **'Bilsangiz koʻrsating — ajratish aniqroq boʻladi.'**
  String get speakersHint;

  /// No description provided for @sendThisFile.
  ///
  /// In uz, this message translates to:
  /// **'Bu fayl'**
  String get sendThisFile;

  /// No description provided for @sendApproxMinutes.
  ///
  /// In uz, this message translates to:
  /// **'≈ {minutes} daq'**
  String sendApproxMinutes(int minutes);

  /// No description provided for @sendUploadFree.
  ///
  /// In uz, this message translates to:
  /// **'Yuklash daqiqa sarflamaydi — daqiqa transkripsiya boshlanganda band qilinadi.'**
  String get sendUploadFree;

  /// No description provided for @sendStart.
  ///
  /// In uz, this message translates to:
  /// **'Transkripsiyani boshlash'**
  String get sendStart;

  /// No description provided for @sendSaveOnly.
  ///
  /// In uz, this message translates to:
  /// **'Faqat saqlash'**
  String get sendSaveOnly;

  /// No description provided for @sendUploading.
  ///
  /// In uz, this message translates to:
  /// **'Yuklanmoqda · {percent}%'**
  String sendUploading(int percent);

  /// No description provided for @sendSaved.
  ///
  /// In uz, this message translates to:
  /// **'Fayl saqlandi.'**
  String get sendSaved;

  /// No description provided for @sendStoredNotStarted.
  ///
  /// In uz, this message translates to:
  /// **'Fayl saqlandi, lekin transkripsiya boshlanmadi. Daqiqa band qilinmadi.'**
  String get sendStoredNotStarted;

  /// No description provided for @sendGoToFiles.
  ///
  /// In uz, this message translates to:
  /// **'Fayllarga oʻtish'**
  String get sendGoToFiles;

  /// No description provided for @linkTitle.
  ///
  /// In uz, this message translates to:
  /// **'Havola orqali'**
  String get linkTitle;

  /// No description provided for @linkLabel.
  ///
  /// In uz, this message translates to:
  /// **'Havola'**
  String get linkLabel;

  /// No description provided for @linkPaste.
  ///
  /// In uz, this message translates to:
  /// **'Qoʻyish'**
  String get linkPaste;

  /// No description provided for @linkInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Bu havolani ochib boʻlmaydi. YouTube, Google Drive yoki Dropbox havolasini kiriting.'**
  String get linkInvalid;

  /// No description provided for @linkWhich.
  ///
  /// In uz, this message translates to:
  /// **'Qaysi havolalar ishlaydi'**
  String get linkWhich;

  /// No description provided for @linkYoutubeBody.
  ///
  /// In uz, this message translates to:
  /// **'video yoki Shorts'**
  String get linkYoutubeBody;

  /// No description provided for @linkDriveBody.
  ///
  /// In uz, this message translates to:
  /// **'«havolasi borlar» uchun ochiq fayl'**
  String get linkDriveBody;

  /// No description provided for @linkDropboxBody.
  ///
  /// In uz, this message translates to:
  /// **'ommaviy havola'**
  String get linkDropboxBody;

  /// No description provided for @linkServerFetches.
  ///
  /// In uz, this message translates to:
  /// **'Faylni server oʻzi yuklab oladi — telefon trafigi sarflanmaydi.'**
  String get linkServerFetches;

  /// No description provided for @jobKeepsRunning.
  ///
  /// In uz, this message translates to:
  /// **'Ilovani yopsangiz ham ish davom etadi — tayyor transkript Fayllar boʻlimida paydo boʻladi.'**
  String get jobKeepsRunning;

  /// No description provided for @jobQueuedHint.
  ///
  /// In uz, this message translates to:
  /// **'Navbatda turibdi — tez orada boshlanadi.'**
  String get jobQueuedHint;

  /// No description provided for @jobCancel.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilish'**
  String get jobCancel;

  /// No description provided for @jobCancelNote.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilsangiz band qilingan daqiqalar qaytariladi.'**
  String get jobCancelNote;

  /// No description provided for @jobDoneTitle.
  ///
  /// In uz, this message translates to:
  /// **'Transkript tayyor'**
  String get jobDoneTitle;

  /// No description provided for @jobOpenTranscript.
  ///
  /// In uz, this message translates to:
  /// **'Transkriptni ochish'**
  String get jobOpenTranscript;

  /// No description provided for @jobFailedTitle.
  ///
  /// In uz, this message translates to:
  /// **'Transkripsiya bajarilmadi'**
  String get jobFailedTitle;

  /// No description provided for @jobFailedRefund.
  ///
  /// In uz, this message translates to:
  /// **'Band qilingan daqiqalar balansga qaytarildi.'**
  String get jobFailedRefund;

  /// No description provided for @jobCancelledTitle.
  ///
  /// In uz, this message translates to:
  /// **'Transkripsiya bekor qilindi'**
  String get jobCancelledTitle;

  /// No description provided for @transcriptAll.
  ///
  /// In uz, this message translates to:
  /// **'Hammasi'**
  String get transcriptAll;

  /// No description provided for @transcriptEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Bu yozuvda nutq topilmadi.'**
  String get transcriptEmpty;

  /// No description provided for @transcriptNoSpeaker.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachi'**
  String get transcriptNoSpeaker;

  /// No description provided for @transcriptSpeakers.
  ///
  /// In uz, this message translates to:
  /// **'{count} maʼruzachi'**
  String transcriptSpeakers(int count);

  /// No description provided for @transcriptEdited.
  ///
  /// In uz, this message translates to:
  /// **'tahrirlangan'**
  String get transcriptEdited;

  /// No description provided for @transcriptEditSegment.
  ///
  /// In uz, this message translates to:
  /// **'Matnni tahrirlash'**
  String get transcriptEditSegment;

  /// No description provided for @transcriptRenameSpeaker.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachi nomi'**
  String get transcriptRenameSpeaker;

  /// No description provided for @transcriptSave.
  ///
  /// In uz, this message translates to:
  /// **'Saqlash'**
  String get transcriptSave;

  /// No description provided for @transcriptTextTooLong.
  ///
  /// In uz, this message translates to:
  /// **'Matn juda uzun.'**
  String get transcriptTextTooLong;

  /// No description provided for @transcriptLabelTooLong.
  ///
  /// In uz, this message translates to:
  /// **'Nom juda uzun.'**
  String get transcriptLabelTooLong;

  /// No description provided for @transcriptEditForbidden.
  ///
  /// In uz, this message translates to:
  /// **'Bu ish maydonida faqat oʻqish huquqingiz bor.'**
  String get transcriptEditForbidden;

  /// No description provided for @transcriptEditStale.
  ///
  /// In uz, this message translates to:
  /// **'Transkript boshqa joyda oʻzgartirildi, yangi nusxasi yuklandi. Matningizni tekshirib, yana saqlang.'**
  String get transcriptEditStale;

  /// No description provided for @transcriptEditInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Saqlab boʻlmadi: matn qabul qilinmadi.'**
  String get transcriptEditInvalid;

  /// No description provided for @transcriptEditGone.
  ///
  /// In uz, this message translates to:
  /// **'Bu qism transkriptdan oʻchirilgan.'**
  String get transcriptEditGone;

  /// No description provided for @transcriptEditUnprocessable.
  ///
  /// In uz, this message translates to:
  /// **'Bu amalni bajarib boʻlmadi. Transkriptni yangilab, qayta urinib koʻring.'**
  String get transcriptEditUnprocessable;

  /// No description provided for @transcriptAssignSpeaker.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachi'**
  String get transcriptAssignSpeaker;

  /// No description provided for @transcriptNewSpeaker.
  ///
  /// In uz, this message translates to:
  /// **'Yangi maʼruzachi'**
  String get transcriptNewSpeaker;

  /// No description provided for @transcriptSplit.
  ///
  /// In uz, this message translates to:
  /// **'Kursor joyida boʻlish'**
  String get transcriptSplit;

  /// No description provided for @transcriptMergeNext.
  ///
  /// In uz, this message translates to:
  /// **'Keyingisi bilan qoʻshish'**
  String get transcriptMergeNext;

  /// No description provided for @shareTitle.
  ///
  /// In uz, this message translates to:
  /// **'Ulashish'**
  String get shareTitle;

  /// No description provided for @shareOpen.
  ///
  /// In uz, this message translates to:
  /// **'Havola ochish'**
  String get shareOpen;

  /// No description provided for @shareIncludeMedia.
  ///
  /// In uz, this message translates to:
  /// **'Audio ham koʻrinsin'**
  String get shareIncludeMedia;

  /// No description provided for @shareIncludeMediaHint.
  ///
  /// In uz, this message translates to:
  /// **'Oʻchirilsa, faqat matn oʻqiladi — ovoz yuklanmaydi.'**
  String get shareIncludeMediaHint;

  /// No description provided for @shareExpiry.
  ///
  /// In uz, this message translates to:
  /// **'Muddati'**
  String get shareExpiry;

  /// No description provided for @shareDays.
  ///
  /// In uz, this message translates to:
  /// **'{count} kun'**
  String shareDays(int count);

  /// No description provided for @shareOneYear.
  ///
  /// In uz, this message translates to:
  /// **'1 yil'**
  String get shareOneYear;

  /// No description provided for @shareNoExpiry.
  ///
  /// In uz, this message translates to:
  /// **'Muddatsiz'**
  String get shareNoExpiry;

  /// No description provided for @shareLinkLabel.
  ///
  /// In uz, this message translates to:
  /// **'Havola'**
  String get shareLinkLabel;

  /// No description provided for @shareCopy.
  ///
  /// In uz, this message translates to:
  /// **'Nusxa olish'**
  String get shareCopy;

  /// No description provided for @shareCopied.
  ///
  /// In uz, this message translates to:
  /// **'Nusxalandi'**
  String get shareCopied;

  /// No description provided for @shareShownOnce.
  ///
  /// In uz, this message translates to:
  /// **'Bu havola faqat hozir koʻrinadi — bazada tokenning xeshi saqlanadi. Yopgandan keyin qayta olinmaydi.'**
  String get shareShownOnce;

  /// No description provided for @shareActive.
  ///
  /// In uz, this message translates to:
  /// **'Amaldagi havolalar'**
  String get shareActive;

  /// No description provided for @shareUntil.
  ///
  /// In uz, this message translates to:
  /// **'{date} gacha'**
  String shareUntil(String date);

  /// No description provided for @shareNoExpiryShort.
  ///
  /// In uz, this message translates to:
  /// **'muddatsiz'**
  String get shareNoExpiryShort;

  /// No description provided for @shareViews.
  ///
  /// In uz, this message translates to:
  /// **'{count} marta ochilgan'**
  String shareViews(int count);

  /// No description provided for @shareWithAudio.
  ///
  /// In uz, this message translates to:
  /// **'audio bilan'**
  String get shareWithAudio;

  /// No description provided for @shareRevoke.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilish'**
  String get shareRevoke;

  /// No description provided for @shareForbidden.
  ///
  /// In uz, this message translates to:
  /// **'Bu ish maydonida havola ochish huquqingiz yoʻq.'**
  String get shareForbidden;

  /// No description provided for @exportTitle.
  ///
  /// In uz, this message translates to:
  /// **'Eksport'**
  String get exportTitle;

  /// No description provided for @exportTimecodes.
  ///
  /// In uz, this message translates to:
  /// **'Vaqt belgilari'**
  String get exportTimecodes;

  /// No description provided for @exportSpeakers.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachi nomlari'**
  String get exportSpeakers;

  /// No description provided for @exportPlainApostrophe.
  ///
  /// In uz, this message translates to:
  /// **'Oddiy apostrof (o\'zbek, ta\'lim)'**
  String get exportPlainApostrophe;

  /// No description provided for @exportPlainApostropheHint.
  ///
  /// In uz, this message translates to:
  /// **'Koʻp odam shu belgi bilan qidiradi va yozadi. Saqlangan matn oʻzgarmaydi.'**
  String get exportPlainApostropheHint;

  /// No description provided for @exportShare.
  ///
  /// In uz, this message translates to:
  /// **'Faylni saqlash yoki yuborish'**
  String get exportShare;

  /// No description provided for @exportLayout.
  ///
  /// In uz, this message translates to:
  /// **'Matn tuzilishi'**
  String get exportLayout;

  /// No description provided for @exportLayoutSegments.
  ///
  /// In uz, this message translates to:
  /// **'Segmentlar'**
  String get exportLayoutSegments;

  /// No description provided for @exportLayoutSpeaker.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachi boʻyicha'**
  String get exportLayoutSpeaker;

  /// No description provided for @exportLayoutParagraphs.
  ///
  /// In uz, this message translates to:
  /// **'Paragraflar'**
  String get exportLayoutParagraphs;

  /// No description provided for @exportLayoutSingle.
  ///
  /// In uz, this message translates to:
  /// **'Bitta paragraf'**
  String get exportLayoutSingle;

  /// No description provided for @exportSentences.
  ///
  /// In uz, this message translates to:
  /// **'Paragrafda gap'**
  String get exportSentences;

  /// No description provided for @exportSentenceCount.
  ///
  /// In uz, this message translates to:
  /// **'{count} ta gap'**
  String exportSentenceCount(int count);

  /// No description provided for @profileTitle.
  ///
  /// In uz, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @profileLogout.
  ///
  /// In uz, this message translates to:
  /// **'Chiqish'**
  String get profileLogout;

  /// No description provided for @profileLogoutTitle.
  ///
  /// In uz, this message translates to:
  /// **'Hisobdan chiqasizmi?'**
  String get profileLogoutTitle;

  /// No description provided for @navStudio.
  ///
  /// In uz, this message translates to:
  /// **'Studio'**
  String get navStudio;

  /// No description provided for @navNew.
  ///
  /// In uz, this message translates to:
  /// **'Yangi transkripsiya'**
  String get navNew;

  /// No description provided for @comingSoon.
  ///
  /// In uz, this message translates to:
  /// **'Tez orada'**
  String get comingSoon;

  /// No description provided for @comingSoonBody.
  ///
  /// In uz, this message translates to:
  /// **'Bu imkoniyat ustida ishlayapmiz. Hozircha boshqa usullardan foydalaning.'**
  String get comingSoonBody;

  /// No description provided for @demoBanner.
  ///
  /// In uz, this message translates to:
  /// **'Namuna — server hali tayyor emas'**
  String get demoBanner;

  /// No description provided for @sourceSheetTitle.
  ///
  /// In uz, this message translates to:
  /// **'Boshlash'**
  String get sourceSheetTitle;

  /// No description provided for @sourceUploadTitle.
  ///
  /// In uz, this message translates to:
  /// **'Fayl yuklash'**
  String get sourceUploadTitle;

  /// No description provided for @sourceUploadBody.
  ///
  /// In uz, this message translates to:
  /// **'Telefondagi audio yoki videoni matnga aylantiring'**
  String get sourceUploadBody;

  /// No description provided for @sourceYoutubeTitle.
  ///
  /// In uz, this message translates to:
  /// **'YouTubeʼdan'**
  String get sourceYoutubeTitle;

  /// No description provided for @sourceYoutubeBody.
  ///
  /// In uz, this message translates to:
  /// **'Video havolasini qoʻying — server oʻzi yuklab oladi'**
  String get sourceYoutubeBody;

  /// No description provided for @sourceRecordTitle.
  ///
  /// In uz, this message translates to:
  /// **'Audio yozib olish'**
  String get sourceRecordTitle;

  /// No description provided for @sourceRecordBody.
  ///
  /// In uz, this message translates to:
  /// **'Suhbat, majlis, maʼruza — telefon mikrofonidan'**
  String get sourceRecordBody;

  /// No description provided for @sourceDictationTitle.
  ///
  /// In uz, this message translates to:
  /// **'Jonli diktovka'**
  String get sourceDictationTitle;

  /// No description provided for @sourceDictationBody.
  ///
  /// In uz, this message translates to:
  /// **'Gapiring — matn shu zahoti paydo boʻladi'**
  String get sourceDictationBody;

  /// No description provided for @sourceRealtimeBadge.
  ///
  /// In uz, this message translates to:
  /// **'Real vaqt'**
  String get sourceRealtimeBadge;

  /// No description provided for @sourceScreenTitle.
  ///
  /// In uz, this message translates to:
  /// **'Ekranni yozish'**
  String get sourceScreenTitle;

  /// No description provided for @sourceScreenBody.
  ///
  /// In uz, this message translates to:
  /// **'Ekrandagi video va ovozni yozib, matnga aylantiring'**
  String get sourceScreenBody;

  /// No description provided for @sourceCloudTitle.
  ///
  /// In uz, this message translates to:
  /// **'Bulutdan'**
  String get sourceCloudTitle;

  /// No description provided for @sourceCloudBody.
  ///
  /// In uz, this message translates to:
  /// **'Google Drive yoki Dropbox havolasi'**
  String get sourceCloudBody;

  /// No description provided for @sourceMeetingTitle.
  ///
  /// In uz, this message translates to:
  /// **'Onlayn uchrashuv'**
  String get sourceMeetingTitle;

  /// No description provided for @sourceMeetingBody.
  ///
  /// In uz, this message translates to:
  /// **'Google Meet uchrashuvini yozib olish'**
  String get sourceMeetingBody;

  /// No description provided for @sourceUrlTitle.
  ///
  /// In uz, this message translates to:
  /// **'Havola orqali'**
  String get sourceUrlTitle;

  /// No description provided for @sourceUrlBody.
  ///
  /// In uz, this message translates to:
  /// **'Internetdagi audio yoki video faylning havolasi'**
  String get sourceUrlBody;

  /// No description provided for @homeWelcome.
  ///
  /// In uz, this message translates to:
  /// **'Xush kelibsiz, {name}'**
  String homeWelcome(String name);

  /// No description provided for @homeWelcomeNoName.
  ///
  /// In uz, this message translates to:
  /// **'Xush kelibsiz'**
  String get homeWelcomeNoName;

  /// No description provided for @homeCardRecord.
  ///
  /// In uz, this message translates to:
  /// **'Yozib olish'**
  String get homeCardRecord;

  /// No description provided for @homeCalendar.
  ///
  /// In uz, this message translates to:
  /// **'Kalendar'**
  String get homeCalendar;

  /// No description provided for @calendarNotConnected.
  ///
  /// In uz, this message translates to:
  /// **'Google Kalendar veb-ilovada ulanadi. Ulangach, yaqin uchrashuvlar shu yerda koʻrinadi.'**
  String get calendarNotConnected;

  /// No description provided for @calendarEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Yaqin kunlarda uchrashuv yoʻq.'**
  String get calendarEmpty;

  /// No description provided for @calendarToday.
  ///
  /// In uz, this message translates to:
  /// **'Bugun, {time}'**
  String calendarToday(String time);

  /// No description provided for @settingsTitle.
  ///
  /// In uz, this message translates to:
  /// **'Sozlamalar'**
  String get settingsTitle;

  /// No description provided for @settingsAccount.
  ///
  /// In uz, this message translates to:
  /// **'Hisob'**
  String get settingsAccount;

  /// No description provided for @settingsBalance.
  ///
  /// In uz, this message translates to:
  /// **'Balans'**
  String get settingsBalance;

  /// No description provided for @settingsPlan.
  ///
  /// In uz, this message translates to:
  /// **'Tarif'**
  String get settingsPlan;

  /// No description provided for @settingsPlans.
  ///
  /// In uz, this message translates to:
  /// **'Tariflar'**
  String get settingsPlans;

  /// No description provided for @settingsProfile.
  ///
  /// In uz, this message translates to:
  /// **'Profil'**
  String get settingsProfile;

  /// No description provided for @settingsWorkspace.
  ///
  /// In uz, this message translates to:
  /// **'Ish maydoni'**
  String get settingsWorkspace;

  /// No description provided for @settingsApp.
  ///
  /// In uz, this message translates to:
  /// **'Ilova'**
  String get settingsApp;

  /// No description provided for @settingsLanguage.
  ///
  /// In uz, this message translates to:
  /// **'Til'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageUzbek.
  ///
  /// In uz, this message translates to:
  /// **'Oʻzbekcha'**
  String get settingsLanguageUzbek;

  /// No description provided for @settingsNotifications.
  ///
  /// In uz, this message translates to:
  /// **'Bildirishnomalar'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsOn.
  ///
  /// In uz, this message translates to:
  /// **'Yoqilgan'**
  String get settingsNotificationsOn;

  /// No description provided for @settingsNotificationsOff.
  ///
  /// In uz, this message translates to:
  /// **'Bu versiyada sozlanmagan'**
  String get settingsNotificationsOff;

  /// No description provided for @settingsHelp.
  ///
  /// In uz, this message translates to:
  /// **'Yordam'**
  String get settingsHelp;

  /// No description provided for @settingsHelpCenter.
  ///
  /// In uz, this message translates to:
  /// **'Yordam markazi'**
  String get settingsHelpCenter;

  /// No description provided for @settingsReportBug.
  ///
  /// In uz, this message translates to:
  /// **'Xato haqida xabar berish'**
  String get settingsReportBug;

  /// No description provided for @settingsPrivacy.
  ///
  /// In uz, this message translates to:
  /// **'Maxfiylik siyosati'**
  String get settingsPrivacy;

  /// No description provided for @settingsTerms.
  ///
  /// In uz, this message translates to:
  /// **'Foydalanish shartlari'**
  String get settingsTerms;

  /// No description provided for @settingsVersion.
  ///
  /// In uz, this message translates to:
  /// **'Versiya'**
  String get settingsVersion;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In uz, this message translates to:
  /// **'Hisobni oʻchirish'**
  String get settingsDeleteAccount;

  /// No description provided for @linkOpenFailedCopied.
  ///
  /// In uz, this message translates to:
  /// **'Havolani ochib boʻlmadi — nusxasi olindi. Brauzerga qoʻyib oching.'**
  String get linkOpenFailedCopied;

  /// No description provided for @planStatusActive.
  ///
  /// In uz, this message translates to:
  /// **'Faol'**
  String get planStatusActive;

  /// No description provided for @planStatusPastDue.
  ///
  /// In uz, this message translates to:
  /// **'Toʻlov kutilmoqda'**
  String get planStatusPastDue;

  /// No description provided for @planStatusCancelled.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilingan'**
  String get planStatusCancelled;

  /// No description provided for @planStatusExpired.
  ///
  /// In uz, this message translates to:
  /// **'Muddati tugagan'**
  String get planStatusExpired;

  /// No description provided for @planRenews.
  ///
  /// In uz, this message translates to:
  /// **'{date} da yangilanadi'**
  String planRenews(String date);

  /// No description provided for @planEnds.
  ///
  /// In uz, this message translates to:
  /// **'{date} da tugaydi'**
  String planEnds(String date);

  /// No description provided for @planMinutesPerMonth.
  ///
  /// In uz, this message translates to:
  /// **'Oyiga {minutes} daqiqa'**
  String planMinutesPerMonth(int minutes);

  /// No description provided for @planMembers.
  ///
  /// In uz, this message translates to:
  /// **'{count} kishigacha'**
  String planMembers(int count);

  /// No description provided for @planPrice.
  ///
  /// In uz, this message translates to:
  /// **'{price} soʻm / oy'**
  String planPrice(String price);

  /// No description provided for @plansTitle.
  ///
  /// In uz, this message translates to:
  /// **'Tariflar'**
  String get plansTitle;

  /// No description provided for @planFree.
  ///
  /// In uz, this message translates to:
  /// **'Bepul'**
  String get planFree;

  /// No description provided for @planCurrent.
  ///
  /// In uz, this message translates to:
  /// **'Joriy tarif'**
  String get planCurrent;

  /// No description provided for @plansPaymentSoon.
  ///
  /// In uz, this message translates to:
  /// **'Ilova ichida toʻlov hali yoʻq — tez orada qoʻshiladi.'**
  String get plansPaymentSoon;

  /// No description provided for @plansEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Tariflar hali eʼlon qilinmagan.'**
  String get plansEmpty;

  /// No description provided for @roleOwner.
  ///
  /// In uz, this message translates to:
  /// **'Egasi'**
  String get roleOwner;

  /// No description provided for @roleAdmin.
  ///
  /// In uz, this message translates to:
  /// **'Administrator'**
  String get roleAdmin;

  /// No description provided for @roleMember.
  ///
  /// In uz, this message translates to:
  /// **'Aʼzo'**
  String get roleMember;

  /// No description provided for @roleViewer.
  ///
  /// In uz, this message translates to:
  /// **'Kuzatuvchi'**
  String get roleViewer;

  /// No description provided for @workspacePersonal.
  ///
  /// In uz, this message translates to:
  /// **'Shaxsiy'**
  String get workspacePersonal;

  /// No description provided for @workspaceSwitchTitle.
  ///
  /// In uz, this message translates to:
  /// **'Ish maydoni'**
  String get workspaceSwitchTitle;

  /// No description provided for @profileName.
  ///
  /// In uz, this message translates to:
  /// **'Ism'**
  String get profileName;

  /// No description provided for @profileEmail.
  ///
  /// In uz, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profileSignIn.
  ///
  /// In uz, this message translates to:
  /// **'Kirish usuli'**
  String get profileSignIn;

  /// No description provided for @profileSignInGoogle.
  ///
  /// In uz, this message translates to:
  /// **'Google'**
  String get profileSignInGoogle;

  /// No description provided for @profileSignInPassword.
  ///
  /// In uz, this message translates to:
  /// **'Email va parol'**
  String get profileSignInPassword;

  /// No description provided for @deleteTitle.
  ///
  /// In uz, this message translates to:
  /// **'Hisobni oʻchirish'**
  String get deleteTitle;

  /// No description provided for @deleteBody.
  ///
  /// In uz, this message translates to:
  /// **'Shaxsiy ish maydoningiz va faqat siz aʼzo boʻlgan ish maydonlari barcha fayllari bilan oʻchadi, faol transkripsiyalar bekor qilinadi. Boshqa ish maydonlaridan chiqarilasiz. Buni qaytarib boʻlmaydi.'**
  String get deleteBody;

  /// No description provided for @deletePasswordLabel.
  ///
  /// In uz, this message translates to:
  /// **'Tasdiqlash uchun parolingiz'**
  String get deletePasswordLabel;

  /// No description provided for @deleteEmailLabel.
  ///
  /// In uz, this message translates to:
  /// **'Tasdiqlash uchun emailingizni yozing'**
  String get deleteEmailLabel;

  /// No description provided for @deleteEmailHint.
  ///
  /// In uz, this message translates to:
  /// **'{email}'**
  String deleteEmailHint(String email);

  /// No description provided for @deleteConfirm.
  ///
  /// In uz, this message translates to:
  /// **'Hisobni butunlay oʻchirish'**
  String get deleteConfirm;

  /// No description provided for @deleteRequired.
  ///
  /// In uz, this message translates to:
  /// **'Maydonni toʻldiring'**
  String get deleteRequired;

  /// No description provided for @deleteWrong.
  ///
  /// In uz, this message translates to:
  /// **'Parol yoki email mos kelmadi.'**
  String get deleteWrong;

  /// No description provided for @deleteSoleOwner.
  ///
  /// In uz, this message translates to:
  /// **'Siz boshqa aʼzolari bor ish maydonining yagona egasisiz. Avval egalikni boshqa aʼzoga bering.'**
  String get deleteSoleOwner;

  /// No description provided for @logoutBody.
  ///
  /// In uz, this message translates to:
  /// **'Bu telefondan chiqasiz. Fayllaringiz joyida qoladi.'**
  String get logoutBody;

  /// No description provided for @filesTabUploads.
  ///
  /// In uz, this message translates to:
  /// **'Yuklangan'**
  String get filesTabUploads;

  /// No description provided for @filesTabMeetings.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuvlar'**
  String get filesTabMeetings;

  /// No description provided for @filesTabRecordings.
  ///
  /// In uz, this message translates to:
  /// **'Yozuvlar'**
  String get filesTabRecordings;

  /// No description provided for @filesTabLinks.
  ///
  /// In uz, this message translates to:
  /// **'Havolalar'**
  String get filesTabLinks;

  /// No description provided for @filesTabNotes.
  ///
  /// In uz, this message translates to:
  /// **'Eslatmalar'**
  String get filesTabNotes;

  /// No description provided for @filesMenuCreateFolder.
  ///
  /// In uz, this message translates to:
  /// **'Papka yaratish'**
  String get filesMenuCreateFolder;

  /// No description provided for @filesMenuWorkspaces.
  ///
  /// In uz, this message translates to:
  /// **'Ish maydonlari'**
  String get filesMenuWorkspaces;

  /// No description provided for @filesSearch.
  ///
  /// In uz, this message translates to:
  /// **'Qidirish'**
  String get filesSearch;

  /// No description provided for @filesSearchHint.
  ///
  /// In uz, this message translates to:
  /// **'Nomi boʻyicha qidirish'**
  String get filesSearchHint;

  /// No description provided for @filesSearchClose.
  ///
  /// In uz, this message translates to:
  /// **'Qidiruvni yopish'**
  String get filesSearchClose;

  /// No description provided for @filesSearchEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Hech narsa topilmadi.'**
  String get filesSearchEmpty;

  /// No description provided for @filesMore.
  ///
  /// In uz, this message translates to:
  /// **'Amallar'**
  String get filesMore;

  /// No description provided for @filesFailed.
  ///
  /// In uz, this message translates to:
  /// **'Bajarilmadi'**
  String get filesFailed;

  /// No description provided for @filesEmptyUploads.
  ///
  /// In uz, this message translates to:
  /// **'Yuklangan fayl hali yoʻq.'**
  String get filesEmptyUploads;

  /// No description provided for @filesEmptyMeetings.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuv yozuvlari hali yoʻq.'**
  String get filesEmptyMeetings;

  /// No description provided for @filesEmptyRecordings.
  ///
  /// In uz, this message translates to:
  /// **'Yozib olingan audio hali yoʻq.'**
  String get filesEmptyRecordings;

  /// No description provided for @filesEmptyLinks.
  ///
  /// In uz, this message translates to:
  /// **'Havoladan olingan fayl hali yoʻq.'**
  String get filesEmptyLinks;

  /// No description provided for @filesEmptyNotes.
  ///
  /// In uz, this message translates to:
  /// **'Eslatmalar hali yoʻq. Transkriptni veb-ilovada eslatma sifatida saqlang — u shu yerda paydo boʻladi.'**
  String get filesEmptyNotes;

  /// No description provided for @fileRenameTitle.
  ///
  /// In uz, this message translates to:
  /// **'Faylni qayta nomlash'**
  String get fileRenameTitle;

  /// No description provided for @fileNameHint.
  ///
  /// In uz, this message translates to:
  /// **'Fayl nomi'**
  String get fileNameHint;

  /// No description provided for @fileNameInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Nom boʻsh boʻlmasin va {max} belgidan oshmasin.'**
  String fileNameInvalid(int max);

  /// No description provided for @fileRetranscribe.
  ///
  /// In uz, this message translates to:
  /// **'Qayta transkripsiya'**
  String get fileRetranscribe;

  /// No description provided for @fileRetranscribeBody.
  ///
  /// In uz, this message translates to:
  /// **'Fayl qaytadan matnga aylantiriladi, uning davomiyligi balansdan yechiladi.'**
  String get fileRetranscribeBody;

  /// No description provided for @fileRetranscribeCost.
  ///
  /// In uz, this message translates to:
  /// **'Balansdan {minutes} daqiqa yechiladi.'**
  String fileRetranscribeCost(int minutes);

  /// No description provided for @fileRetranscribeConfirm.
  ///
  /// In uz, this message translates to:
  /// **'Boshlash'**
  String get fileRetranscribeConfirm;

  /// No description provided for @fileRetranscribeConflict.
  ///
  /// In uz, this message translates to:
  /// **'Bu fayl uchun transkripsiya allaqachon ketyapti.'**
  String get fileRetranscribeConflict;

  /// No description provided for @fileRetranscribeNotReady.
  ///
  /// In uz, this message translates to:
  /// **'Fayl hali toʻliq yuklanmagan — uni qayta transkripsiya qilib boʻlmaydi.'**
  String get fileRetranscribeNotReady;

  /// No description provided for @fileDeleteTitle.
  ///
  /// In uz, this message translates to:
  /// **'Faylni oʻchirish'**
  String get fileDeleteTitle;

  /// No description provided for @fileDeleteBody.
  ///
  /// In uz, this message translates to:
  /// **'«{name}» va uning transkripti oʻchadi, ulashilgan havolalar ishlamay qoladi. Buni qaytarib boʻlmaydi.'**
  String fileDeleteBody(String name);

  /// No description provided for @fileDeleteRunning.
  ///
  /// In uz, this message translates to:
  /// **'Davom etayotgan transkripsiya bekor qilinadi, band qilingan daqiqalar qaytariladi.'**
  String get fileDeleteRunning;

  /// No description provided for @noteUntitled.
  ///
  /// In uz, this message translates to:
  /// **'Nomsiz eslatma'**
  String get noteUntitled;

  /// No description provided for @noteCopy.
  ///
  /// In uz, this message translates to:
  /// **'Matndan nusxa olish'**
  String get noteCopy;

  /// No description provided for @noteCopied.
  ///
  /// In uz, this message translates to:
  /// **'Matn nusxalandi'**
  String get noteCopied;

  /// No description provided for @noteRenameTitle.
  ///
  /// In uz, this message translates to:
  /// **'Eslatmani qayta nomlash'**
  String get noteRenameTitle;

  /// No description provided for @noteTitleHint.
  ///
  /// In uz, this message translates to:
  /// **'Sarlavha'**
  String get noteTitleHint;

  /// No description provided for @noteTitleInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Sarlavha {max} belgidan oshmasin.'**
  String noteTitleInvalid(int max);

  /// No description provided for @noteDeleteTitle.
  ///
  /// In uz, this message translates to:
  /// **'Eslatmani oʻchirish'**
  String get noteDeleteTitle;

  /// No description provided for @noteDeleteBody.
  ///
  /// In uz, this message translates to:
  /// **'«{name}» eslatmasi oʻchadi. Buni qaytarib boʻlmaydi.'**
  String noteDeleteBody(String name);

  /// No description provided for @noteFromTranscript.
  ///
  /// In uz, this message translates to:
  /// **'Transkriptdan: {title}'**
  String noteFromTranscript(String title);

  /// No description provided for @noteSourceGone.
  ///
  /// In uz, this message translates to:
  /// **'Asl fayl oʻchirilgan'**
  String get noteSourceGone;

  /// No description provided for @noteUpdated.
  ///
  /// In uz, this message translates to:
  /// **'Oʻzgartirilgan: {date}'**
  String noteUpdated(String date);

  /// No description provided for @noteEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Eslatma boʻsh.'**
  String get noteEmpty;

  /// No description provided for @noteStale.
  ///
  /// In uz, this message translates to:
  /// **'Eslatma boshqa oynada oʻzgargan. Uni qayta oching.'**
  String get noteStale;

  /// No description provided for @recorderTapToStart.
  ///
  /// In uz, this message translates to:
  /// **'Yozishni boshlash uchun tugmani bosing'**
  String get recorderTapToStart;

  /// No description provided for @recorderRecord.
  ///
  /// In uz, this message translates to:
  /// **'Yozish'**
  String get recorderRecord;

  /// No description provided for @recorderDiscard.
  ///
  /// In uz, this message translates to:
  /// **'Oʻchirish'**
  String get recorderDiscard;

  /// No description provided for @recorderScreenOff.
  ///
  /// In uz, this message translates to:
  /// **'Ekran oʻchsa yoki boshqa ilovaga oʻtsangiz ham yozish davom etadi.'**
  String get recorderScreenOff;

  /// No description provided for @recorderMicDeniedTitle.
  ///
  /// In uz, this message translates to:
  /// **'Mikrofonga ruxsat yoʻq'**
  String get recorderMicDeniedTitle;

  /// No description provided for @recorderMicDeniedBody.
  ///
  /// In uz, this message translates to:
  /// **'Yozish uchun mikrofon kerak. Telefon sozlamalarini oching: Ilovalar → Transkriptor → Ruxsatlar → Mikrofon → «Ruxsat berish». Keyin shu yerga qaytib, «Qayta urinish»ni bosing.'**
  String get recorderMicDeniedBody;

  /// No description provided for @recorderMicDeniedBodyIos.
  ///
  /// In uz, this message translates to:
  /// **'Yozish uchun mikrofon kerak. «Sozlamalarni ochish»ni bosing va Mikrofon tugmasini yoqing. Keyin shu yerga qaytib, «Qayta urinish»ni bosing.'**
  String get recorderMicDeniedBodyIos;

  /// No description provided for @openPhoneSettings.
  ///
  /// In uz, this message translates to:
  /// **'Sozlamalarni ochish'**
  String get openPhoneSettings;

  /// No description provided for @openPhoneSettingsFailed.
  ///
  /// In uz, this message translates to:
  /// **'Sozlamalarni ochib boʻlmadi. Telefonda oching: Sozlamalar → Transkriptor → Mikrofon.'**
  String get openPhoneSettingsFailed;

  /// No description provided for @recoveryBannerOne.
  ///
  /// In uz, this message translates to:
  /// **'Yuborilmagan yozuv bor — {duration}, {when}'**
  String recoveryBannerOne(String duration, String when);

  /// No description provided for @recoveryBannerMany.
  ///
  /// In uz, this message translates to:
  /// **'Yuborilmagan yozuvlar: {count} ta'**
  String recoveryBannerMany(int count);

  /// No description provided for @recoveryCardTitle.
  ///
  /// In uz, this message translates to:
  /// **'Yuborilmagan yozuvlar'**
  String get recoveryCardTitle;

  /// No description provided for @recoveryCardBody.
  ///
  /// In uz, this message translates to:
  /// **'Oldingi yozuvlar telefonda saqlanib qolgan. Ularni hozir yuborish yoki oʻchirish mumkin.'**
  String get recoveryCardBody;

  /// No description provided for @recoverySheetTitle.
  ///
  /// In uz, this message translates to:
  /// **'Yuborilmagan yozuvlar'**
  String get recoverySheetTitle;

  /// No description provided for @recoveryOpen.
  ///
  /// In uz, this message translates to:
  /// **'Koʻrish va yuborish'**
  String get recoveryOpen;

  /// No description provided for @recoverySend.
  ///
  /// In uz, this message translates to:
  /// **'Yuborish'**
  String get recoverySend;

  /// No description provided for @recoveryDelete.
  ///
  /// In uz, this message translates to:
  /// **'Oʻchirish'**
  String get recoveryDelete;

  /// No description provided for @recoveryDeleteAsk.
  ///
  /// In uz, this message translates to:
  /// **'Bu yozuv butunlay oʻchirilsinmi?'**
  String get recoveryDeleteAsk;

  /// No description provided for @recoveryDeleteYes.
  ///
  /// In uz, this message translates to:
  /// **'Ha, oʻchirish'**
  String get recoveryDeleteYes;

  /// No description provided for @recoveryDeleteNo.
  ///
  /// In uz, this message translates to:
  /// **'Yoʻq'**
  String get recoveryDeleteNo;

  /// No description provided for @recoveryInterrupted.
  ///
  /// In uz, this message translates to:
  /// **'Uzilgan'**
  String get recoveryInterrupted;

  /// No description provided for @recoveryInterruptedHint.
  ///
  /// In uz, this message translates to:
  /// **'Ilova yopilib qolgan — oxirgi soniyalargacha tiklanadi'**
  String get recoveryInterruptedHint;

  /// No description provided for @recoveryKindMic.
  ///
  /// In uz, this message translates to:
  /// **'Mikrofon'**
  String get recoveryKindMic;

  /// No description provided for @recoveryKindScreen.
  ///
  /// In uz, this message translates to:
  /// **'Ekran ovozi'**
  String get recoveryKindScreen;

  /// No description provided for @recoveryUnknownLength.
  ///
  /// In uz, this message translates to:
  /// **'uzunligi nomaʼlum'**
  String get recoveryUnknownLength;

  /// No description provided for @recoveryToday.
  ///
  /// In uz, this message translates to:
  /// **'bugun {time}'**
  String recoveryToday(String time);

  /// No description provided for @recoveryYesterday.
  ///
  /// In uz, this message translates to:
  /// **'kecha {time}'**
  String recoveryYesterday(String time);

  /// No description provided for @recoveryOn.
  ///
  /// In uz, this message translates to:
  /// **'{date} {time}'**
  String recoveryOn(String date, String time);

  /// No description provided for @screenRecordingName.
  ///
  /// In uz, this message translates to:
  /// **'Ekran yozuvi {date}'**
  String screenRecordingName(String date);

  /// No description provided for @screenIntro.
  ///
  /// In uz, this message translates to:
  /// **'Telefonda ijro etilayotgan ovozni yozib oladi va matnga aylantiradi.'**
  String get screenIntro;

  /// No description provided for @screenWhatYes.
  ///
  /// In uz, this message translates to:
  /// **'Yoziladi: videolar, brauzer, ilovalardagi ovoz — telefon oʻzi nimani ijro etsa.'**
  String get screenWhatYes;

  /// No description provided for @screenWhatNoCalls.
  ///
  /// In uz, this message translates to:
  /// **'Telefon qoʻngʻiroqlari va messenjer qoʻngʻiroqlari yozilmaydi — Android ularni yozishga ruxsat bermaydi.'**
  String get screenWhatNoCalls;

  /// No description provided for @screenWhatBlocked.
  ///
  /// In uz, this message translates to:
  /// **'Baʼzi ilovalar oʻz ovozini yozishni taqiqlaydi. Unda ularning oʻrnida jimlik yoziladi.'**
  String get screenWhatBlocked;

  /// No description provided for @screenWhatNoVideo.
  ///
  /// In uz, this message translates to:
  /// **'Tasvir yozilmaydi — faqat ovoz.'**
  String get screenWhatNoVideo;

  /// No description provided for @screenWithMic.
  ///
  /// In uz, this message translates to:
  /// **'Mikrofonni ham yozish'**
  String get screenWithMic;

  /// No description provided for @screenWithMicBody.
  ///
  /// In uz, this message translates to:
  /// **'Oʻzingizning ovozingiz ham qoʻshiladi'**
  String get screenWithMicBody;

  /// No description provided for @screenStart.
  ///
  /// In uz, this message translates to:
  /// **'Yozishni boshlash'**
  String get screenStart;

  /// No description provided for @screenConsentNote.
  ///
  /// In uz, this message translates to:
  /// **'Android ruxsat soʻraydi: oynada «Boshlash»ni bosing.'**
  String get screenConsentNote;

  /// No description provided for @screenStarting.
  ///
  /// In uz, this message translates to:
  /// **'Ruxsat kutilmoqda…'**
  String get screenStarting;

  /// No description provided for @screenStopping.
  ///
  /// In uz, this message translates to:
  /// **'Yozuv saqlanmoqda…'**
  String get screenStopping;

  /// No description provided for @screenRecordingHint.
  ///
  /// In uz, this message translates to:
  /// **'Telefondan odatdagidek foydalaning — yozuv fonda davom etadi. Toʻxtatish bildirishnomada ham bor.'**
  String get screenRecordingHint;

  /// No description provided for @screenSilentTitle.
  ///
  /// In uz, this message translates to:
  /// **'Ovoz kelmayapti'**
  String get screenSilentTitle;

  /// No description provided for @screenSilentBody.
  ///
  /// In uz, this message translates to:
  /// **'Hozir hech narsa ijro etilmayapti yoki ijro etayotgan ilova yozishga ruxsat bermaydi (qoʻngʻiroq ilovalari shunday).'**
  String get screenSilentBody;

  /// No description provided for @screenWithMicOn.
  ///
  /// In uz, this message translates to:
  /// **'Mikrofon ham yozilmoqda'**
  String get screenWithMicOn;

  /// No description provided for @screenCancelTitle.
  ///
  /// In uz, this message translates to:
  /// **'Ekran yozuvi bekor qilinsinmi?'**
  String get screenCancelTitle;

  /// No description provided for @screenCancelBody.
  ///
  /// In uz, this message translates to:
  /// **'Yozib olingan ovoz saqlanmaydi.'**
  String get screenCancelBody;

  /// No description provided for @screenUnsupportedTitle.
  ///
  /// In uz, this message translates to:
  /// **'Bu telefonda ishlamaydi'**
  String get screenUnsupportedTitle;

  /// No description provided for @screenUnsupportedBody.
  ///
  /// In uz, this message translates to:
  /// **'Telefondagi ovozni yozish Android 10 va undan yangi versiyalarda bor. iPhone bunday yozishga ruxsat bermaydi. Oʻrniga «Audio yozib olish» yoki «Fayl yuklash»dan foydalaning.'**
  String get screenUnsupportedBody;

  /// No description provided for @screenHintConsent.
  ///
  /// In uz, this message translates to:
  /// **'Tizim oynasida «Boshlash»ni bosmasangiz, yozish boshlanmaydi.'**
  String get screenHintConsent;

  /// No description provided for @screenHintMic.
  ///
  /// In uz, this message translates to:
  /// **'Android telefondagi ovozni yozish uchun ham mikrofon ruxsatini talab qiladi — mikrofon aralashtirilmasa ham. Sozlamalar → Ilovalar → Transkriptor → Ruxsatlar → Mikrofon.'**
  String get screenHintMic;

  /// No description provided for @screenHintBusy.
  ///
  /// In uz, this message translates to:
  /// **'Avval boshqa yozuvni toʻxtating (bildirishnomaga qarang).'**
  String get screenHintBusy;

  /// No description provided for @screenHintFailed.
  ///
  /// In uz, this message translates to:
  /// **'Qayta urinib koʻring. Takrorlansa, telefonni qayta ishga tushiring.'**
  String get screenHintFailed;

  /// No description provided for @screenKeptPartial.
  ///
  /// In uz, this message translates to:
  /// **'Yozish toʻxtab qoldi, lekin shu paytgacha yozilgani saqlandi.'**
  String get screenKeptPartial;

  /// No description provided for @meetHeadline.
  ///
  /// In uz, this message translates to:
  /// **'Google Meet uchrashuvini yozib olish'**
  String get meetHeadline;

  /// No description provided for @meetIntro.
  ///
  /// In uz, this message translates to:
  /// **'Bot uchrashuvga mehmon sifatida kiradi, ovozni yozadi, uchrashuv tugagach matnga aylantiradi.'**
  String get meetIntro;

  /// No description provided for @meetUrlLabel.
  ///
  /// In uz, this message translates to:
  /// **'Google Meet havolasi'**
  String get meetUrlLabel;

  /// No description provided for @meetUrlInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Faqat Google Meet havolasi: https://meet.google.com/abc-defg-hij'**
  String get meetUrlInvalid;

  /// No description provided for @meetKeepVideo.
  ///
  /// In uz, this message translates to:
  /// **'Videoni ham saqlash'**
  String get meetKeepVideo;

  /// No description provided for @meetKeepVideoBody.
  ///
  /// In uz, this message translates to:
  /// **'Ishtirokchilar kameralari yoziladi, fayl kattaroq boʻladi. Meet oynasining oʻzi yozilmaydi.'**
  String get meetKeepVideoBody;

  /// No description provided for @meetHostNote.
  ///
  /// In uz, this message translates to:
  /// **'Google Meet tashqi botlarni kutish zaliga qoʻyadi. Uchrashuv egasi botni «Qabul qilish» bilan kiritmaguncha hech narsa yozilmaydi.'**
  String get meetHostNote;

  /// No description provided for @meetBotName.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuvda bot «{name}» nomi bilan koʻrinadi.'**
  String meetBotName(String name);

  /// No description provided for @meetJoin.
  ///
  /// In uz, this message translates to:
  /// **'Botni yuborish'**
  String get meetJoin;

  /// No description provided for @meetRecent.
  ///
  /// In uz, this message translates to:
  /// **'Oxirgi uchrashuvlar'**
  String get meetRecent;

  /// No description provided for @meetRecentEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Hali bot yuborilmagan.'**
  String get meetRecentEmpty;

  /// No description provided for @meetUnavailable.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuv boti bu serverda hozir oʻchiq.'**
  String get meetUnavailable;

  /// No description provided for @meetRouteMissingTitle.
  ///
  /// In uz, this message translates to:
  /// **'Bu server versiyasida hali yoʻq'**
  String get meetRouteMissingTitle;

  /// No description provided for @meetRouteMissingBody.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuv boti serverning keyingi versiyasi bilan keladi. Hozircha uchrashuvni «Audio yozib olish» bilan yozib oling.'**
  String get meetRouteMissingBody;

  /// No description provided for @meetStatusScheduled.
  ///
  /// In uz, this message translates to:
  /// **'Navbatda'**
  String get meetStatusScheduled;

  /// No description provided for @meetStatusJoining.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuvga kirmoqda'**
  String get meetStatusJoining;

  /// No description provided for @meetStatusWaiting.
  ///
  /// In uz, this message translates to:
  /// **'Kutish zalida'**
  String get meetStatusWaiting;

  /// No description provided for @meetStatusRecording.
  ///
  /// In uz, this message translates to:
  /// **'Yozilmoqda'**
  String get meetStatusRecording;

  /// No description provided for @meetStatusUploading.
  ///
  /// In uz, this message translates to:
  /// **'Qayta ishlanmoqda'**
  String get meetStatusUploading;

  /// No description provided for @meetStatusDone.
  ///
  /// In uz, this message translates to:
  /// **'Tayyor'**
  String get meetStatusDone;

  /// No description provided for @meetStatusFailed.
  ///
  /// In uz, this message translates to:
  /// **'Xato'**
  String get meetStatusFailed;

  /// No description provided for @meetStatusDenied.
  ///
  /// In uz, this message translates to:
  /// **'Kiritilmadi'**
  String get meetStatusDenied;

  /// No description provided for @meetStatusCancelled.
  ///
  /// In uz, this message translates to:
  /// **'Bekor qilingan'**
  String get meetStatusCancelled;

  /// No description provided for @meetStepWaitingHint.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuv egasi botni qabul qilishi kerak.'**
  String get meetStepWaitingHint;

  /// No description provided for @meetStepUploadingHint.
  ///
  /// In uz, this message translates to:
  /// **'Yozuv yuklanmoqda, keyin transkripsiya boshlanadi.'**
  String get meetStepUploadingHint;

  /// No description provided for @meetDeniedDefault.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuv egasi botni kiritmadi.'**
  String get meetDeniedDefault;

  /// No description provided for @meetFailedDefault.
  ///
  /// In uz, this message translates to:
  /// **'Bot ishini yakunlay olmadi.'**
  String get meetFailedDefault;

  /// No description provided for @meetCancelledBody.
  ///
  /// In uz, this message translates to:
  /// **'Bot chaqirib olindi.'**
  String get meetCancelledBody;

  /// No description provided for @meetOpenResult.
  ///
  /// In uz, this message translates to:
  /// **'Transkriptni ochish'**
  String get meetOpenResult;

  /// No description provided for @meetCancel.
  ///
  /// In uz, this message translates to:
  /// **'Botni chaqirib olish'**
  String get meetCancel;

  /// No description provided for @meetCancelRecordingNote.
  ///
  /// In uz, this message translates to:
  /// **'Bot uchrashuvdan chiqadi. Shu paytgacha yozilgani baribir matnga aylantiriladi.'**
  String get meetCancelRecordingNote;

  /// No description provided for @meetLeaving.
  ///
  /// In uz, this message translates to:
  /// **'Bot uchrashuvdan chiqmoqda…'**
  String get meetLeaving;

  /// No description provided for @meetNew.
  ///
  /// In uz, this message translates to:
  /// **'Yangi uchrashuv'**
  String get meetNew;

  /// No description provided for @meetPollFailed.
  ///
  /// In uz, this message translates to:
  /// **'Holatni yangilab boʻlmadi — qayta urinilmoqda.'**
  String get meetPollFailed;

  /// No description provided for @urlIntro.
  ///
  /// In uz, this message translates to:
  /// **'Internetdagi audio yoki video faylning toʻgʻridan-toʻgʻri havolasi (.mp3, .mp4, .m4a…).'**
  String get urlIntro;

  /// No description provided for @urlLabel.
  ///
  /// In uz, this message translates to:
  /// **'Fayl havolasi'**
  String get urlLabel;

  /// No description provided for @urlInvalid.
  ///
  /// In uz, this message translates to:
  /// **'Havola http:// yoki https:// bilan boshlanishi va manzilga ega boʻlishi kerak.'**
  String get urlInvalid;

  /// No description provided for @urlPlatformsNote.
  ///
  /// In uz, this message translates to:
  /// **'YouTube, Google Drive va Dropbox havolalari shu yerdan ham ishlaydi — ular alohida yoʻl bilan yuboriladi.'**
  String get urlPlatformsNote;

  /// No description provided for @urlSubmit.
  ///
  /// In uz, this message translates to:
  /// **'Davom etish'**
  String get urlSubmit;

  /// No description provided for @urlNotReady.
  ///
  /// In uz, this message translates to:
  /// **'Toʻgʻridan-toʻgʻri havoladan yuklash serverda hali yoʻq. Hozircha faylni telefonga yuklab olib, «Fayl yuklash» orqali yuboring.'**
  String get urlNotReady;

  /// No description provided for @urlBanner.
  ///
  /// In uz, this message translates to:
  /// **'Namuna — havoladan yuklash serverda hali yoʻq'**
  String get urlBanner;

  /// No description provided for @dictationBanner.
  ///
  /// In uz, this message translates to:
  /// **'Namuna — jonli diktovka uchun server hali tayyor emas, matn namunaviy'**
  String get dictationBanner;

  /// No description provided for @dictationIntro.
  ///
  /// In uz, this message translates to:
  /// **'Gapiring — matn shu zahoti paydo boʻladi. Toʻxtatgach, uni qayd sifatida saqlash yoki nusxa olish mumkin.'**
  String get dictationIntro;

  /// No description provided for @dictationStart.
  ///
  /// In uz, this message translates to:
  /// **'Gapirishni boshlash'**
  String get dictationStart;

  /// No description provided for @dictationStop.
  ///
  /// In uz, this message translates to:
  /// **'Toʻxtatish'**
  String get dictationStop;

  /// No description provided for @dictationListening.
  ///
  /// In uz, this message translates to:
  /// **'Tinglanmoqda…'**
  String get dictationListening;

  /// No description provided for @dictationEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Matn shu yerda paydo boʻladi.'**
  String get dictationEmpty;

  /// No description provided for @dictationSaveNote.
  ///
  /// In uz, this message translates to:
  /// **'Eslatma sifatida saqlash'**
  String get dictationSaveNote;

  /// No description provided for @dictationCopy.
  ///
  /// In uz, this message translates to:
  /// **'Nusxa olish'**
  String get dictationCopy;

  /// No description provided for @dictationCopied.
  ///
  /// In uz, this message translates to:
  /// **'Matn nusxalandi'**
  String get dictationCopied;

  /// No description provided for @dictationDiscard.
  ///
  /// In uz, this message translates to:
  /// **'Tashlab yuborish'**
  String get dictationDiscard;

  /// No description provided for @dictationSaved.
  ///
  /// In uz, this message translates to:
  /// **'Eslatma saqlandi'**
  String get dictationSaved;

  /// No description provided for @dictationNoteTitle.
  ///
  /// In uz, this message translates to:
  /// **'Diktovka {date}'**
  String dictationNoteTitle(String date);

  /// No description provided for @dictationSample1.
  ///
  /// In uz, this message translates to:
  /// **'Bu namuna matn: jonli diktovka hali serverga ulanmagan.'**
  String get dictationSample1;

  /// No description provided for @dictationSample2.
  ///
  /// In uz, this message translates to:
  /// **'Server oqimli endpoint olganda shu yerda sizning soʻzlaringiz chiqadi.'**
  String get dictationSample2;

  /// No description provided for @dictationSample3.
  ///
  /// In uz, this message translates to:
  /// **'Hozircha ekranning qanday ishlashini koʻrish mumkin: avval xira matn, keyin tasdiqlangan gap.'**
  String get dictationSample3;

  /// No description provided for @dictationSample4.
  ///
  /// In uz, this message translates to:
  /// **'Toʻxtatish tugmasini bosing va matnni eslatma sifatida saqlab koʻring.'**
  String get dictationSample4;

  /// No description provided for @aiMarker.
  ///
  /// In uz, this message translates to:
  /// **'AI'**
  String get aiMarker;

  /// No description provided for @aiChatIntroTitle.
  ///
  /// In uz, this message translates to:
  /// **'Shu yozuv boʻyicha soʻrang'**
  String get aiChatIntroTitle;

  /// No description provided for @aiChatIntro.
  ///
  /// In uz, this message translates to:
  /// **'Javob faqat shu transkriptga tayanadi va vaqtga havola beradi — havolani bossangiz, pleyer oʻsha joyga oʻtadi.'**
  String get aiChatIntro;

  /// No description provided for @aiChatSuggestionTopics.
  ///
  /// In uz, this message translates to:
  /// **'Asosiy mavzular qanday?'**
  String get aiChatSuggestionTopics;

  /// No description provided for @aiChatSuggestionWho.
  ///
  /// In uz, this message translates to:
  /// **'Kim nima dedi?'**
  String get aiChatSuggestionWho;

  /// No description provided for @aiChatSuggestionDecisions.
  ///
  /// In uz, this message translates to:
  /// **'Qanday qarorlar qabul qilindi?'**
  String get aiChatSuggestionDecisions;

  /// No description provided for @aiChatHint.
  ///
  /// In uz, this message translates to:
  /// **'Shu yozuv boʻyicha soʻrang'**
  String get aiChatHint;

  /// No description provided for @aiChatHintPending.
  ///
  /// In uz, this message translates to:
  /// **'Javob kutilmoqda…'**
  String get aiChatHintPending;

  /// No description provided for @aiChatSend.
  ///
  /// In uz, this message translates to:
  /// **'Yuborish'**
  String get aiChatSend;

  /// No description provided for @aiChatThinking.
  ///
  /// In uz, this message translates to:
  /// **'Transkriptni oʻqiyapti… Uzun yozuvda javob bir daqiqagacha olishi mumkin.'**
  String get aiChatThinking;

  /// No description provided for @aiChatAnswerFailed.
  ///
  /// In uz, this message translates to:
  /// **'Javob olinmadi.'**
  String get aiChatAnswerFailed;

  /// No description provided for @aiChatResend.
  ///
  /// In uz, this message translates to:
  /// **'Qayta yuborish'**
  String get aiChatResend;

  /// No description provided for @aiChatPrivate.
  ///
  /// In uz, this message translates to:
  /// **'Suhbatni faqat siz koʻrasiz.'**
  String get aiChatPrivate;

  /// No description provided for @aiChatClear.
  ///
  /// In uz, this message translates to:
  /// **'Suhbatni tozalash'**
  String get aiChatClear;

  /// No description provided for @aiChatClearTitle.
  ///
  /// In uz, this message translates to:
  /// **'Suhbat tozalansinmi?'**
  String get aiChatClearTitle;

  /// No description provided for @aiChatClearBody.
  ///
  /// In uz, this message translates to:
  /// **'Bu transkript boʻyicha savol va javoblaringiz oʻchadi. Buni qaytarib boʻlmaydi.'**
  String get aiChatClearBody;

  /// No description provided for @aiChatClearConfirm.
  ///
  /// In uz, this message translates to:
  /// **'Tozalash'**
  String get aiChatClearConfirm;

  /// No description provided for @aiChatBusy.
  ///
  /// In uz, this message translates to:
  /// **'Oldingi savolga javob hali kelmadi — kuting.'**
  String get aiChatBusy;

  /// No description provided for @aiChatUnavailable.
  ///
  /// In uz, this message translates to:
  /// **'AI hozir band yoki oʻchiq. Birozdan keyin qayta yuboring.'**
  String get aiChatUnavailable;

  /// No description provided for @aiChatPollFailed.
  ///
  /// In uz, this message translates to:
  /// **'Javob holatini olib boʻlmadi — tarmoqni tekshiring.'**
  String get aiChatPollFailed;

  /// No description provided for @aiChatSeekTo.
  ///
  /// In uz, this message translates to:
  /// **'{time} ga oʻtish'**
  String aiChatSeekTo(String time);

  /// No description provided for @summaryDemoBanner.
  ///
  /// In uz, this message translates to:
  /// **'Namuna — bu server versiyasida xulosa hali yoʻq: matn transkriptning oʻz gaplaridan yigʻiladi, uni AI yozmaydi.'**
  String get summaryDemoBanner;

  /// No description provided for @summaryTooShort.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa uchun transkript juda qisqa. Kamida uch qatorli yozuv kerak.'**
  String get summaryTooShort;

  /// No description provided for @summaryTemplateLabel.
  ///
  /// In uz, this message translates to:
  /// **'Shablon'**
  String get summaryTemplateLabel;

  /// No description provided for @summaryTemplateDefault.
  ///
  /// In uz, this message translates to:
  /// **'Asosiy xulosa'**
  String get summaryTemplateDefault;

  /// No description provided for @summaryTemplatesTitle.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa shabloni'**
  String get summaryTemplatesTitle;

  /// No description provided for @summaryTemplatesFavorites.
  ///
  /// In uz, this message translates to:
  /// **'Sevimlilar'**
  String get summaryTemplatesFavorites;

  /// No description provided for @summaryTemplatesMine.
  ///
  /// In uz, this message translates to:
  /// **'Mening shablonlarim'**
  String get summaryTemplatesMine;

  /// No description provided for @summaryTemplatesEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Shablonlar hali yoʻq — asosiy xulosa ishlatiladi.'**
  String get summaryTemplatesEmpty;

  /// No description provided for @summaryStar.
  ///
  /// In uz, this message translates to:
  /// **'Sevimlilarga qoʻshish'**
  String get summaryStar;

  /// No description provided for @summaryUnstar.
  ///
  /// In uz, this message translates to:
  /// **'Sevimlilardan olib tashlash'**
  String get summaryUnstar;

  /// No description provided for @summaryFavoriteFailed.
  ///
  /// In uz, this message translates to:
  /// **'Sevimlini saqlab boʻlmadi.'**
  String get summaryFavoriteFailed;

  /// No description provided for @summaryEmptyTitle.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa hali yoʻq'**
  String get summaryEmptyTitle;

  /// No description provided for @summaryEmptyBody.
  ///
  /// In uz, this message translates to:
  /// **'Shablonni tanlang va xulosa yarating.'**
  String get summaryEmptyBody;

  /// No description provided for @summaryCreate.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa yaratish'**
  String get summaryCreate;

  /// No description provided for @summaryGenerating.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa yozilmoqda…'**
  String get summaryGenerating;

  /// No description provided for @summaryCopy.
  ///
  /// In uz, this message translates to:
  /// **'Nusxalash'**
  String get summaryCopy;

  /// No description provided for @summaryRegenerate.
  ///
  /// In uz, this message translates to:
  /// **'Qayta yaratish'**
  String get summaryRegenerate;

  /// No description provided for @summaryDelete.
  ///
  /// In uz, this message translates to:
  /// **'Oʻchirish'**
  String get summaryDelete;

  /// No description provided for @summaryDeleteTitle.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa oʻchirilsinmi?'**
  String get summaryDeleteTitle;

  /// No description provided for @summaryDeleteBody.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa matni oʻchadi. Transkriptning oʻzi oʻzgarmaydi.'**
  String get summaryDeleteBody;

  /// No description provided for @summarySaveNote.
  ///
  /// In uz, this message translates to:
  /// **'Eslatma sifatida saqlash'**
  String get summarySaveNote;

  /// No description provided for @summaryNoteSaved.
  ///
  /// In uz, this message translates to:
  /// **'Eslatmalarga saqlandi'**
  String get summaryNoteSaved;

  /// No description provided for @summaryNoteTitle.
  ///
  /// In uz, this message translates to:
  /// **'{title} — xulosa'**
  String summaryNoteTitle(String title);

  /// No description provided for @summarySectionOverview.
  ///
  /// In uz, this message translates to:
  /// **'Qisqacha'**
  String get summarySectionOverview;

  /// No description provided for @summarySectionKeyPoints.
  ///
  /// In uz, this message translates to:
  /// **'Asosiy fikrlar'**
  String get summarySectionKeyPoints;

  /// No description provided for @summarySectionSpeakers.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachilar'**
  String get summarySectionSpeakers;

  /// No description provided for @summarySectionNextSteps.
  ///
  /// In uz, this message translates to:
  /// **'Keyingi qadamlar'**
  String get summarySectionNextSteps;

  /// No description provided for @summaryLoading.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa tekshirilmoqda…'**
  String get summaryLoading;

  /// No description provided for @summaryFailedDefault.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa yozilmadi — qayta urinib koʻring.'**
  String get summaryFailedDefault;

  /// No description provided for @summaryBusy.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa hozir yozilmoqda yoki transkriptda matn yoʻq.'**
  String get summaryBusy;

  /// No description provided for @summaryUnavailable.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa hozir yoqilmagan yoki navbat toʻla — birozdan keyin urinib koʻring.'**
  String get summaryUnavailable;

  /// No description provided for @summaryForbidden.
  ///
  /// In uz, this message translates to:
  /// **'Xulosani faqat tahrirlash huquqi bor aʼzo yarata oladi.'**
  String get summaryForbidden;

  /// No description provided for @meetSummarize.
  ///
  /// In uz, this message translates to:
  /// **'Uchrashuvdan keyin xulosa yozilsin'**
  String get meetSummarize;

  /// No description provided for @meetSummarizeBody.
  ///
  /// In uz, this message translates to:
  /// **'Transkript tayyor boʻlgach AI xulosa yozadi va uni xatda yuboradi.'**
  String get meetSummarizeBody;

  /// No description provided for @meetSummaryTemplate.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa shabloni'**
  String get meetSummaryTemplate;

  /// No description provided for @meetShareInternal.
  ///
  /// In uz, this message translates to:
  /// **'Xulosani ichki ishtirokchilarga ham yuborish'**
  String get meetShareInternal;

  /// No description provided for @meetShareInternalBody.
  ///
  /// In uz, this message translates to:
  /// **'Faqat emailingiz domenidagi ishtirokchilarga; buning uchun emailingiz tasdiqlangan boʻlishi kerak.'**
  String get meetShareInternalBody;

  /// No description provided for @profileNameEdit.
  ///
  /// In uz, this message translates to:
  /// **'Ismni oʻzgartirish'**
  String get profileNameEdit;

  /// No description provided for @profileNameAdd.
  ///
  /// In uz, this message translates to:
  /// **'Ism qoʻshish'**
  String get profileNameAdd;

  /// No description provided for @profileNameSave.
  ///
  /// In uz, this message translates to:
  /// **'Saqlash'**
  String get profileNameSave;

  /// No description provided for @profileNameEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Ismni kiriting.'**
  String get profileNameEmpty;

  /// No description provided for @profileNameTooLong.
  ///
  /// In uz, this message translates to:
  /// **'Ism juda uzun.'**
  String get profileNameTooLong;

  /// No description provided for @profileNameSaved.
  ///
  /// In uz, this message translates to:
  /// **'Ism saqlandi'**
  String get profileNameSaved;

  /// No description provided for @learnDemoBanner.
  ///
  /// In uz, this message translates to:
  /// **'Namuna — savollar transkript gaplaridan oddiy qoidalar bilan tuziladi, ularni AI yozmaydi.'**
  String get learnDemoBanner;

  /// No description provided for @learnTooShort.
  ///
  /// In uz, this message translates to:
  /// **'Oʻrganish uchun transkript juda qisqa. Kamida uch qatorli yozuv kerak.'**
  String get learnTooShort;

  /// No description provided for @learnIntro.
  ///
  /// In uz, this message translates to:
  /// **'Shu transkript mazmunini oʻrganing:'**
  String get learnIntro;

  /// No description provided for @learnFlashcardsTitle.
  ///
  /// In uz, this message translates to:
  /// **'Kartochkalar'**
  String get learnFlashcardsTitle;

  /// No description provided for @learnFlashcardsBody.
  ///
  /// In uz, this message translates to:
  /// **'Asosiy fikrlarni kartochkalar bilan yodlang.'**
  String get learnFlashcardsBody;

  /// No description provided for @learnQuizTitle.
  ///
  /// In uz, this message translates to:
  /// **'Test'**
  String get learnQuizTitle;

  /// No description provided for @learnQuizBody.
  ///
  /// In uz, this message translates to:
  /// **'Transkript boʻyicha savollar bilan oʻzingizni sinang.'**
  String get learnQuizBody;

  /// No description provided for @learnCreateFlashcards.
  ///
  /// In uz, this message translates to:
  /// **'Kartochkalar yaratish'**
  String get learnCreateFlashcards;

  /// No description provided for @learnCreateQuiz.
  ///
  /// In uz, this message translates to:
  /// **'Test yaratish'**
  String get learnCreateQuiz;

  /// No description provided for @learnCount.
  ///
  /// In uz, this message translates to:
  /// **'Savollar soni'**
  String get learnCount;

  /// No description provided for @learnDifficulty.
  ///
  /// In uz, this message translates to:
  /// **'Qiyinlik'**
  String get learnDifficulty;

  /// No description provided for @learnEasy.
  ///
  /// In uz, this message translates to:
  /// **'Oson'**
  String get learnEasy;

  /// No description provided for @learnMedium.
  ///
  /// In uz, this message translates to:
  /// **'Oʻrta'**
  String get learnMedium;

  /// No description provided for @learnHard.
  ///
  /// In uz, this message translates to:
  /// **'Qiyin'**
  String get learnHard;

  /// No description provided for @learnQuestionType.
  ///
  /// In uz, this message translates to:
  /// **'Savol turi'**
  String get learnQuestionType;

  /// No description provided for @learnMultipleChoice.
  ///
  /// In uz, this message translates to:
  /// **'Koʻp tanlovli'**
  String get learnMultipleChoice;

  /// No description provided for @learnMultipleChoiceBody.
  ///
  /// In uz, this message translates to:
  /// **'Bir nechta variantdan toʻgʻrisini tanlang.'**
  String get learnMultipleChoiceBody;

  /// No description provided for @learnTrueFalse.
  ///
  /// In uz, this message translates to:
  /// **'Toʻgʻri / notoʻgʻri'**
  String get learnTrueFalse;

  /// No description provided for @learnTrueFalseBody.
  ///
  /// In uz, this message translates to:
  /// **'Gap transkriptdagidek toʻgʻrimi yoki yoʻqmi — aniqlang.'**
  String get learnTrueFalseBody;

  /// No description provided for @learnTypeRequired.
  ///
  /// In uz, this message translates to:
  /// **'Kamida bitta savol turini tanlang.'**
  String get learnTypeRequired;

  /// No description provided for @learnCreate.
  ///
  /// In uz, this message translates to:
  /// **'Yaratish'**
  String get learnCreate;

  /// No description provided for @learnCreating.
  ///
  /// In uz, this message translates to:
  /// **'Tayyorlanmoqda…'**
  String get learnCreating;

  /// No description provided for @learnEmptyResult.
  ///
  /// In uz, this message translates to:
  /// **'Bu matndan savol tuzib boʻlmadi — gaplar juda qisqa.'**
  String get learnEmptyResult;

  /// No description provided for @learnPrevious.
  ///
  /// In uz, this message translates to:
  /// **'Oldingi toʻplamlar'**
  String get learnPrevious;

  /// No description provided for @learnFlashcardSetTitle.
  ///
  /// In uz, this message translates to:
  /// **'Kartochkalar · {count} ta'**
  String learnFlashcardSetTitle(int count);

  /// No description provided for @learnQuizSetTitle.
  ///
  /// In uz, this message translates to:
  /// **'Test · {count} ta savol'**
  String learnQuizSetTitle(int count);

  /// No description provided for @learnSetSubtitle.
  ///
  /// In uz, this message translates to:
  /// **'{difficulty} · {time}'**
  String learnSetSubtitle(String difficulty, String time);

  /// No description provided for @learnProgress.
  ///
  /// In uz, this message translates to:
  /// **'{current} / {total}'**
  String learnProgress(int current, int total);

  /// No description provided for @learnCardFront.
  ///
  /// In uz, this message translates to:
  /// **'Boʻsh joyga qaysi soʻz tushadi?'**
  String get learnCardFront;

  /// No description provided for @learnCardBack.
  ///
  /// In uz, this message translates to:
  /// **'Javob'**
  String get learnCardBack;

  /// No description provided for @learnTapToFlip.
  ///
  /// In uz, this message translates to:
  /// **'Javobni koʻrish uchun kartochkani bosing'**
  String get learnTapToFlip;

  /// No description provided for @learnKnow.
  ///
  /// In uz, this message translates to:
  /// **'Bilaman'**
  String get learnKnow;

  /// No description provided for @learnRepeat.
  ///
  /// In uz, this message translates to:
  /// **'Takrorlash'**
  String get learnRepeat;

  /// No description provided for @learnKnownCount.
  ///
  /// In uz, this message translates to:
  /// **'Bilaman: {count}'**
  String learnKnownCount(int count);

  /// No description provided for @learnRepeatCount.
  ///
  /// In uz, this message translates to:
  /// **'Takrorlash: {count}'**
  String learnRepeatCount(int count);

  /// No description provided for @learnPreviousCard.
  ///
  /// In uz, this message translates to:
  /// **'Oldingi'**
  String get learnPreviousCard;

  /// No description provided for @learnNextCard.
  ///
  /// In uz, this message translates to:
  /// **'Keyingi'**
  String get learnNextCard;

  /// No description provided for @learnFlashcardsDone.
  ///
  /// In uz, this message translates to:
  /// **'Toʻplam tugadi'**
  String get learnFlashcardsDone;

  /// No description provided for @learnRestart.
  ///
  /// In uz, this message translates to:
  /// **'Boshidan'**
  String get learnRestart;

  /// No description provided for @learnRestartRepeat.
  ///
  /// In uz, this message translates to:
  /// **'Faqat takrorlanadiganlar'**
  String get learnRestartRepeat;

  /// No description provided for @learnTrue.
  ///
  /// In uz, this message translates to:
  /// **'Toʻgʻri'**
  String get learnTrue;

  /// No description provided for @learnFalse.
  ///
  /// In uz, this message translates to:
  /// **'Notoʻgʻri'**
  String get learnFalse;

  /// No description provided for @learnQuizTrueFalsePrompt.
  ///
  /// In uz, this message translates to:
  /// **'Gap transkriptdagidek toʻgʻrimi?'**
  String get learnQuizTrueFalsePrompt;

  /// No description provided for @learnQuizChoosePrompt.
  ///
  /// In uz, this message translates to:
  /// **'Boʻsh joyni toʻldiring'**
  String get learnQuizChoosePrompt;

  /// No description provided for @learnCorrect.
  ///
  /// In uz, this message translates to:
  /// **'Toʻgʻri javob!'**
  String get learnCorrect;

  /// No description provided for @learnWrong.
  ///
  /// In uz, this message translates to:
  /// **'Notoʻgʻri javob'**
  String get learnWrong;

  /// No description provided for @learnSource.
  ///
  /// In uz, this message translates to:
  /// **'Transkriptda: «{sentence}»'**
  String learnSource(String sentence);

  /// No description provided for @learnFinish.
  ///
  /// In uz, this message translates to:
  /// **'Natija'**
  String get learnFinish;

  /// No description provided for @learnScoreTitle.
  ///
  /// In uz, this message translates to:
  /// **'Natijangiz'**
  String get learnScoreTitle;

  /// No description provided for @learnReview.
  ///
  /// In uz, this message translates to:
  /// **'Javoblar'**
  String get learnReview;

  /// No description provided for @learnYourAnswer.
  ///
  /// In uz, this message translates to:
  /// **'Sizning javobingiz: {answer}'**
  String learnYourAnswer(String answer);

  /// No description provided for @learnRightAnswer.
  ///
  /// In uz, this message translates to:
  /// **'Toʻgʻri javob: {answer}'**
  String learnRightAnswer(String answer);

  /// No description provided for @editorTabTranscript.
  ///
  /// In uz, this message translates to:
  /// **'Transkript'**
  String get editorTabTranscript;

  /// No description provided for @editorTabAiChat.
  ///
  /// In uz, this message translates to:
  /// **'AI suhbat'**
  String get editorTabAiChat;

  /// No description provided for @editorTabSummary.
  ///
  /// In uz, this message translates to:
  /// **'Xulosa'**
  String get editorTabSummary;

  /// No description provided for @editorTabLearn.
  ///
  /// In uz, this message translates to:
  /// **'Oʻrganish'**
  String get editorTabLearn;

  /// No description provided for @editorTabSoon.
  ///
  /// In uz, this message translates to:
  /// **'Bu boʻlim tez orada shu yerda boʻladi.'**
  String get editorTabSoon;

  /// No description provided for @editorMore.
  ///
  /// In uz, this message translates to:
  /// **'Fayl amallari'**
  String get editorMore;

  /// No description provided for @editorRenameTitle.
  ///
  /// In uz, this message translates to:
  /// **'Transkript nomi'**
  String get editorRenameTitle;

  /// No description provided for @editorShowSpeakers.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachilarni koʻrsatish'**
  String get editorShowSpeakers;

  /// No description provided for @editorFilterSpeakers.
  ///
  /// In uz, this message translates to:
  /// **'Maʼruzachi boʻyicha saralash'**
  String get editorFilterSpeakers;

  /// No description provided for @editorPlaybackSpeed.
  ///
  /// In uz, this message translates to:
  /// **'Ijro tezligi'**
  String get editorPlaybackSpeed;

  /// No description provided for @editorEdit.
  ///
  /// In uz, this message translates to:
  /// **'Tahrirlash'**
  String get editorEdit;

  /// No description provided for @editorComments.
  ///
  /// In uz, this message translates to:
  /// **'Izohlar'**
  String get editorComments;

  /// No description provided for @editorRating.
  ///
  /// In uz, this message translates to:
  /// **'Baho'**
  String get editorRating;

  /// No description provided for @editorRetranscribe.
  ///
  /// In uz, this message translates to:
  /// **'Qayta transkripsiya'**
  String get editorRetranscribe;

  /// No description provided for @editorEditHint.
  ///
  /// In uz, this message translates to:
  /// **'Satrni tahrirlash uchun ikki marta bosing'**
  String get editorEditHint;

  /// No description provided for @editorFollow.
  ///
  /// In uz, this message translates to:
  /// **'Joriy joyga'**
  String get editorFollow;

  /// No description provided for @playerPlay.
  ///
  /// In uz, this message translates to:
  /// **'Ijro etish'**
  String get playerPlay;

  /// No description provided for @playerPause.
  ///
  /// In uz, this message translates to:
  /// **'Pauza'**
  String get playerPause;

  /// No description provided for @playerBack.
  ///
  /// In uz, this message translates to:
  /// **'5 soniya orqaga'**
  String get playerBack;

  /// No description provided for @playerForward.
  ///
  /// In uz, this message translates to:
  /// **'5 soniya oldinga'**
  String get playerForward;

  /// No description provided for @playerFold.
  ///
  /// In uz, this message translates to:
  /// **'Videoni yigʻish'**
  String get playerFold;

  /// No description provided for @playerUnfold.
  ///
  /// In uz, this message translates to:
  /// **'Videoni ochish'**
  String get playerUnfold;

  /// No description provided for @playerGone.
  ///
  /// In uz, this message translates to:
  /// **'Audio saqlash muddati tugagani uchun oʻchirilgan. Matn joyida.'**
  String get playerGone;

  /// No description provided for @playerUnavailable.
  ///
  /// In uz, this message translates to:
  /// **'Bu yozuvning audiosi mavjud emas. Matn bilan ishlashingiz mumkin.'**
  String get playerUnavailable;

  /// No description provided for @playerFailed.
  ///
  /// In uz, this message translates to:
  /// **'Audioni ochib boʻlmadi.'**
  String get playerFailed;

  /// No description provided for @playerYoutubeBody.
  ///
  /// In uz, this message translates to:
  /// **'YouTube videosi ilova ichida ijro etilmaydi. Matn bilan shu yerda ishlashingiz mumkin.'**
  String get playerYoutubeBody;

  /// No description provided for @playerYoutubeOpen.
  ///
  /// In uz, this message translates to:
  /// **'YouTubeʼda ochish'**
  String get playerYoutubeOpen;

  /// No description provided for @playerYoutubeCopy.
  ///
  /// In uz, this message translates to:
  /// **'Havoladan nusxa olish'**
  String get playerYoutubeCopy;

  /// No description provided for @segmentEditText.
  ///
  /// In uz, this message translates to:
  /// **'Matnni tahrirlash'**
  String get segmentEditText;

  /// No description provided for @segmentAddComment.
  ///
  /// In uz, this message translates to:
  /// **'Izoh qoʻshish'**
  String get segmentAddComment;

  /// No description provided for @segmentDelete.
  ///
  /// In uz, this message translates to:
  /// **'Segmentni oʻchirish'**
  String get segmentDelete;

  /// No description provided for @segmentDeleteConfirm.
  ///
  /// In uz, this message translates to:
  /// **'Segment matni bilan oʻchadi. Rostdan oʻchirilsinmi?'**
  String get segmentDeleteConfirm;

  /// No description provided for @segmentDeleteYes.
  ///
  /// In uz, this message translates to:
  /// **'Ha, oʻchirish'**
  String get segmentDeleteYes;

  /// No description provided for @speakerRename.
  ///
  /// In uz, this message translates to:
  /// **'Nomini oʻzgartirish'**
  String get speakerRename;

  /// No description provided for @commentsEmpty.
  ///
  /// In uz, this message translates to:
  /// **'Izohlar yoʻq. Segmentni bosib turing va «Izoh qoʻshish»ni tanlang.'**
  String get commentsEmpty;

  /// No description provided for @commentsReply.
  ///
  /// In uz, this message translates to:
  /// **'Javob yozish'**
  String get commentsReply;

  /// No description provided for @commentsHint.
  ///
  /// In uz, this message translates to:
  /// **'Izoh yozing'**
  String get commentsHint;

  /// No description provided for @commentsSend.
  ///
  /// In uz, this message translates to:
  /// **'Yuborish'**
  String get commentsSend;

  /// No description provided for @commentsDelete.
  ///
  /// In uz, this message translates to:
  /// **'Oʻchirish'**
  String get commentsDelete;

  /// No description provided for @commentsDeleteConfirm.
  ///
  /// In uz, this message translates to:
  /// **'Izoh oʻchirilsinmi?'**
  String get commentsDeleteConfirm;

  /// No description provided for @commentsTooLong.
  ///
  /// In uz, this message translates to:
  /// **'Izoh juda uzun.'**
  String get commentsTooLong;

  /// No description provided for @commentsSegmentGone.
  ///
  /// In uz, this message translates to:
  /// **'Oʻchirilgan segment'**
  String get commentsSegmentGone;

  /// No description provided for @commentsYou.
  ///
  /// In uz, this message translates to:
  /// **'Siz'**
  String get commentsYou;

  /// No description provided for @ratingTitle.
  ///
  /// In uz, this message translates to:
  /// **'Transkript sifati'**
  String get ratingTitle;

  /// No description provided for @ratingHint.
  ///
  /// In uz, this message translates to:
  /// **'Bahoyingizni faqat siz koʻrasiz. U sifatni yaxshilashga yordam beradi.'**
  String get ratingHint;

  /// No description provided for @ratingStar.
  ///
  /// In uz, this message translates to:
  /// **'{count} yulduz'**
  String ratingStar(int count);

  /// No description provided for @ratingSaved.
  ///
  /// In uz, this message translates to:
  /// **'Baho saqlandi.'**
  String get ratingSaved;

  /// No description provided for @retranscribeBody.
  ///
  /// In uz, this message translates to:
  /// **'Fayl qaytadan transkripsiya qilinadi va balansdan daqiqa yechiladi.'**
  String get retranscribeBody;

  /// No description provided for @retranscribeMinutes.
  ///
  /// In uz, this message translates to:
  /// **'Taxminan {minutes} daqiqa sarflanadi.'**
  String retranscribeMinutes(int minutes);

  /// No description provided for @retranscribeConfirm.
  ///
  /// In uz, this message translates to:
  /// **'Boshlash'**
  String get retranscribeConfirm;

  /// No description provided for @retranscribeActive.
  ///
  /// In uz, this message translates to:
  /// **'Bu fayl allaqachon transkripsiya qilinmoqda.'**
  String get retranscribeActive;

  /// No description provided for @retranscribeGone.
  ///
  /// In uz, this message translates to:
  /// **'Audio oʻchirilgan — qayta transkripsiya qilib boʻlmaydi.'**
  String get retranscribeGone;

  /// No description provided for @exportStepStyle.
  ///
  /// In uz, this message translates to:
  /// **'Uslub'**
  String get exportStepStyle;

  /// No description provided for @exportStepFormat.
  ///
  /// In uz, this message translates to:
  /// **'Format'**
  String get exportStepFormat;

  /// No description provided for @exportNext.
  ///
  /// In uz, this message translates to:
  /// **'Keyingi'**
  String get exportNext;

  /// No description provided for @exportTimedOnly.
  ///
  /// In uz, this message translates to:
  /// **'Vaqt boʻyicha boʻlinadi — uslub qoʻllanmaydi.'**
  String get exportTimedOnly;

  /// No description provided for @exportTableHint.
  ///
  /// In uz, this message translates to:
  /// **'Jadval: vaqt, maʼruzachi va matn ustunlari.'**
  String get exportTableHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
