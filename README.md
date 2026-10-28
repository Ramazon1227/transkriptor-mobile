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

## 5. iPhone'da sinab koʻrish

iOS ilovasini faqat Mac'da, **Xcode** orqali yigʻish mumkin.

### 5.1 Tayyorgarlik (bir marta)

1. App Store'dan **Xcode**ni oʻrnating, bir marta oching va qoʻshimcha
   komponentlarni oʻrnatishga rozilik bering.
2. Terminalda:

   ```bash
   sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   flutter doctor            # iOS qatorida xato qolmasligi kerak
   ```

3. Xcode → *Settings → Accounts* → Apple ID'ingizni qoʻshing. Bepul
   Apple ID yetarli.

### 5.2 Imzo sozlash

```bash
open ios/Runner.xcworkspace
```

Xcode'da *Runner* → *Signing & Capabilities*:

- **Team** — Apple ID'ingizni tanlang.
- **Bundle Identifier** — `uz.transkriptor.transkriptorUz` band boʻlsa,
  oʻzingizga xos qiling, masalan `uz.ismingiz.transkriptor`.

### 5.3 iPhone'ni ulash

1. iPhone'ni kabel bilan ulang, «Bu kompyuterga ishonasizmi?» → *Ishonish*.
2. iPhone'da *Sozlamalar → Maxfiylik va xavfsizlik → Developer Mode*ni
   yoqing (telefon qayta yuklanadi).
3. `flutter devices` — iPhone roʻyxatda chiqishi kerak.

### 5.4 Ishga tushirish

```bash
flutter run -d <iPhone id yoki nomi> \
  --dart-define=API_BASE_URL=http://192.168.1.4:8080
```

Birinchi marta iPhone ilovani ochishga ruxsat bermaydi. Uni yoqish uchun:
*Sozlamalar → Umumiy → VPN va qurilmalarni boshqarish* → Apple ID'ingiz →
*Ishonish*.

Mikrofon ruxsati birinchi yozishda soʻraladi (matni `Info.plist`da).

### 5.5 Cheklovlar

- **Bepul Apple ID** bilan oʻrnatilgan ilova **7 kundan keyin** ishlamay
  qoladi — qayta `flutter run` qilish kerak. TestFlight orqali boshqalarga
  berish uchun pullik Apple Developer Program kerak (yiliga 99 $).
- **HTTP va iOS.** iOS'ning App Transport Security himoyasi oddiy `http://`
  ulanishlarni bloklashi mumkin. Agar iPhone'da «Internetga ulanib
  boʻlmadi» chiqsa-yu, backend ishlayotgan boʻlsa, ikki yoʻl bor:
  `https://` manzilli backend'ga ulash, yoki `ios/Runner/Info.plist`ga
  faqat sinov uchun ATS istisnosini qoʻshish. Istisno hozir qoʻshilmagan.
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

**Push** — Firebase loyihasi ulanmaguncha oʻchiq: ilova Firebase'ga umuman
tegmaydi. Yoqish uchun Firebase konsolida Android ilova
(`uz.transkriptor.transkriptor_uz`) qoʻshing va toʻrtta qiymatni build'ga bering
(`google-services.json` kerak emas):

```bash
flutter run --dart-define=API_BASE_URL=... \
  --dart-define=FIREBASE_API_KEY=... --dart-define=FIREBASE_APP_ID=... \
  --dart-define=FIREBASE_SENDER_ID=... --dart-define=FIREBASE_PROJECT_ID=...
```

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
