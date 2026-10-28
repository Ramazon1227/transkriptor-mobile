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
  String get navHome => 'Asosiy';

  @override
  String get navFiles => 'Fayllar';

  @override
  String get navRecord => 'Yozib olish';

  @override
  String get navProfile => 'Profil';

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
  String homeGreeting(String name) {
    return 'Salom, $name';
  }

  @override
  String get homeGreetingNoName => 'Salom';

  @override
  String get homeSubtitle => 'Bugun nimani matnga aylantiramiz?';

  @override
  String get homeRecordTitle => 'Yozib olish';

  @override
  String get homeRecordSubtitle =>
      'Suhbat, majlis, maʼruza — telefon mikrofonidan';

  @override
  String get homeUploadTitle => 'Fayl yuklash';

  @override
  String get homeUploadSubtitle => 'mp3, m4a, wav, mp4, webm';

  @override
  String get homeLinkTitle => 'Havola';

  @override
  String get homeLinkSubtitle => 'YouTube, Drive, Dropbox';

  @override
  String get homeRecent => 'Oxirgi fayllar';

  @override
  String get homeSeeAll => 'Hammasi';

  @override
  String get balanceLabel => 'Balans';

  @override
  String minutesShort(int minutes) {
    return '$minutes daq';
  }

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
  String get profileMinutesLeft => 'daqiqa qoldi';

  @override
  String get profileWorkspace => 'Ish maydoni';

  @override
  String get profileLogout => 'Chiqish';

  @override
  String get profileLogoutTitle => 'Hisobdan chiqasizmi?';
}
