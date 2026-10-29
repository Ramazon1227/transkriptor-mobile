# Transkriptor UZ — mobil ilova

Flutter ilova: kirish va roʻyxatdan oʻtish, mikrofondan yozib olish, fayl yoki
havola yuborish, transkripsiya jarayonini kuzatish, transkriptni oʻqish.
Backend — `../tr-backend` (Go API). Ilova u bilan `API_BASE_URL` orqali
gaplashadi.

Bu qoʻllanma buyruqlarni Mac'da, `tr-mobile` papkasidan (backend uchun
ildiz `transkriptor` papkasidan) bajarishni nazarda tutadi.

---

## 1. Bir martalik tayyorgarlik

| Kerak | Tekshirish | Izoh |
|---|---|---|
| Flutter | `flutter --version` | 3.47 bilan yozilgan |
| Android SDK + emulyator | `ls /opt/homebrew/share/android-commandlinetools` | AVD nomi: `tr_pixel` |
| Docker Desktop | `docker info` | backend shu yerda ishlaydi |
| Xcode (faqat iPhone uchun) | `xcodebuild -version` | App Store'dan oʻrnatiladi, hozir **yoʻq** |

Qulaylik uchun `adb` va `emulator` buyruqlarini PATH'ga qoʻshing
(`~/.zshrc` oxiriga yozib, terminalni qayta oching):

```bash
export ANDROID_HOME=/opt/homebrew/share/android-commandlinetools
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"
```

Paketlar va generatsiya qilinadigan kod (birinchi marta va `pubspec.yaml`
yoki modellar oʻzgarganda):

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
```

---

## 2. Ishga tushirish

Tartib muhim: **backend → emulyator → ilova**.

### 2.1 Backend

```bash
cd ..                                   # transkriptor ildiz papkasi
open -a Docker                          # Docker Desktop yopiq boʻlsa
docker compose up -d postgres migrate api
curl http://localhost:8080/api/ping     # 200 qaytishi kerak
```

> **Ehtiyot:** lokal backend **haqiqiy** STT servisiga ulangan. Ilovada
> «Transkripsiyani boshlash» bosilsa, DGX'da jonli GPU ish boshlanadi va
> daqiqa sarflanadi. Sinovda avval «Faqat saqlash»ni ishlating.

### 2.2 Android emulyator

```bash
emulator -avd tr_pixel -no-boot-anim &
adb wait-for-device
```

Emulyator oynasi koʻrinmasa: **Cmd+Tab** → `qemu-system-aarch64`.

Mac klaviaturasi bilan yozish uchun `~/.android/avd/tr_pixel.avd/config.ini`
ichida `hw.keyboard=yes` boʻlishi kerak (allaqachon yoqilgan). Oʻzgartirilsa,
emulyatorni qayta ishga tushiring.

### 2.3 Ilova

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

- `10.0.2.2` — emulyator ichidan Mac'ning `localhost`i.
- `API_BASE_URL` **majburiy**. Berilmasa, ilova ishga tushmaydi
  (`StateError: API_BASE_URL is not set`). Bu ataylab qilingan: parol
  notoʻgʻri serverga ketmasligi kerak.
- `PUBLIC_APP_URL` — ixtiyoriy. Sozlamalardagi «Maxfiylik» kabi havolalar
  shu veb-saytga ochiladi. Berilmasa, **vaqtinchalik server**
  (`https://app.108-181-196-187.sslip.io`) ishlatiladi; haqiqiy domen
  kelganda u `lib/core/constants/public_links.dart`da almashtiriladi
  (koʻchish rejasi — ildizdagi `KOCHISH.md`). Boshqa manzil uchun
  `--dart-define=PUBLIC_APP_URL=https://...`, havolalarni oʻchirish uchun
  `--dart-define=PUBLIC_APP_URL=` (qatorlar «Tez orada» deydi).

`flutter run` ishlab turganda terminalda quyidagi tugmalar ishlaydi:

| Tugma | Nima qiladi |
|---|---|
| `r` | hot reload — kod oʻzgarishi darhol koʻrinadi |
| `R` | hot restart — holat noldan boshlanadi |
| `q` | ilovani toʻxtatib, `flutter run`dan chiqadi |

Birinchi kirish: kirish oynasida **«Roʻyxatdan oʻtish»** → ism, email,
parol (kamida 10 belgi, harf va raqam/belgi). Hisob ochilgach darhol
kirasiz.

### 2.4 Haqiqiy Android telefonda

1. Telefonda: *Sozlamalar → Telefon haqida → Build raqami* ustiga 7 marta
   bosing, keyin *Dasturchi sozlamalari → USB debugging*ni yoqing.
2. Kabel bilan ulang, telefonda «Allow USB debugging»ni tasdiqlang.
   `adb devices` telefonni koʻrsatishi kerak.
3. Telefon va Mac **bitta Wi-Fi**da boʻlsin. Mac IP manzilini oling:
   `ipconfig getifaddr en0` (masalan `192.168.1.4`).
4. Ishga tushiring:

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.4:8080
```

---

## 3. Toʻxtatish

| Nimani | Buyruq |
|---|---|
| Ilova (`flutter run` ichida) | `q` |
| Ilova (terminalsiz) | `adb shell am force-stop uz.transkriptor.transkriptor_uz` |
| Emulyator | `adb emu kill` |
| Backend (maʼlumot saqlanadi) | `cd .. && docker compose stop` |
| Backend (konteynerlarni oʻchirish, maʼlumot saqlanadi) | `cd .. && docker compose down` |
| Backend + **butun lokal baza** | `cd .. && docker compose down -v` — qaytarib boʻlmaydi |

---

## 4. APK yaratish

### 4.1 Sinov uchun (debug)

```bash
flutter build apk --debug --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

Natija: `build/app/outputs/flutter-apk/app-debug.apk`. Oʻrnatish:

```bash
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

Haqiqiy telefon uchun manzilni Mac IP'siga almashtiring
(`http://192.168.1.4:8080`). APK faylni telefonga Telegram yoki kabel orqali
yuborib ham oʻrnatsa boʻladi (telefon «nomaʼlum manbalar»ga ruxsat soʻraydi).

### 4.2 Tarqatish uchun (release)

```bash
flutter build apk --release --split-per-abi \
  --dart-define=API_BASE_URL=https://<api domeni>
```

Natija: `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` va
boshqa arxitekturalar uchun alohida, kichikroq fayllar.

Ikki narsaga eʼtibor bering:

- **Faqat `https://`.** Release build `http://` manzilga ulanmaydi —
  Android uni bloklaydi. Ochiq HTTP faqat debug build'da yoqilgan.
- **Imzo.** Release faqat oʻz kalitingiz bilan imzolanadi. `android/key.properties`
  boʻlmasa, release build xato bilan toʻxtaydi (debug va profile kalitsiz
  yigʻilaveradi). Debug kaliti bilan imzolangan APK keyin haqiqiy kalitli
  versiya bilan yangilanmaydi — har kim ilovani oʻchirib qayta oʻrnatishi
  kerak boʻlardi, shuning uchun bunday yoʻl yopilgan.

#### Kalitni bir marta yaratish

```bash
keytool -genkeypair -v -keystore ~/keys/transkriptor-upload.jks \
  -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

`keytool` parol va ism soʻraydi. Keyin `android/key.properties`:

```properties
storePassword=<parol>
keyPassword=<parol>
keyAlias=upload
storeFile=/Users/<siz>/keys/transkriptor-upload.jks
```

`storeFile` — toʻliq yoʻl (yoki `android/app/` ga nisbatan yoʻl).

- `key.properties` va `*.jks` `.gitignore`da — **hech qachon commit
  qilmang** va repo ichida saqlamang.
- `.jks` fayl va parolning **zaxira nusxasi** boʻlsin (parol menejeri +
  boshqa disk). Yoʻqolsa, Play'dagi ilovani shu kalit bilan yangilab
  boʻlmaydi; Play App Signing yoqilgan boʻlsa, Google orqali kalitni
  almashtirish mumkin, lekin bu bir necha kunlik jarayon.
- Imzoni tekshirish:
  `apksigner verify --print-certs build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`

---

## 5. iPhone'da sinash

iOS ilovasini faqat Mac'da, **Xcode** orqali yigʻish mumkin. Ilova iPhone'da
hali **bir marta ham yigʻilmagan** — birinchi yigʻishda chiqqan xatolarni
yozib qoʻying.

### 5.1 Tayyorgarlik (bir marta)

1. App Store'dan **Xcode**ni oʻrnating, bir marta oching va qoʻshimcha
   komponentlarni (iOS platformasi) oʻrnatishga rozilik bering.
2. Terminalda:

   ```bash
   sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   brew install cocoapods    # yoki: sudo gem install cocoapods
   flutter doctor            # Xcode va CocoaPods qatorlarida xato qolmasin
   ```

   Repoda `ios/Podfile` **yoʻq** — bu xato emas. Flutter uni (yoki Swift
   Package Manager sozlamasini) birinchi `flutter build ios` /
   `flutter run` paytida oʻzi yaratadi. Yaratilgan `Podfile` va
   `Podfile.lock`ni commit qiling.
3. Xcode → *Settings → Accounts* → Apple ID'ingizni qoʻshing.

**Qaysi akkaunt?**

| | Bepul Apple ID (Personal Team) | Pullik Apple Developer Program (yiliga 99 $) |
|---|---|---|
| Oʻz telefoningizga oʻrnatish | ha | ha |
| Profil muddati | **7 kun**, keyin qayta `flutter run` | 1 yil |
| Bir vaqtda ilovalar | koʻpi bilan **3** ta | cheklanmagan |
| TestFlight / boshqalarga berish | yoʻq | ha |
| Push (APNs) | yoʻq | ha |

### 5.2 Imzo sozlash

```bash
open ios/Runner.xcworkspace
```

Xcode'da *Runner* → *Signing & Capabilities*:

- **Team** — Apple ID'ingizni (yoki kompaniya jamoasini) tanlang.
- **Bundle Identifier** — `uz.transkriptor.transkriptorUz`. Bepul jamoa uni
  rad etsa («failed to register bundle identifier» — boshqa kimdir band
  qilgan), oʻzingizga xos qiling, masalan `uz.ismingiz.transkriptor`.
  Push yoki Google uchun keyin aynan shu ID ishlatiladi.

Minimal iOS versiyasi — **15.0** (`firebase_messaging` va `video_player`
shuni talab qiladi; qolgan paketlarga 12–14 yetadi).

### 5.3 iPhone'ni ulash

1. iPhone'ni kabel bilan ulang, «Bu kompyuterga ishonasizmi?» → *Ishonish*.
2. iPhone'da *Sozlamalar → Maxfiylik va xavfsizlik → Developer Mode*ni
   yoqing (telefon qayta yuklanadi, keyin «Yoqish»ni tasdiqlang). Bu
   menyu telefon Xcode'ga bir marta ulangandan keyin chiqadi.
3. `flutter devices` — iPhone roʻyxatda chiqishi kerak.

### 5.4 Ishga tushirish

Production API bilan (tavsiya etiladi — `https`, pastdagi ATS bandiga
qarang):

```bash
flutter run --release -d <iPhone id yoki nomi> \
  --dart-define=API_BASE_URL=https://api.108-181-196-187.sslip.io
```

Birinchi marta iPhone ilovani ochishga ruxsat bermaydi («Untrusted
Developer»). Yoqish uchun: *Sozlamalar → Umumiy → VPN va qurilmalarni
boshqarish* → Apple ID'ingiz → *Ishonish*.

Mikrofon ruxsati birinchi yozishda soʻraladi (matni `Info.plist`da). Rad
etilsa, yozish sahifasida «Sozlamalarni ochish» tugmasi ilovaning
Sozlamalardagi sahifasini ochadi.

`--release` ilovani kompyutersiz ham ishlaydigan qiladi (debug build
iPhone'da faqat `flutter run` ulanib turganda ochiladi).

### 5.5 iPhone'da nima ishlamaydi

- **Ekran ovozini yozish** — iOS boshqa ilovalarning ovozini yozishga
  ruxsat bermaydi, mahalliy kod esa faqat Android uchun yozilgan. «+»
  menyusida bu band iPhone'da koʻrsatilmaydi.
- **Google bilan kirish** — iOS uchun alohida OAuth client kerak. Usiz
  tugma iPhone'da koʻrinmaydi (5.6 ga qarang).
- **Push** — Firebase ulanmaguncha oʻchiq (5.6).
- **Toʻxtab qolgan yozuvni tiklash zaifroq.** Android yozuvni har kadrda
  diskka yozadi va ilova oʻldirilsa ham tiklaydi. iPhone'da `.m4a` faylni
  yozib oluvchi oʻzi yozadi va indeksini faqat «Toʻxtatish»da qoʻyadi:
  ilova yopib yuborilsa (swipe), oʻsha yozuv **yoʻqoladi**. Tugallangan,
  lekin yuborilmagan yozuvlar esa saqlanib, keyin taklif qilinadi.
  Ekran qulflansa yoki boshqa ilovaga oʻtilsa yozish davom etadi
  (`UIBackgroundModes: audio`), ekranda qizil mikrofon belgisi turadi.
- **HTTP va iOS (ATS).** iOS oddiy `http://` ulanishlarni bloklaydi —
  `http://192.168…:8080` dagi lokal backend iPhone'da «Internetga ulanib
  boʻlmadi» beradi, video/audio ham ochilmaydi. iPhone'da production
  (`https://`) API bilan sinang. ATS istisnosi ataylab qoʻshilmagan.
- iPhone ekranini Mac'da **iPhone Mirroring** orqali koʻrib, ilovani
  sichqoncha bilan boshqarish mumkin — u faqat ekranni koʻrsatadi, ilovani
  oʻrnatmaydi.

---

## 5.6 Google bilan kirish va push bildirishnoma

**Google bilan kirish** — ilova tugmani faqat backend'da `GOOGLE_CLIENT_ID`
yoqilgan boʻlsa koʻrsatadi (web client ID'ni backend'dan oladi). Telefonda
ishlashi uchun Google Cloud'da **oʻsha loyihada** Android turidagi OAuth
client yaratilishi kerak: paket nomi `uz.transkriptor.transkriptor_uz` va
imzo kalitining SHA-1'i (debug uchun `~/.android/debug.keystore`, release
uchun §4.2 dagi kalit — ikkalasi alohida client). Backend `b033e22` dan
eskisi mobil `id_token`'ni qabul qilmaydi.

**iPhone'da Google bilan kirish** — ilova tugmani iPhone'da faqat
`GOOGLE_IOS_CLIENT_ID` berilganda koʻrsatadi, chunki URL sxemasi
boʻlmasa Google SDK ilovani **yiqitadi**. Yoqish uchun:

1. Google Cloud'da (backend'ning web client'i turgan **oʻsha loyihada**)
   *iOS* turidagi OAuth client yarating, Bundle ID — 5.2 dagi ID.
   Natija: `1234-abcd.apps.googleusercontent.com` koʻrinishidagi client ID.
2. `ios/Runner/Info.plist`ga uning **teskari** koʻrinishini URL sxemasi
   sifatida qoʻshing (qiymatni oʻzingiznikiga almashtiring):

   ```xml
   <key>CFBundleURLTypes</key>
   <array>
     <dict>
       <key>CFBundleURLSchemes</key>
       <array>
         <string>com.googleusercontent.apps.1234-abcd</string>
       </array>
     </dict>
   </array>
   ```

3. Build'ga client ID'ni bering:
   `--dart-define=GOOGLE_IOS_CLIENT_ID=1234-abcd.apps.googleusercontent.com`.

`GIDClientID`ni `Info.plist`ga yozish shart emas — ilova client ID'ni
SDK'ga oʻzi beradi. Backend'ga hech narsa qoʻshilmaydi: token `aud`i
baribir web client ID boʻladi.

**Push** — Firebase loyihasi ulanmaguncha oʻchiq: ilova Firebase'ga umuman
tegmaydi. Yoqish uchun Firebase konsolida Android ilova
(`uz.transkriptor.transkriptor_uz`) qoʻshing va toʻrtta qiymatni build'ga bering
(`google-services.json` kerak emas):

```bash
flutter run --dart-define=API_BASE_URL=... \
  --dart-define=FIREBASE_API_KEY=... --dart-define=FIREBASE_APP_ID=... \
  --dart-define=FIREBASE_SENDER_ID=... --dart-define=FIREBASE_PROJECT_ID=...
```

iPhone'da push uchun bundan tashqari pullik Apple Developer akkaunti,
APNs kaliti (Firebase konsoliga yuklanadi), Xcode'da *Push Notifications*
va *Background Modes → Remote notifications* capability'lari kerak, va
`FIREBASE_APP_ID` iOS ilovaniki boʻlishi kerak. Bularsiz ham, toʻrtta qiymat
berilmasa ilova iPhone'da ham Firebase'ga tegmaydi.

Backend tomonda shu loyihaning service account JSON fayli
`FCM_CREDENTIALS_FILE` orqali beriladi. Bildirishnoma transkript tayyor
boʻlganda yoki xato bilan tugaganda ishni boshlagan odamga keladi; bosilsa
transkript (yoki job) sahifasi ochiladi.

---

## 6. Tekshiruvlar

```bash
flutter analyze        # 0 xato, 0 ogohlantirish boʻlishi kerak
flutter test           # barcha testlar
flutter test --coverage
```

Kod qoidalari, papka tuzilishi va arxitektura — `CLAUDE.md`da.

---

## 7. Tez-tez uchraydigan muammolar

| Belgi | Sabab va yechim |
|---|---|
| «Internetga ulanib boʻlmadi» | Backend ishlamayapti. Docker'ni oching, `docker compose up -d postgres migrate api`, `curl localhost:8080/api/ping`. Telefonda boʻlsa — Mac bilan bitta Wi-Fi va IP toʻgʻriligini tekshiring. |
| Ilova ochilishi bilan yopiladi | `--dart-define=API_BASE_URL=...` berilmagan. |
| Emulyatorda Mac klaviaturasi yozmaydi | `config.ini`da `hw.keyboard=yes`, keyin emulyatorni qayta ishga tushiring. |
| Emulyator oynasi yoʻq | Cmd+Tab → `qemu-system-aarch64`, yoki Mission Control (F3). |
| «Email yoki parol notoʻgʻri» | Lokal baza — production emas. Ilovada qayta roʻyxatdan oʻting. |
| «Juda koʻp urinish» | Kirish va roʻyxatdan oʻtishga daqiqasiga cheklov bor. Bir daqiqa kuting. |
| Kod oʻzgardi, lekin xato `*.g.dart` / `*.freezed.dart`da | `dart run build_runner build --delete-conflicting-outputs` |
| Yangi matn qoʻshildi, `l10n` topilmayapti | `flutter gen-l10n` |
