// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'Transkriptor';

  @override
  String get retry => 'Qayta urinish';

  @override
  String get loading => 'Yuklanmoqda';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get close => 'Yopish';

  @override
  String get back => 'Orqaga';

  @override
  String get errorNetwork => 'Internetga ulanib boʻlmadi. Aloqani tekshiring.';

  @override
  String get errorTimeout =>
      'Server javob bermadi. Birozdan keyin qayta urining.';

  @override
  String get errorUnauthorized => 'Sessiya tugadi. Qaytadan kiring.';

  @override
  String get errorServer => 'Serverda xatolik yuz berdi.';

  @override
  String get errorParsing => 'Serverdan kutilmagan javob keldi.';

  @override
  String get errorUnknown => 'Nimadir notoʻgʻri ketdi.';

  @override
  String get errorMicPermission =>
      'Mikrofonga ruxsat berilmagan. Telefon sozlamalarida ruxsat bering.';

  @override
  String get errorStorage => 'Faylni saqlab yoki oʻqib boʻlmadi.';

  @override
  String get errorCaptureUnsupported =>
      'Ekran ovozini yozish Android 10 va undan yangi versiyalarda ishlaydi.';

  @override
  String get errorCaptureConsent => 'Ekranni yozishga ruxsat berilmadi.';

  @override
  String get errorCaptureBusy => 'Yozib olish allaqachon ketmoqda.';

  @override
  String get errorCaptureFailed =>
      'Ekran ovozini yozib boʻlmadi. Baʼzi ilovalar (koʻpincha qoʻngʻiroq ilovalari) oʻz ovozini yozishga ruxsat bermaydi.';

  @override
  String get errorNoBalance => 'Balansda daqiqa qolmagan.';

  @override
  String get errorTooLarge => 'Fayl juda katta.';

  @override
  String get errorTooManyRequests =>
      'Juda koʻp urinish. Bir daqiqadan keyin qayta urining.';

  @override
  String get navFiles => 'Fayllar';

  @override
  String get loginTitle => 'Ovozni matnga';

  @override
  String get loginSubtitle =>
      'Oʻzbekcha nutq uchun transkripsiya. Hisobingizga kiring.';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Parol';

  @override
  String get loginButton => 'Kirish';

  @override
  String get loginEmailRequired => 'Emailni kiriting';

  @override
  String get loginPasswordRequired => 'Parolni kiriting';

  @override
  String get loginWrongCredentials => 'Email yoki parol notoʻgʻri.';

  @override
  String get showPassword => 'Parolni koʻrsatish';

  @override
  String get hidePassword => 'Parolni yashirish';

  @override
  String get loginNoAccount => 'Hisobingiz yoʻqmi?';

  @override
  String get registerTitle => 'Hisob ochish';

  @override
  String get registerSubtitle =>
      'Email va parol yetarli. Hisob ochilgach darhol kirasiz.';

  @override
  String get registerName => 'Ism';

  @override
  String get registerNameHint =>
      'Ixtiyoriy — transkriptlarda va jamoada koʻrinadi';

  @override
  String get registerEmailInvalid => 'Email shakli notoʻgʻri';

  @override
  String get registerEmailTaken =>
      'Bu email bilan hisob allaqachon bor. Kirib koʻring.';

  @override
  String get registerButton => 'Roʻyxatdan oʻtish';

  @override
  String get registerHaveAccount => 'Hisobingiz bormi?';

  @override
  String get passwordRules =>
      'Kamida 10 belgi: harf va kamida bitta raqam yoki belgi';

  @override
  String get passwordTooShort => 'Parol kamida 10 belgi boʻlishi kerak';

  @override
  String get passwordTooLong => 'Parol juda uzun (koʻpi bilan 72 bayt)';

  @override
  String get passwordNeedsMix =>
      'Parolda harf va kamida bitta raqam yoki belgi boʻlishi kerak';

  @override
  String get loginForgot => 'Parolni unutdingizmi?';

  @override
  String get forgotTitle => 'Parolni tiklash';

  @override
  String get forgotSubtitle =>
      'Hisobingiz pochtasini kiriting — tiklash havolasini yuboramiz.';

  @override
  String get forgotSubmit => 'Havola yuborish';

  @override
  String get forgotSentTitle => 'Pochtangizni tekshiring';

  @override
  String forgotSentBody(String email) {
    return 'Agar $email bilan hisob boʻlsa, unga parolni tiklash havolasi yuborildi.';
  }

  @override
  String get forgotSentHint =>
      'Havola brauzerda ochiladi: yangi parolni oʻsha yerda oʻrnatib, shu ilovaga qayta kiring. U faqat bir marta ishlaydi, muddati xatda yozilgan. Xat kelmasa, «Spam» papkasini koʻring yoki bir daqiqadan keyin qayta soʻrang.';

  @override
  String get forgotSendAgain => 'Qayta yuborish';

  @override
  String get forgotRemembered => 'Parol esingizga tushdimi?';

  @override
  String get forgotUnavailable =>
      'Parolni tiklash hozircha ishlamaydi — pochta xizmati ulanmagan.';

  @override
  String get homeRecent => 'Soʻnggi fayllar';

  @override
  String get homeSeeAll => 'Hammasi';

  @override
  String get balanceLabel => 'Balans';

  @override
  String minutesShort(int minutes) {
    return '$minutes daq';
  }

  @override
  String get loginOr => 'yoki';

  @override
  String get loginGoogle => 'Google bilan kirish';

  @override
  String get loginGoogleUnverified =>
      'Google bu pochtani tasdiqlamagan — email va parol bilan kiring.';

  @override
  String get loginGoogleRejected =>
      'Google kirishi tasdiqlanmadi. Qaytadan urinib koʻring.';

  @override
  String get loginGoogleDisabled => 'Google bilan kirish serverda yoqilmagan.';

  @override
  String get loginGoogleUnavailable =>
      'Google hozir javob bermayapti. Birozdan keyin urinib koʻring.';

  @override
  String get loginGoogleFailed =>
      'Google bilan kirib boʻlmadi. Telefonda Google Play xizmatlari borligini tekshiring.';

  @override
  String get filesTitle => 'Fayllar';

  @override
  String get filesEmptyTitle => 'Hali fayl yoʻq';

  @override
  String get filesEmptyBody =>
      'Birinchi suhbatni yozib oling yoki telefoningizdagi audio faylni yuklang. Natija shu yerda paydo boʻladi.';

  @override
  String get filesAll => 'Hammasi';

  @override
  String get filesFolderEmpty => 'Papka boʻsh.';

  @override
  String get filesFolderEmptyHint =>
      'Faylni bosib turing va «Papkaga koʻchirish»ni tanlang.';

  @override
  String get filesTagAll => 'Teg: hammasi';

  @override
  String get filesForbidden =>
      'Bu ish maydonida fayllarni oʻzgartirish huquqingiz yoʻq.';

  @override
  String get folderNew => 'Papka';

  @override
  String get folderCreateTitle => 'Yangi papka';

  @override
  String get folderRenameTitle => 'Papkani qayta nomlash';

  @override
  String get folderNameHint => 'Papka nomi';

  @override
  String folderNameInvalid(int max) {
    return 'Nom boʻsh boʻlmasin va $max belgidan oshmasin.';
  }

  @override
  String get folderExists =>
      'Shu nomli papka allaqachon bor yoki papkalar soni chegarasiga yetgan.';

  @override
  String get folderRename => 'Nomini oʻzgartirish';

  @override
  String get folderDelete => 'Oʻchirish';

  @override
  String get folderDeleteTitle => 'Papkani oʻchirish';

  @override
  String folderDeleteBody(String name, int count) {
    return '«$name» papkasi oʻchadi. Ichidagi $count ta fayl oʻchmaydi — papkasiz qoladi va «Hammasi»da koʻrinadi.';
  }

  @override
  String folderDeleteEmptyBody(String name) {
    return '«$name» papkasi oʻchadi. Papka boʻsh.';
  }

  @override
  String get folderNone => 'Papkasiz';

  @override
  String get folderGone =>
      'Papka topilmadi — u boshqa joyda oʻchirilgan boʻlishi mumkin. Roʻyxatni yangilang.';

  @override
  String get fileMove => 'Papkaga koʻchirish';

  @override
  String get fileTags => 'Teglar';

  @override
  String get tagNewHint => 'Yangi teg';

  @override
  String get tagAdd => 'Qoʻshish';

  @override
  String tagInvalid(int max) {
    return 'Teg boʻsh boʻlmasin, vergul boʻlmasin va $max belgidan oshmasin.';
  }

  @override
  String tagTooMany(int max) {
    return 'Bir faylda koʻpi bilan $max ta teg.';
  }

  @override
  String get tagsNone => 'Teglar yoʻq';

  @override
  String get actionSave => 'Saqlash';

  @override
  String get statusQueued => 'Navbatda';

  @override
  String get statusRunning => 'Ishlanmoqda';

  @override
  String get statusDone => 'Tayyor';

  @override
  String get statusFailed => 'Xato';

  @override
  String get statusCancelled => 'Bekor qilingan';

  @override
  String get statusSaved => 'Saqlangan';

  @override
  String get sourceUpload => 'Yuklangan';

  @override
  String get sourceRecording => 'Yozib olingan';

  @override
  String get sourceYoutube => 'YouTube';

  @override
  String get sourceDrive => 'Google Drive';

  @override
  String get sourceDropbox => 'Dropbox';

  @override
  String get sourceLink => 'Havola';

  @override
  String get sourceApi => 'API';

  @override
  String get kindVideo => 'video';

  @override
  String get kindAudio => 'audio';

  @override
  String get recorderReady => 'Yozishga tayyor';

  @override
  String get recorderStarting => 'Mikrofon ochilmoqda…';

  @override
  String get recorderRecording => 'Yozilmoqda';

  @override
  String get recorderPaused => 'Pauza';

  @override
  String get recorderStart => 'Boshlash';

  @override
  String get recorderPause => 'Pauza';

  @override
  String get recorderResume => 'Davom etish';

  @override
  String get recorderStop => 'Tugatish';

  @override
  String get recorderFormat => 'AAC · 16 kGs · mono';

  @override
  String get recorderDiscardTitle => 'Yozuv oʻchirilsinmi?';

  @override
  String get recorderDiscardBody => 'Yozib olingan ovoz saqlanmaydi.';

  @override
  String get recorderDiscardConfirm => 'Oʻchirish';

  @override
  String get recorderKeep => 'Yozishni davom ettirish';

  @override
  String recordingName(String date) {
    return 'Yozuv $date';
  }

  @override
  String get sendTitle => 'Yuborish';

  @override
  String get sendName => 'Nomi';

  @override
  String get sendRecorded => 'Yozib olingan';

  @override
  String get sendPicked => 'Tanlangan fayl';

  @override
  String sizeMb(String size) {
    return '$size MB';
  }

  @override
  String get speakersLabel => 'Maʼruzachilar soni';

  @override
  String get speakersAuto => 'Avto';

  @override
  String get speakersHint => 'Bilsangiz koʻrsating — ajratish aniqroq boʻladi.';

  @override
  String get sendThisFile => 'Bu fayl';

  @override
  String sendApproxMinutes(int minutes) {
    return '≈ $minutes daq';
  }

  @override
  String get sendUploadFree =>
      'Yuklash daqiqa sarflamaydi — daqiqa transkripsiya boshlanganda band qilinadi.';

  @override
  String get sendStart => 'Transkripsiyani boshlash';

  @override
  String get sendSaveOnly => 'Faqat saqlash';

  @override
  String sendUploading(int percent) {
    return 'Yuklanmoqda · $percent%';
  }

  @override
  String get sendSaved => 'Fayl saqlandi.';

  @override
  String get sendStoredNotStarted =>
      'Fayl saqlandi, lekin transkripsiya boshlanmadi. Daqiqa band qilinmadi.';

  @override
  String get sendGoToFiles => 'Fayllarga oʻtish';

  @override
  String get linkTitle => 'Havola orqali';

  @override
  String get linkLabel => 'Havola';

  @override
  String get linkPaste => 'Qoʻyish';

  @override
  String get linkInvalid =>
      'Bu havolani ochib boʻlmaydi. YouTube, Google Drive yoki Dropbox havolasini kiriting.';

  @override
  String get linkWhich => 'Qaysi havolalar ishlaydi';

  @override
  String get linkYoutubeBody => 'video yoki Shorts';

  @override
  String get linkDriveBody => '«havolasi borlar» uchun ochiq fayl';

  @override
  String get linkDropboxBody => 'ommaviy havola';

  @override
  String get linkServerFetches =>
      'Faylni server oʻzi yuklab oladi — telefon trafigi sarflanmaydi.';

  @override
  String get jobKeepsRunning =>
      'Ilovani yopsangiz ham ish davom etadi — tayyor transkript Fayllar boʻlimida paydo boʻladi.';

  @override
  String get jobQueuedHint => 'Navbatda turibdi — tez orada boshlanadi.';

  @override
  String get jobCancel => 'Bekor qilish';

  @override
  String get jobCancelNote =>
      'Bekor qilsangiz band qilingan daqiqalar qaytariladi.';

  @override
  String get jobDoneTitle => 'Transkript tayyor';

  @override
  String get jobOpenTranscript => 'Transkriptni ochish';

  @override
  String get jobFailedTitle => 'Transkripsiya bajarilmadi';

  @override
  String get jobFailedRefund => 'Band qilingan daqiqalar balansga qaytarildi.';

  @override
  String get jobCancelledTitle => 'Transkripsiya bekor qilindi';

  @override
  String get transcriptAll => 'Hammasi';

  @override
  String get transcriptEmpty => 'Bu yozuvda nutq topilmadi.';

  @override
  String get transcriptNoSpeaker => 'Maʼruzachi';

  @override
  String transcriptSpeakers(int count) {
    return '$count maʼruzachi';
  }

  @override
  String get transcriptEdited => 'tahrirlangan';

  @override
  String get transcriptEditSegment => 'Matnni tahrirlash';

  @override
  String get transcriptRenameSpeaker => 'Maʼruzachi nomi';

  @override
  String get transcriptSave => 'Saqlash';

  @override
  String get transcriptTextTooLong => 'Matn juda uzun.';

  @override
  String get transcriptLabelTooLong => 'Nom juda uzun.';

  @override
  String get transcriptEditForbidden =>
      'Bu ish maydonida faqat oʻqish huquqingiz bor.';

  @override
  String get transcriptEditStale =>
      'Transkript boshqa joyda oʻzgartirildi, yangi nusxasi yuklandi. Matningizni tekshirib, yana saqlang.';

  @override
  String get transcriptEditInvalid => 'Saqlab boʻlmadi: matn qabul qilinmadi.';

  @override
  String get transcriptEditGone => 'Bu qism transkriptdan oʻchirilgan.';

  @override
  String get transcriptEditUnprocessable =>
      'Bu amalni bajarib boʻlmadi. Transkriptni yangilab, qayta urinib koʻring.';

  @override
  String get transcriptAssignSpeaker => 'Maʼruzachi';

  @override
  String get transcriptNewSpeaker => 'Yangi maʼruzachi';

  @override
  String get transcriptSplit => 'Kursor joyida boʻlish';

  @override
  String get transcriptMergeNext => 'Keyingisi bilan qoʻshish';

  @override
  String get shareTitle => 'Ulashish';

  @override
  String get shareOpen => 'Havola ochish';

  @override
  String get shareIncludeMedia => 'Audio ham koʻrinsin';

  @override
  String get shareIncludeMediaHint =>
      'Oʻchirilsa, faqat matn oʻqiladi — ovoz yuklanmaydi.';

  @override
  String get shareExpiry => 'Muddati';

  @override
  String shareDays(int count) {
    return '$count kun';
  }

  @override
  String get shareOneYear => '1 yil';

  @override
  String get shareNoExpiry => 'Muddatsiz';

  @override
  String get shareLinkLabel => 'Havola';

  @override
  String get shareCopy => 'Nusxa olish';

  @override
  String get shareCopied => 'Nusxalandi';

  @override
  String get shareShownOnce =>
      'Bu havola faqat hozir koʻrinadi — bazada tokenning xeshi saqlanadi. Yopgandan keyin qayta olinmaydi.';

  @override
  String get shareActive => 'Amaldagi havolalar';

  @override
  String shareUntil(String date) {
    return '$date gacha';
  }

  @override
  String get shareNoExpiryShort => 'muddatsiz';

  @override
  String shareViews(int count) {
    return '$count marta ochilgan';
  }

  @override
  String get shareWithAudio => 'audio bilan';

  @override
  String get shareRevoke => 'Bekor qilish';

  @override
  String get shareForbidden =>
      'Bu ish maydonida havola ochish huquqingiz yoʻq.';

  @override
  String get exportTitle => 'Eksport';

  @override
  String get exportTimecodes => 'Vaqt belgilari';

  @override
  String get exportSpeakers => 'Maʼruzachi nomlari';

  @override
  String get exportPlainApostrophe => 'Oddiy apostrof (o\'zbek, ta\'lim)';

  @override
  String get exportPlainApostropheHint =>
      'Koʻp odam shu belgi bilan qidiradi va yozadi. Saqlangan matn oʻzgarmaydi.';

  @override
  String get exportShare => 'Faylni saqlash yoki yuborish';

  @override
  String get exportLayout => 'Matn tuzilishi';

  @override
  String get exportLayoutSegments => 'Segmentlar';

  @override
  String get exportLayoutSpeaker => 'Maʼruzachi boʻyicha';

  @override
  String get exportLayoutParagraphs => 'Paragraflar';

  @override
  String get exportLayoutSingle => 'Bitta paragraf';

  @override
  String get exportSentences => 'Paragrafda gap';

  @override
  String exportSentenceCount(int count) {
    return '$count ta gap';
  }

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileLogout => 'Chiqish';

  @override
  String get profileLogoutTitle => 'Hisobdan chiqasizmi?';

  @override
  String get navStudio => 'Studio';

  @override
  String get navNew => 'Yangi transkripsiya';

  @override
  String get comingSoon => 'Tez orada';

  @override
  String get comingSoonBody =>
      'Bu imkoniyat ustida ishlayapmiz. Hozircha boshqa usullardan foydalaning.';

  @override
  String get demoBanner => 'Namuna — server hali tayyor emas';

  @override
  String get sourceSheetTitle => 'Boshlash';

  @override
  String get sourceUploadTitle => 'Fayl yuklash';

  @override
  String get sourceUploadBody =>
      'Telefondagi audio yoki videoni matnga aylantiring';

  @override
  String get sourceYoutubeTitle => 'YouTubeʼdan';

  @override
  String get sourceYoutubeBody =>
      'Video havolasini qoʻying — server oʻzi yuklab oladi';

  @override
  String get sourceRecordTitle => 'Audio yozib olish';

  @override
  String get sourceRecordBody =>
      'Suhbat, majlis, maʼruza — telefon mikrofonidan';

  @override
  String get sourceDictationTitle => 'Jonli diktovka';

  @override
  String get sourceDictationBody => 'Gapiring — matn shu zahoti paydo boʻladi';

  @override
  String get sourceRealtimeBadge => 'Real vaqt';

  @override
  String get sourceScreenTitle => 'Ekranni yozish';

  @override
  String get sourceScreenBody =>
      'Ekrandagi video va ovozni yozib, matnga aylantiring';

  @override
  String get sourceCloudTitle => 'Bulutdan';

  @override
  String get sourceCloudBody => 'Google Drive yoki Dropbox havolasi';

  @override
  String get sourceMeetingTitle => 'Onlayn uchrashuv';

  @override
  String get sourceMeetingBody => 'Google Meet uchrashuvini yozib olish';

  @override
  String get sourceUrlTitle => 'Havola orqali';

  @override
  String get sourceUrlBody => 'Internetdagi audio yoki video faylning havolasi';

  @override
  String homeWelcome(String name) {
    return 'Xush kelibsiz, $name';
  }

  @override
  String get homeWelcomeNoName => 'Xush kelibsiz';

  @override
  String get homeCardRecord => 'Yozib olish';

  @override
  String get homeCalendar => 'Kalendar';

  @override
  String get calendarNotConnected =>
      'Google Kalendar veb-ilovada ulanadi. Ulangach, yaqin uchrashuvlar shu yerda koʻrinadi.';

  @override
  String get calendarEmpty => 'Yaqin kunlarda uchrashuv yoʻq.';

  @override
  String calendarToday(String time) {
    return 'Bugun, $time';
  }

  @override
  String get settingsTitle => 'Sozlamalar';

  @override
  String get settingsAccount => 'Hisob';

  @override
  String get settingsBalance => 'Balans';

  @override
  String get settingsPlan => 'Tarif';

  @override
  String get settingsPlans => 'Tariflar';

  @override
  String get settingsProfile => 'Profil';

  @override
  String get settingsWorkspace => 'Ish maydoni';

  @override
  String get settingsApp => 'Ilova';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsLanguageUzbek => 'Oʻzbekcha';

  @override
  String get settingsNotifications => 'Bildirishnomalar';

  @override
  String get settingsNotificationsOn => 'Yoqilgan';

  @override
  String get settingsNotificationsOff => 'Bu versiyada sozlanmagan';

  @override
  String get settingsHelp => 'Yordam';

  @override
  String get settingsHelpCenter => 'Yordam markazi';

  @override
  String get settingsReportBug => 'Xato haqida xabar berish';

  @override
  String get settingsPrivacy => 'Maxfiylik siyosati';

  @override
  String get settingsTerms => 'Foydalanish shartlari';

  @override
  String get settingsVersion => 'Versiya';

  @override
  String get settingsDeleteAccount => 'Hisobni oʻchirish';

  @override
  String get settingsLinkBody => 'Sahifani brauzerda oching:';

  @override
  String get planStatusActive => 'Faol';

  @override
  String get planStatusPastDue => 'Toʻlov kutilmoqda';

  @override
  String get planStatusCancelled => 'Bekor qilingan';

  @override
  String get planStatusExpired => 'Muddati tugagan';

  @override
  String planRenews(String date) {
    return '$date da yangilanadi';
  }

  @override
  String planEnds(String date) {
    return '$date da tugaydi';
  }

  @override
  String planMinutesPerMonth(int minutes) {
    return 'Oyiga $minutes daqiqa';
  }

  @override
  String planMembers(int count) {
    return '$count kishigacha';
  }

  @override
  String planPrice(String price) {
    return '$price soʻm / oy';
  }

  @override
  String get plansTitle => 'Tariflar';

  @override
  String get planFree => 'Bepul';

  @override
  String get planCurrent => 'Joriy tarif';

  @override
  String get plansPaymentSoon =>
      'Ilova ichida toʻlov hali yoʻq — tez orada qoʻshiladi.';

  @override
  String get plansEmpty => 'Tariflar hali eʼlon qilinmagan.';

  @override
  String get roleOwner => 'Egasi';

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get roleMember => 'Aʼzo';

  @override
  String get roleViewer => 'Kuzatuvchi';

  @override
  String get workspacePersonal => 'Shaxsiy';

  @override
  String get workspaceSwitchTitle => 'Ish maydoni';

  @override
  String get profileName => 'Ism';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileSignIn => 'Kirish usuli';

  @override
  String get profileSignInGoogle => 'Google';

  @override
  String get profileSignInPassword => 'Email va parol';

  @override
  String get deleteTitle => 'Hisobni oʻchirish';

  @override
  String get deleteBody =>
      'Shaxsiy ish maydoningiz va faqat siz aʼzo boʻlgan ish maydonlari barcha fayllari bilan oʻchadi, faol transkripsiyalar bekor qilinadi. Boshqa ish maydonlaridan chiqarilasiz. Buni qaytarib boʻlmaydi.';

  @override
  String get deletePasswordLabel => 'Tasdiqlash uchun parolingiz';

  @override
  String get deleteEmailLabel => 'Tasdiqlash uchun emailingizni yozing';

  @override
  String deleteEmailHint(String email) {
    return '$email';
  }

  @override
  String get deleteConfirm => 'Hisobni butunlay oʻchirish';

  @override
  String get deleteRequired => 'Maydonni toʻldiring';

  @override
  String get deleteWrong => 'Parol yoki email mos kelmadi.';

  @override
  String get deleteSoleOwner =>
      'Siz boshqa aʼzolari bor ish maydonining yagona egasisiz. Avval egalikni boshqa aʼzoga bering.';

  @override
  String get logoutBody =>
      'Bu telefondan chiqasiz. Fayllaringiz joyida qoladi.';

  @override
  String get filesTabUploads => 'Yuklangan';

  @override
  String get filesTabMeetings => 'Uchrashuvlar';

  @override
  String get filesTabRecordings => 'Yozuvlar';

  @override
  String get filesTabLinks => 'Havolalar';

  @override
  String get filesTabNotes => 'Eslatmalar';

  @override
  String get filesMenuCreateFolder => 'Papka yaratish';

  @override
  String get filesMenuWorkspaces => 'Ish maydonlari';

  @override
  String get filesSearch => 'Qidirish';

  @override
  String get filesSearchHint => 'Nomi boʻyicha qidirish';

  @override
  String get filesSearchClose => 'Qidiruvni yopish';

  @override
  String get filesSearchEmpty => 'Hech narsa topilmadi.';

  @override
  String get filesMore => 'Amallar';

  @override
  String get filesFailed => 'Bajarilmadi';

  @override
  String get filesEmptyUploads => 'Yuklangan fayl hali yoʻq.';

  @override
  String get filesEmptyMeetings => 'Uchrashuv yozuvlari hali yoʻq.';

  @override
  String get filesEmptyRecordings => 'Yozib olingan audio hali yoʻq.';

  @override
  String get filesEmptyLinks => 'Havoladan olingan fayl hali yoʻq.';

  @override
  String get filesEmptyNotes =>
      'Eslatmalar hali yoʻq. Transkriptni veb-ilovada eslatma sifatida saqlang — u shu yerda paydo boʻladi.';

  @override
  String get fileRenameTitle => 'Faylni qayta nomlash';

  @override
  String get fileNameHint => 'Fayl nomi';

  @override
  String fileNameInvalid(int max) {
    return 'Nom boʻsh boʻlmasin va $max belgidan oshmasin.';
  }

  @override
  String get fileRetranscribe => 'Qayta transkripsiya';

  @override
  String get fileRetranscribeBody =>
      'Fayl qaytadan matnga aylantiriladi, uning davomiyligi balansdan yechiladi.';

  @override
  String fileRetranscribeCost(int minutes) {
    return 'Balansdan $minutes daqiqa yechiladi.';
  }

  @override
  String get fileRetranscribeConfirm => 'Boshlash';

  @override
  String get fileRetranscribeConflict =>
      'Bu fayl uchun transkripsiya allaqachon ketyapti.';

  @override
  String get fileRetranscribeNotReady =>
      'Fayl hali toʻliq yuklanmagan — uni qayta transkripsiya qilib boʻlmaydi.';

  @override
  String get fileDeleteTitle => 'Faylni oʻchirish';

  @override
  String fileDeleteBody(String name) {
    return '«$name» va uning transkripti oʻchadi, ulashilgan havolalar ishlamay qoladi. Buni qaytarib boʻlmaydi.';
  }

  @override
  String get fileDeleteRunning =>
      'Davom etayotgan transkripsiya bekor qilinadi, band qilingan daqiqalar qaytariladi.';

  @override
  String get noteUntitled => 'Nomsiz eslatma';

  @override
  String get noteCopy => 'Matndan nusxa olish';

  @override
  String get noteCopied => 'Matn nusxalandi';

  @override
  String get noteRenameTitle => 'Eslatmani qayta nomlash';

  @override
  String get noteTitleHint => 'Sarlavha';

  @override
  String noteTitleInvalid(int max) {
    return 'Sarlavha $max belgidan oshmasin.';
  }

  @override
  String get noteDeleteTitle => 'Eslatmani oʻchirish';

  @override
  String noteDeleteBody(String name) {
    return '«$name» eslatmasi oʻchadi. Buni qaytarib boʻlmaydi.';
  }

  @override
  String noteFromTranscript(String title) {
    return 'Transkriptdan: $title';
  }

  @override
  String get noteSourceGone => 'Asl fayl oʻchirilgan';

  @override
  String noteUpdated(String date) {
    return 'Oʻzgartirilgan: $date';
  }

  @override
  String get noteEmpty => 'Eslatma boʻsh.';

  @override
  String get noteStale => 'Eslatma boshqa oynada oʻzgargan. Uni qayta oching.';

  @override
  String get recorderTapToStart => 'Yozishni boshlash uchun tugmani bosing';

  @override
  String get recorderRecord => 'Yozish';

  @override
  String get recorderDiscard => 'Oʻchirish';

  @override
  String get recorderScreenOff =>
      'Ekran oʻchsa yoki boshqa ilovaga oʻtsangiz ham yozish davom etadi.';

  @override
  String get recorderMicDeniedTitle => 'Mikrofonga ruxsat yoʻq';

  @override
  String get recorderMicDeniedBody =>
      'Yozish uchun mikrofon kerak. Telefon sozlamalarini oching: Ilovalar → Transkriptor → Ruxsatlar → Mikrofon → «Ruxsat berish». Keyin shu yerga qaytib, «Qayta urinish»ni bosing.';

  @override
  String recoveryBannerOne(String duration, String when) {
    return 'Yuborilmagan yozuv bor — $duration, $when';
  }

  @override
  String recoveryBannerMany(int count) {
    return 'Yuborilmagan yozuvlar: $count ta';
  }

  @override
  String get recoveryCardTitle => 'Yuborilmagan yozuvlar';

  @override
  String get recoveryCardBody =>
      'Oldingi yozuvlar telefonda saqlanib qolgan. Ularni hozir yuborish yoki oʻchirish mumkin.';

  @override
  String get recoverySheetTitle => 'Yuborilmagan yozuvlar';

  @override
  String get recoveryOpen => 'Koʻrish va yuborish';

  @override
  String get recoverySend => 'Yuborish';

  @override
  String get recoveryDelete => 'Oʻchirish';

  @override
  String get recoveryDeleteAsk => 'Bu yozuv butunlay oʻchirilsinmi?';

  @override
  String get recoveryDeleteYes => 'Ha, oʻchirish';

  @override
  String get recoveryDeleteNo => 'Yoʻq';

  @override
  String get recoveryInterrupted => 'Uzilgan';

  @override
  String get recoveryInterruptedHint =>
      'Ilova yopilib qolgan — oxirgi soniyalargacha tiklanadi';

  @override
  String get recoveryKindMic => 'Mikrofon';

  @override
  String get recoveryKindScreen => 'Ekran ovozi';

  @override
  String get recoveryUnknownLength => 'uzunligi nomaʼlum';

  @override
  String recoveryToday(String time) {
    return 'bugun $time';
  }

  @override
  String recoveryYesterday(String time) {
    return 'kecha $time';
  }

  @override
  String recoveryOn(String date, String time) {
    return '$date $time';
  }

  @override
  String screenRecordingName(String date) {
    return 'Ekran yozuvi $date';
  }

  @override
  String get screenIntro =>
      'Telefonda ijro etilayotgan ovozni yozib oladi va matnga aylantiradi.';

  @override
  String get screenWhatYes =>
      'Yoziladi: videolar, brauzer, ilovalardagi ovoz — telefon oʻzi nimani ijro etsa.';

  @override
  String get screenWhatNoCalls =>
      'Telefon qoʻngʻiroqlari va messenjer qoʻngʻiroqlari yozilmaydi — Android ularni yozishga ruxsat bermaydi.';

  @override
  String get screenWhatBlocked =>
      'Baʼzi ilovalar oʻz ovozini yozishni taqiqlaydi. Unda ularning oʻrnida jimlik yoziladi.';

  @override
  String get screenWhatNoVideo => 'Tasvir yozilmaydi — faqat ovoz.';

  @override
  String get screenWithMic => 'Mikrofonni ham yozish';

  @override
  String get screenWithMicBody => 'Oʻzingizning ovozingiz ham qoʻshiladi';

  @override
  String get screenStart => 'Yozishni boshlash';

  @override
  String get screenConsentNote =>
      'Android ruxsat soʻraydi: oynada «Boshlash»ni bosing.';

  @override
  String get screenStarting => 'Ruxsat kutilmoqda…';

  @override
  String get screenStopping => 'Yozuv saqlanmoqda…';

  @override
  String get screenRecordingHint =>
      'Telefondan odatdagidek foydalaning — yozuv fonda davom etadi. Toʻxtatish bildirishnomada ham bor.';

  @override
  String get screenSilentTitle => 'Ovoz kelmayapti';

  @override
  String get screenSilentBody =>
      'Hozir hech narsa ijro etilmayapti yoki ijro etayotgan ilova yozishga ruxsat bermaydi (qoʻngʻiroq ilovalari shunday).';

  @override
  String get screenWithMicOn => 'Mikrofon ham yozilmoqda';

  @override
  String get screenCancelTitle => 'Ekran yozuvi bekor qilinsinmi?';

  @override
  String get screenCancelBody => 'Yozib olingan ovoz saqlanmaydi.';

  @override
  String get screenUnsupportedTitle => 'Bu telefonda ishlamaydi';

  @override
  String get screenUnsupportedBody =>
      'Telefondagi ovozni yozish Android 10 va undan yangi versiyalarda bor. iPhone bunday yozishga ruxsat bermaydi. Oʻrniga «Audio yozib olish» yoki «Fayl yuklash»dan foydalaning.';

  @override
  String get screenHintConsent =>
      'Tizim oynasida «Boshlash»ni bosmasangiz, yozish boshlanmaydi.';

  @override
  String get screenHintMic =>
      'Android telefondagi ovozni yozish uchun ham mikrofon ruxsatini talab qiladi — mikrofon aralashtirilmasa ham. Sozlamalar → Ilovalar → Transkriptor → Ruxsatlar → Mikrofon.';

  @override
  String get screenHintBusy =>
      'Avval boshqa yozuvni toʻxtating (bildirishnomaga qarang).';

  @override
  String get screenHintFailed =>
      'Qayta urinib koʻring. Takrorlansa, telefonni qayta ishga tushiring.';

  @override
  String get screenKeptPartial =>
      'Yozish toʻxtab qoldi, lekin shu paytgacha yozilgani saqlandi.';

  @override
  String get meetHeadline => 'Google Meet uchrashuvini yozib olish';

  @override
  String get meetIntro =>
      'Bot uchrashuvga mehmon sifatida kiradi, ovozni yozadi, uchrashuv tugagach matnga aylantiradi.';

  @override
  String get meetUrlLabel => 'Google Meet havolasi';

  @override
  String get meetUrlInvalid =>
      'Faqat Google Meet havolasi: https://meet.google.com/abc-defg-hij';

  @override
  String get meetKeepVideo => 'Videoni ham saqlash';

  @override
  String get meetKeepVideoBody =>
      'Ishtirokchilar kameralari yoziladi, fayl kattaroq boʻladi. Meet oynasining oʻzi yozilmaydi.';

  @override
  String get meetHostNote =>
      'Google Meet tashqi botlarni kutish zaliga qoʻyadi. Uchrashuv egasi botni «Qabul qilish» bilan kiritmaguncha hech narsa yozilmaydi.';

  @override
  String meetBotName(String name) {
    return 'Uchrashuvda bot «$name» nomi bilan koʻrinadi.';
  }

  @override
  String get meetJoin => 'Botni yuborish';

  @override
  String get meetRecent => 'Oxirgi uchrashuvlar';

  @override
  String get meetRecentEmpty => 'Hali bot yuborilmagan.';

  @override
  String get meetUnavailable => 'Uchrashuv boti bu serverda hozir oʻchiq.';

  @override
  String get meetRouteMissingTitle => 'Bu server versiyasida hali yoʻq';

  @override
  String get meetRouteMissingBody =>
      'Uchrashuv boti serverning keyingi versiyasi bilan keladi. Hozircha uchrashuvni «Audio yozib olish» bilan yozib oling.';

  @override
  String get meetStatusScheduled => 'Navbatda';

  @override
  String get meetStatusJoining => 'Uchrashuvga kirmoqda';

  @override
  String get meetStatusWaiting => 'Kutish zalida';

  @override
  String get meetStatusRecording => 'Yozilmoqda';

  @override
  String get meetStatusUploading => 'Qayta ishlanmoqda';

  @override
  String get meetStatusDone => 'Tayyor';

  @override
  String get meetStatusFailed => 'Xato';

  @override
  String get meetStatusDenied => 'Kiritilmadi';

  @override
  String get meetStatusCancelled => 'Bekor qilingan';

  @override
  String get meetStepWaitingHint =>
      'Uchrashuv egasi botni qabul qilishi kerak.';

  @override
  String get meetStepUploadingHint =>
      'Yozuv yuklanmoqda, keyin transkripsiya boshlanadi.';

  @override
  String get meetDeniedDefault => 'Uchrashuv egasi botni kiritmadi.';

  @override
  String get meetFailedDefault => 'Bot ishini yakunlay olmadi.';

  @override
  String get meetCancelledBody => 'Bot chaqirib olindi.';

  @override
  String get meetOpenResult => 'Transkriptni ochish';

  @override
  String get meetCancel => 'Botni chaqirib olish';

  @override
  String get meetCancelRecordingNote =>
      'Bot uchrashuvdan chiqadi. Shu paytgacha yozilgani baribir matnga aylantiriladi.';

  @override
  String get meetLeaving => 'Bot uchrashuvdan chiqmoqda…';

  @override
  String get meetNew => 'Yangi uchrashuv';

  @override
  String get meetPollFailed => 'Holatni yangilab boʻlmadi — qayta urinilmoqda.';

  @override
  String get urlIntro =>
      'Internetdagi audio yoki video faylning toʻgʻridan-toʻgʻri havolasi (.mp3, .mp4, .m4a…).';

  @override
  String get urlLabel => 'Fayl havolasi';

  @override
  String get urlInvalid =>
      'Havola http:// yoki https:// bilan boshlanishi va manzilga ega boʻlishi kerak.';

  @override
  String get urlPlatformsNote =>
      'YouTube, Google Drive va Dropbox havolalari shu yerdan ham ishlaydi — ular alohida yoʻl bilan yuboriladi.';

  @override
  String get urlSubmit => 'Davom etish';

  @override
  String get urlNotReady =>
      'Toʻgʻridan-toʻgʻri havoladan yuklash serverda hali yoʻq. Hozircha faylni telefonga yuklab olib, «Fayl yuklash» orqali yuboring.';

  @override
  String get urlBanner => 'Namuna — havoladan yuklash serverda hali yoʻq';

  @override
  String get dictationBanner =>
      'Namuna — jonli diktovka uchun server hali tayyor emas, matn namunaviy';

  @override
  String get dictationIntro =>
      'Gapiring — matn shu zahoti paydo boʻladi. Toʻxtatgach, uni qayd sifatida saqlash yoki nusxa olish mumkin.';

  @override
  String get dictationStart => 'Gapirishni boshlash';

  @override
  String get dictationStop => 'Toʻxtatish';

  @override
  String get dictationListening => 'Tinglanmoqda…';

  @override
  String get dictationEmpty => 'Matn shu yerda paydo boʻladi.';

  @override
  String get dictationSaveNote => 'Eslatma sifatida saqlash';

  @override
  String get dictationCopy => 'Nusxa olish';

  @override
  String get dictationCopied => 'Matn nusxalandi';

  @override
  String get dictationDiscard => 'Tashlab yuborish';

  @override
  String get dictationSaved => 'Eslatma saqlandi';

  @override
  String dictationNoteTitle(String date) {
    return 'Diktovka $date';
  }

  @override
  String get dictationSample1 =>
      'Bu namuna matn: jonli diktovka hali serverga ulanmagan.';

  @override
  String get dictationSample2 =>
      'Server oqimli endpoint olganda shu yerda sizning soʻzlaringiz chiqadi.';

  @override
  String get dictationSample3 =>
      'Hozircha ekranning qanday ishlashini koʻrish mumkin: avval xira matn, keyin tasdiqlangan gap.';

  @override
  String get dictationSample4 =>
      'Toʻxtatish tugmasini bosing va matnni eslatma sifatida saqlab koʻring.';

  @override
  String get aiMarker => 'AI';

  @override
  String get aiChatIntroTitle => 'Shu yozuv boʻyicha soʻrang';

  @override
  String get aiChatIntro =>
      'Javob faqat shu transkriptga tayanadi va vaqtga havola beradi — havolani bossangiz, pleyer oʻsha joyga oʻtadi.';

  @override
  String get aiChatSuggestionTopics => 'Asosiy mavzular qanday?';

  @override
  String get aiChatSuggestionWho => 'Kim nima dedi?';

  @override
  String get aiChatSuggestionDecisions => 'Qanday qarorlar qabul qilindi?';

  @override
  String get aiChatHint => 'Shu yozuv boʻyicha soʻrang';

  @override
  String get aiChatHintPending => 'Javob kutilmoqda…';

  @override
  String get aiChatSend => 'Yuborish';

  @override
  String get aiChatThinking =>
      'Transkriptni oʻqiyapti… Uzun yozuvda javob bir daqiqagacha olishi mumkin.';

  @override
  String get aiChatAnswerFailed => 'Javob olinmadi.';

  @override
  String get aiChatResend => 'Qayta yuborish';

  @override
  String get aiChatPrivate => 'Suhbatni faqat siz koʻrasiz.';

  @override
  String get aiChatClear => 'Suhbatni tozalash';

  @override
  String get aiChatClearTitle => 'Suhbat tozalansinmi?';

  @override
  String get aiChatClearBody =>
      'Bu transkript boʻyicha savol va javoblaringiz oʻchadi. Buni qaytarib boʻlmaydi.';

  @override
  String get aiChatClearConfirm => 'Tozalash';

  @override
  String get aiChatBusy => 'Oldingi savolga javob hali kelmadi — kuting.';

  @override
  String get aiChatUnavailable =>
      'AI hozir band yoki oʻchiq. Birozdan keyin qayta yuboring.';

  @override
  String get aiChatPollFailed =>
      'Javob holatini olib boʻlmadi — tarmoqni tekshiring.';

  @override
  String aiChatSeekTo(String time) {
    return '$time ga oʻtish';
  }

  @override
  String get summaryDemoBanner =>
      'Namuna — xulosa hozircha transkriptning oʻz gaplaridan yigʻiladi, uni AI yozmaydi.';

  @override
  String get summaryTooShort =>
      'Xulosa uchun transkript juda qisqa. Kamida uch qatorli yozuv kerak.';

  @override
  String get summaryTemplateLabel => 'Shablon';

  @override
  String get summaryTemplateDefault => 'Asosiy xulosa';

  @override
  String get summaryTemplatesTitle => 'Xulosa shabloni';

  @override
  String get summaryTemplatesFavorites => 'Sevimlilar';

  @override
  String get summaryTemplatesMine => 'Mening shablonlarim';

  @override
  String get summaryTemplatesEmpty =>
      'Shablonlar hali yoʻq — asosiy xulosa ishlatiladi.';

  @override
  String get summaryStar => 'Sevimlilarga qoʻshish';

  @override
  String get summaryUnstar => 'Sevimlilardan olib tashlash';

  @override
  String get summaryFavoriteFailed => 'Sevimlini saqlab boʻlmadi.';

  @override
  String get summaryEmptyTitle => 'Xulosa hali yoʻq';

  @override
  String get summaryEmptyBody => 'Shablonni tanlang va xulosa yarating.';

  @override
  String get summaryCreate => 'Xulosa yaratish';

  @override
  String get summaryGenerating => 'Xulosa yozilmoqda…';

  @override
  String get summaryCopy => 'Nusxalash';

  @override
  String get summaryRegenerate => 'Qayta yaratish';

  @override
  String get summaryDelete => 'Oʻchirish';

  @override
  String get summaryDeleteTitle => 'Xulosa oʻchirilsinmi?';

  @override
  String get summaryDeleteBody =>
      'Xulosa matni oʻchadi. Transkriptning oʻzi oʻzgarmaydi.';

  @override
  String get summarySaveNote => 'Eslatma sifatida saqlash';

  @override
  String get summaryNoteSaved => 'Eslatmalarga saqlandi';

  @override
  String summaryNoteTitle(String title) {
    return '$title — xulosa';
  }

  @override
  String get summarySectionOverview => 'Qisqacha';

  @override
  String get summarySectionKeyPoints => 'Asosiy fikrlar';

  @override
  String get summarySectionSpeakers => 'Maʼruzachilar';

  @override
  String get summarySectionNextSteps => 'Keyingi qadamlar';

  @override
  String get learnDemoBanner =>
      'Namuna — savollar transkript gaplaridan oddiy qoidalar bilan tuziladi, ularni AI yozmaydi.';

  @override
  String get learnTooShort =>
      'Oʻrganish uchun transkript juda qisqa. Kamida uch qatorli yozuv kerak.';

  @override
  String get learnIntro => 'Shu transkript mazmunini oʻrganing:';

  @override
  String get learnFlashcardsTitle => 'Kartochkalar';

  @override
  String get learnFlashcardsBody =>
      'Asosiy fikrlarni kartochkalar bilan yodlang.';

  @override
  String get learnQuizTitle => 'Test';

  @override
  String get learnQuizBody =>
      'Transkript boʻyicha savollar bilan oʻzingizni sinang.';

  @override
  String get learnCreateFlashcards => 'Kartochkalar yaratish';

  @override
  String get learnCreateQuiz => 'Test yaratish';

  @override
  String get learnCount => 'Savollar soni';

  @override
  String get learnDifficulty => 'Qiyinlik';

  @override
  String get learnEasy => 'Oson';

  @override
  String get learnMedium => 'Oʻrta';

  @override
  String get learnHard => 'Qiyin';

  @override
  String get learnQuestionType => 'Savol turi';

  @override
  String get learnMultipleChoice => 'Koʻp tanlovli';

  @override
  String get learnMultipleChoiceBody =>
      'Bir nechta variantdan toʻgʻrisini tanlang.';

  @override
  String get learnTrueFalse => 'Toʻgʻri / notoʻgʻri';

  @override
  String get learnTrueFalseBody =>
      'Gap transkriptdagidek toʻgʻrimi yoki yoʻqmi — aniqlang.';

  @override
  String get learnTypeRequired => 'Kamida bitta savol turini tanlang.';

  @override
  String get learnCreate => 'Yaratish';

  @override
  String get learnCreating => 'Tayyorlanmoqda…';

  @override
  String get learnEmptyResult =>
      'Bu matndan savol tuzib boʻlmadi — gaplar juda qisqa.';

  @override
  String get learnPrevious => 'Oldingi toʻplamlar';

  @override
  String learnFlashcardSetTitle(int count) {
    return 'Kartochkalar · $count ta';
  }

  @override
  String learnQuizSetTitle(int count) {
    return 'Test · $count ta savol';
  }

  @override
  String learnSetSubtitle(String difficulty, String time) {
    return '$difficulty · $time';
  }

  @override
  String learnProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get learnCardFront => 'Boʻsh joyga qaysi soʻz tushadi?';

  @override
  String get learnCardBack => 'Javob';

  @override
  String get learnTapToFlip => 'Javobni koʻrish uchun kartochkani bosing';

  @override
  String get learnKnow => 'Bilaman';

  @override
  String get learnRepeat => 'Takrorlash';

  @override
  String learnKnownCount(int count) {
    return 'Bilaman: $count';
  }

  @override
  String learnRepeatCount(int count) {
    return 'Takrorlash: $count';
  }

  @override
  String get learnPreviousCard => 'Oldingi';

  @override
  String get learnNextCard => 'Keyingi';

  @override
  String get learnFlashcardsDone => 'Toʻplam tugadi';

  @override
  String get learnRestart => 'Boshidan';

  @override
  String get learnRestartRepeat => 'Faqat takrorlanadiganlar';

  @override
  String get learnTrue => 'Toʻgʻri';

  @override
  String get learnFalse => 'Notoʻgʻri';

  @override
  String get learnQuizTrueFalsePrompt => 'Gap transkriptdagidek toʻgʻrimi?';

  @override
  String get learnQuizChoosePrompt => 'Boʻsh joyni toʻldiring';

  @override
  String get learnCorrect => 'Toʻgʻri javob!';

  @override
  String get learnWrong => 'Notoʻgʻri javob';

  @override
  String learnSource(String sentence) {
    return 'Transkriptda: «$sentence»';
  }

  @override
  String get learnFinish => 'Natija';

  @override
  String get learnScoreTitle => 'Natijangiz';

  @override
  String get learnReview => 'Javoblar';

  @override
  String learnYourAnswer(String answer) {
    return 'Sizning javobingiz: $answer';
  }

  @override
  String learnRightAnswer(String answer) {
    return 'Toʻgʻri javob: $answer';
  }

  @override
  String get editorTabTranscript => 'Transkript';

  @override
  String get editorTabAiChat => 'AI suhbat';

  @override
  String get editorTabSummary => 'Xulosa';

  @override
  String get editorTabLearn => 'Oʻrganish';

  @override
  String get editorTabSoon => 'Bu boʻlim tez orada shu yerda boʻladi.';

  @override
  String get editorMore => 'Fayl amallari';

  @override
  String get editorRenameTitle => 'Transkript nomi';

  @override
  String get editorShowSpeakers => 'Maʼruzachilarni koʻrsatish';

  @override
  String get editorFilterSpeakers => 'Maʼruzachi boʻyicha saralash';

  @override
  String get editorPlaybackSpeed => 'Ijro tezligi';

  @override
  String get editorEdit => 'Tahrirlash';

  @override
  String get editorComments => 'Izohlar';

  @override
  String get editorRating => 'Baho';

  @override
  String get editorRetranscribe => 'Qayta transkripsiya';

  @override
  String get editorEditHint => 'Satrni tahrirlash uchun ikki marta bosing';

  @override
  String get editorFollow => 'Joriy joyga';

  @override
  String get playerPlay => 'Ijro etish';

  @override
  String get playerPause => 'Pauza';

  @override
  String get playerBack => '5 soniya orqaga';

  @override
  String get playerForward => '5 soniya oldinga';

  @override
  String get playerFold => 'Videoni yigʻish';

  @override
  String get playerUnfold => 'Videoni ochish';

  @override
  String get playerGone =>
      'Audio saqlash muddati tugagani uchun oʻchirilgan. Matn joyida.';

  @override
  String get playerUnavailable =>
      'Bu yozuvning audiosi mavjud emas. Matn bilan ishlashingiz mumkin.';

  @override
  String get playerFailed => 'Audioni ochib boʻlmadi.';

  @override
  String get playerYoutubeBody =>
      'YouTube videosi ilova ichida ijro etilmaydi. Matn bilan shu yerda ishlashingiz mumkin.';

  @override
  String get playerYoutubeOpen => 'YouTubeʼda ochish';

  @override
  String get playerYoutubeCopy => 'Havoladan nusxa olish';

  @override
  String get segmentEditText => 'Matnni tahrirlash';

  @override
  String get segmentAddComment => 'Izoh qoʻshish';

  @override
  String get segmentDelete => 'Segmentni oʻchirish';

  @override
  String get segmentDeleteConfirm =>
      'Segment matni bilan oʻchadi. Rostdan oʻchirilsinmi?';

  @override
  String get segmentDeleteYes => 'Ha, oʻchirish';

  @override
  String get speakerRename => 'Nomini oʻzgartirish';

  @override
  String get commentsEmpty =>
      'Izohlar yoʻq. Segmentni bosib turing va «Izoh qoʻshish»ni tanlang.';

  @override
  String get commentsReply => 'Javob yozish';

  @override
  String get commentsHint => 'Izoh yozing';

  @override
  String get commentsSend => 'Yuborish';

  @override
  String get commentsDelete => 'Oʻchirish';

  @override
  String get commentsDeleteConfirm => 'Izoh oʻchirilsinmi?';

  @override
  String get commentsTooLong => 'Izoh juda uzun.';

  @override
  String get commentsSegmentGone => 'Oʻchirilgan segment';

  @override
  String get commentsYou => 'Siz';

  @override
  String get ratingTitle => 'Transkript sifati';

  @override
  String get ratingHint =>
      'Bahoyingizni faqat siz koʻrasiz. U sifatni yaxshilashga yordam beradi.';

  @override
  String ratingStar(int count) {
    return '$count yulduz';
  }

  @override
  String get ratingSaved => 'Baho saqlandi.';

  @override
  String get retranscribeBody =>
      'Fayl qaytadan transkripsiya qilinadi va balansdan daqiqa yechiladi.';

  @override
  String retranscribeMinutes(int minutes) {
    return 'Taxminan $minutes daqiqa sarflanadi.';
  }

  @override
  String get retranscribeConfirm => 'Boshlash';

  @override
  String get retranscribeActive =>
      'Bu fayl allaqachon transkripsiya qilinmoqda.';

  @override
  String get retranscribeGone =>
      'Audio oʻchirilgan — qayta transkripsiya qilib boʻlmaydi.';

  @override
  String get exportStepStyle => 'Uslub';

  @override
  String get exportStepFormat => 'Format';

  @override
  String get exportNext => 'Keyingi';

  @override
  String get exportTimedOnly => 'Vaqt boʻyicha boʻlinadi — uslub qoʻllanmaydi.';

  @override
  String get exportTableHint => 'Jadval: vaqt, maʼruzachi va matn ustunlari.';
}
