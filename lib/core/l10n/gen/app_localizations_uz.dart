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
}
