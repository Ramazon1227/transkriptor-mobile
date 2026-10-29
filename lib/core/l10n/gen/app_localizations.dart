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

  /// No description provided for @settingsLinkBody.
  ///
  /// In uz, this message translates to:
  /// **'Sahifani brauzerda oching:'**
  String get settingsLinkBody;

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
