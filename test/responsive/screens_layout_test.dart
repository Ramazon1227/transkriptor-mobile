// Responsive audit: pumps every page with stress data at phone, tablet and
// landscape sizes and at large text scales, and collects every FlutterError
// (RenderFlex overflow, unbounded constraints, ...) instead of failing on
// the first one. It also records how wide the main content gets, so a form
// stretched edge to edge across a tablet shows up in the report.
//
// Any layout error fails its case (since 2026-10-28, when all were fixed).
// RESPONSIVE_REPORT_ONLY=1 turns that off to just collect the summary,
// which goes to build/responsive_report.txt.
//
// The mock holders are top-level `late` variables of private types, shared
// by setUp and the scenarios; nothing outside this file sees them.
// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/application/forgot_password_bloc.dart';
import 'package:transkriptor_uz/features/auth/application/login_bloc.dart';
import 'package:transkriptor_uz/features/auth/application/register_bloc.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/password_rules.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/login_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/profile_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/register_page.dart';
import 'package:transkriptor_uz/features/home/presentation/pages/home_page.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/app_shell.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/entry_cards.dart';
import 'package:transkriptor_uz/features/job/application/job_cubit.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/presentation/pages/job_page.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/presentation/pages/files_page.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_tile.dart';
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart';
import 'package:transkriptor_uz/features/recorder/presentation/pages/recorder_page.dart';
import 'package:transkriptor_uz/features/recorder/presentation/widgets/level_meter.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/presentation/pages/transcript_page.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/segment_tile.dart';
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/link_page.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/send_page.dart';

// ---------------------------------------------------------------- mocks

class _Account extends MockCubit<AccountState> implements AccountCubit;

class _Library extends MockBloc<LibraryEvent, LibraryState>
    implements LibraryBloc;

class _Folders extends MockCubit<FoldersState> implements FoldersCubit;

class _Pick extends MockCubit<PickFileState> implements PickFileCubit;

class _Login extends MockBloc<LoginEvent, LoginState> implements LoginBloc;

class _Register extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterBloc;

class _Forgot extends MockBloc<ForgotPasswordEvent, ForgotPasswordState>
    implements ForgotPasswordBloc;

class _Upload extends MockBloc<UploadEvent, UploadState> implements UploadBloc;

class _Job extends MockCubit<JobState> implements JobCubit;

class _Recorder extends MockCubit<RecorderState> implements RecorderCubit;

class _Transcript extends MockCubit<TranscriptState> implements TranscriptCubit;

// ---------------------------------------------------------- stress data

const _longName =
    'Oʻzbekiston Respublikasi Oliy Majlisi Qonunchilik palatasining '
    'navbatdagi yalpi majlisi — 2026-yil 27-oktyabr, toʻliq yozuv';
const _cyrName =
    'Заседание Ташкентского областного хокимията по вопросам '
    'цифровизации государственных услуг — полная запись';

const _user = AppUser(
  id: 'u1',
  email: 'abdulazizxoja.muhammadqodirov@toshkent-viloyat-hokimligi.gov.uz',
  fullName: 'Abdulazizxoʻja Muhammadqodirov-Toshkentiy Baxtiyorovich',
);

const _workspaces = [
  Workspace(
    id: 'w1',
    name:
        'Toshkent viloyati hokimligi Axborot xizmati — matbuot kotibiyati '
        'va jamoatchilik bilan ishlash boshqarmasi',
    isPersonal: true,
    balanceSeconds: 5999 * 60 + 59,
  ),
  Workspace(
    id: 'w2',
    name:
        'Ташкентский областной хокимият — '
        'пресс-служба и связи с общественностью',
    balanceSeconds: 123456,
  ),
  Workspace(id: 'w3', name: 'Call-markaz «1092» — tungi smena'),
];

const _account = AccountState(
  status: AccountStatus.success,
  account: Account(user: _user, workspaces: _workspaces),
);

final List<LibraryItem> _items = [
  for (var i = 0; i < 30; i++)
    LibraryItem(
      mediaId: 'm$i',
      name: i.isEven ? '$_longName ($i).mp4' : '$_cyrName ($i).webm',
      createdAt: DateTime(2026, 10, 27, 14, 35),
      duration: Duration(hours: 2, minutes: 59, seconds: i),
      kind: i.isEven ? MediaKind.video : MediaKind.audio,
      source: MediaSource.values[i % MediaSource.values.length],
      linkProvider: i % 3 == 0 ? 'YOUTUBE' : null,
      jobId: 'j$i',
      jobStatus: JobStatus.values[i % JobStatus.values.length],
      transcriptId: 't$i',
      tags: const [
        'sud ishlari',
        'yalpi majlis',
        'пресс-конференция',
        'muhim',
        'qayta tekshirish kerak',
      ],
    ),
];

final List<Folder> _folders = [
  for (var i = 0; i < 12; i++)
    Folder(
      id: 'f$i',
      name: i.isEven
          ? 'Qonunchilik palatasi yalpi majlislari $i'
          : 'Пресс-конференции хокимията $i',
      fileCount: 1000 + i,
    ),
];

final List<Speaker> _speakers = [
  for (var i = 0; i < 6; i++)
    Speaker(
      id: 's$i',
      ordinal: i,
      label: i.isEven
          ? 'Maʼruzachi ${i + 1} — Toshkent shahar hokimining birinchi '
                'oʻrinbosari Abdulazizxoʻja Muhammadqodirov'
          : 'Докладчик ${i + 1} — заместитель председателя комитета',
    ),
];

final _transcript = Transcript(
  id: 't1',
  title: '$_longName — $_cyrName',
  duration: const Duration(hours: 2, minutes: 59, seconds: 59),
  speakers: _speakers,
  revision: 3,
  segments: [
    for (var i = 0; i < 200; i++)
      Segment(
        id: 'seg$i',
        start: Duration(seconds: i * 53),
        end: Duration(seconds: i * 53 + 50),
        speakerId: 's${i % 6}',
        edited: i % 4 == 0,
        text: i.isEven
            ? 'Assalomu alaykum, hurmatli deputatlar! Bugungi majlisda '
                  'oʻn ikkita qonun loyihasi koʻrib chiqiladi, jumladan '
                  '«Davlat xizmatlarini raqamlashtirish toʻgʻrisida»gi '
                  'qonun loyihasi. Supercalifragilisticexpialidociousword.'
            : 'Спасибо, уважаемый председатель. Мы подготовили '
                  'предложения по цифровизации; кроме того — sorry, '
                  'one more thing in English — бюджет на 2027 год.',
      ),
  ],
);

const _pendingFile = PendingFile(
  path: '/tmp/x.m4a',
  fileName: '$_longName — $_cyrName.m4a',
  sizeBytes: 1987654321,
  source: UploadSource.recording,
  duration: Duration(hours: 2, minutes: 35),
);

const _pickedFile = PendingFile(
  path: '/tmp/y.mp4',
  fileName: '$_longName.mp4',
  sizeBytes: 734003200,
  source: UploadSource.upload,
);

const _longError =
    'Faylni yuklab boʻlmadi: havola yopiq yoki fayl oʻchirilgan. '
    'Iltimos, havolani tekshirib, qaytadan urinib koʻring. '
    'Файл не удалось загрузить: ссылка закрыта или файл удалён.';

// ------------------------------------------------------------ registry

late _Account account;
late _Library library;
late _Folders folders;
late _Pick pick;
late _Login login;
late _Register register;
late _Forgot forgot;
late _Upload upload;
late _Job job;
late _Recorder recorder;
late _Transcript transcript;

void _makeMocks() {
  account = _Account();
  library = _Library();
  folders = _Folders();
  pick = _Pick();
  login = _Login();
  register = _Register();
  forgot = _Forgot();
  upload = _Upload();
  job = _Job();
  recorder = _Recorder();
  transcript = _Transcript();

  when(() => account.state).thenReturn(_account);
  when(() => account.load()).thenAnswer((_) async {});
  when(() => library.state).thenReturn(
    LibraryState(
      status: LibraryStatus.success,
      items: _items,
      workspaceId: 'w1',
    ),
  );
  when(
    () => folders.state,
  ).thenReturn(FoldersState(status: FoldersStatus.success, folders: _folders));
  when(() => folders.load(any())).thenAnswer((_) async {});
  when(() => folders.refresh()).thenAnswer((_) async {});
  when(() => pick.state).thenReturn(const PickFileState());
  when(() => login.state).thenReturn(const LoginState());
  when(() => register.state).thenReturn(const RegisterState());
  when(() => forgot.state).thenReturn(const ForgotPasswordState());
  when(() => upload.state).thenReturn(const UploadState());
  when(() => job.state).thenReturn(const JobState());
  when(() => recorder.state).thenReturn(const RecorderState());
  when(() => recorder.start()).thenAnswer((_) async {});
  when(() => transcript.state).thenReturn(const TranscriptState());
  when(() => transcript.load(any())).thenAnswer((_) async {});

  getIt
    ..registerFactory<LibraryBloc>(() => library)
    ..registerFactory<FoldersCubit>(() => folders)
    ..registerFactory<PickFileCubit>(() => pick)
    ..registerFactory<LoginBloc>(() => login)
    ..registerFactory<RegisterBloc>(() => register)
    ..registerFactory<ForgotPasswordBloc>(() => forgot)
    ..registerFactory<UploadBloc>(() => upload)
    ..registerFactory<JobCubit>(() => job)
    ..registerFactory<RecorderCubit>(() => recorder)
    ..registerFactory<TranscriptCubit>(() => transcript);
}

// ----------------------------------------------------------- scenarios

/// Which page sits in the bottom-nav shell, as in the real router.
enum _Shell { none, home, files, profile }

class _Scenario {
  const _Scenario(
    this.name,
    this.page, {
    this.arrange,
    this.shell = _Shell.none,
    this.measure = const {},
  });

  final String name;
  final Widget Function() page;
  final void Function()? arrange;
  final _Shell shell;

  /// Label → widget whose width is recorded (first match).
  final Map<String, Finder Function()> measure;
}

Finder _field() => find.byType(TextField);
Finder _filled() => find.byType(FilledButton);

final _scenarios = <_Scenario>[
  _Scenario(
    'home',
    HomePage.new,
    shell: _Shell.home,
    measure: {
      'EntryCards': () => find.byType(EntryCards),
      'LibraryTile': () => find.byType(LibraryTile),
    },
  ),
  _Scenario(
    'files',
    FilesPage.new,
    shell: _Shell.files,
    measure: {'LibraryTile': () => find.byType(LibraryTile)},
  ),
  _Scenario(
    'profile',
    ProfilePage.new,
    shell: _Shell.profile,
    measure: {'ListTile(workspace)': () => find.byType(ListTile)},
  ),
  _Scenario(
    'login(google+error)',
    LoginPage.new,
    arrange: () => when(() => login.state).thenReturn(
      const LoginState(
        status: LoginStatus.failure,
        googleClientId: 'x',
        emailMissing: true,
        passwordMissing: true,
        failure: Failure.network(),
      ),
    ),
    measure: {'TextField': _field, 'FilledButton': _filled},
  ),
  _Scenario(
    'register(errors)',
    RegisterPage.new,
    arrange: () => when(() => register.state).thenReturn(
      const RegisterState(
        status: RegisterStatus.failure,
        emailInvalid: true,
        passwordProblem: PasswordProblem.needsLetterAndOther,
        failure: Failure.server(statusCode: 409),
      ),
    ),
    measure: {'TextField': _field, 'FilledButton': _filled},
  ),
  _Scenario(
    'forgot(initial)',
    () => ForgotPasswordPage(initialEmail: _user.email),
    measure: {'TextField': _field, 'FilledButton': _filled},
  ),
  _Scenario(
    'forgot(sent)',
    () => ForgotPasswordPage(initialEmail: _user.email),
    arrange: () => when(() => forgot.state).thenReturn(
      ForgotPasswordState(
        status: ForgotPasswordStatus.success,
        sentTo: _user.email,
      ),
    ),
    measure: {'FilledButton': _filled},
  ),
  _Scenario(
    'link(invalid)',
    LinkPage.new,
    arrange: () => when(() => upload.state).thenReturn(
      const UploadState(
        status: UploadStatus.failure,
        linkInvalid: true,
        failure: Failure.server(statusCode: 402),
      ),
    ),
    measure: {'TextField': _field, 'FilledButton': _filled},
  ),
  _Scenario(
    'send(recorded,initial)',
    () => const SendPage(file: _pendingFile),
    measure: {'TextField': _field, 'FilledButton': _filled},
  ),
  _Scenario(
    'send(picked,uploading)',
    () => const SendPage(file: _pickedFile),
    arrange: () => when(() => upload.state).thenReturn(
      const UploadState(status: UploadStatus.uploading, progress: .42),
    ),
    measure: {'TextField': _field},
  ),
  _Scenario(
    'send(stored+failure)',
    () => const SendPage(file: _pendingFile),
    arrange: () => when(() => upload.state).thenReturn(
      const UploadState(
        status: UploadStatus.stored,
        mediaId: 'm1',
        failure: Failure.server(statusCode: 503),
      ),
    ),
    measure: {'FilledButton': _filled},
  ),
  for (final s in [
    (JobStatus.queued, 0, null),
    (JobStatus.running, 47, null),
    (JobStatus.succeeded, 100, null),
    (JobStatus.failed, 63, _longError),
    (JobStatus.cancelled, 12, null),
  ])
    _Scenario(
      'job(${s.$1.name})',
      () => const JobPage(jobId: 'j1'),
      arrange: () => when(() => job.state).thenReturn(
        JobState(
          status: JobViewStatus.success,
          jobId: 'j1',
          job: Job(
            id: 'j1',
            status: s.$1,
            mediaId: 'm1',
            progress: s.$2,
            errorMessage: s.$3,
            transcriptId: s.$1 == JobStatus.succeeded ? 't1' : null,
          ),
        ),
      ),
      measure: {
        'FilledButton': _filled,
        'OutlinedButton': () => find.byType(OutlinedButton),
      },
    ),
  _Scenario(
    'job(running+pollFailure)',
    () => const JobPage(jobId: 'j1'),
    arrange: () => when(() => job.state).thenReturn(
      const JobState(
        status: JobViewStatus.failure,
        jobId: 'j1',
        failure: Failure.network(),
        job: Job(id: 'j1', status: JobStatus.running, progress: 88),
      ),
    ),
  ),
  _Scenario(
    'recorder(idle)',
    RecorderPage.new,
    measure: {'LevelMeter': () => find.byType(LevelMeter)},
  ),
  _Scenario(
    'recorder(recording)',
    RecorderPage.new,
    arrange: () => when(() => recorder.state).thenReturn(
      RecorderState(
        status: RecorderStatus.recording,
        elapsed: const Duration(hours: 1, minutes: 23, seconds: 45),
        levels: [for (var i = 0; i < 48; i++) (i % 7) / 7],
      ),
    ),
  ),
  _Scenario(
    'recorder(paused)',
    RecorderPage.new,
    arrange: () => when(() => recorder.state).thenReturn(
      const RecorderState(
        status: RecorderStatus.paused,
        elapsed: Duration(hours: 10, seconds: 1),
      ),
    ),
  ),
  _Scenario(
    'recorder(failure)',
    RecorderPage.new,
    arrange: () => when(() => recorder.state).thenReturn(
      const RecorderState(
        status: RecorderStatus.failure,
        failure: Failure.permissionDenied(),
      ),
    ),
  ),
  _Scenario(
    'transcript(200 segs)',
    () => const TranscriptPage(transcriptId: 't1'),
    arrange: () => when(() => transcript.state).thenReturn(
      TranscriptState(
        status: TranscriptStatus.success,
        transcript: _transcript,
      ),
    ),
    measure: {'SegmentTile': () => find.byType(SegmentTile)},
  ),
];

// ---------------------------------------------------------- conditions

class _Condition {
  const _Condition(this.name, this.w, this.h, [this.scale = 1.0]);
  final String name;
  final double w;
  final double h;
  final double scale;
}

const _conditions = [
  _Condition('320x568', 320, 568),
  _Condition('360x640', 360, 640),
  _Condition('393x852', 393, 852),
  _Condition('430x932', 430, 932),
  _Condition('600x960', 600, 960),
  _Condition('800x1280', 800, 1280),
  _Condition('1280x800', 1280, 800),
  _Condition('640x360', 640, 360),
  _Condition('852x393', 852, 393),
  _Condition('360x640@1.3', 360, 640, 1.3),
  _Condition('360x640@2.0', 360, 640, 2),
];

// ------------------------------------------------------------- results

final _errors = <String, List<String>>{}; // "page | condition" → errors
final _widths = <String, Map<String, double>>{}; // page → "cond label" → w

final _ownSource = RegExp(
  r'(?:package:transkriptor_uz/|file:///app/lib/|/lib/)(features/[\w/]+\.dart|core/[\w/]+\.dart):(\d+)',
);

final _raw = StringBuffer();

String _describe(FlutterErrorDetails d) {
  _raw
    ..writeln('-' * 60)
    ..writeln(d.toString());
  final first = d.exceptionAsString().split('\n').first.trim();
  final text = d.toString();
  final where = <String>{
    for (final m in _ownSource.allMatches(text)) '${m.group(1)}:${m.group(2)}',
  };
  return where.isEmpty ? first : '$first  @ ${where.take(3).join(', ')}';
}

Widget _app(_Scenario s, double scale) {
  Widget scaled(BuildContext context, Widget? child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  );

  final Widget app;
  if (s.shell == _Shell.none) {
    app = MaterialApp(
      theme: AppTheme.dark(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: scaled,
      home: s.page(),
    );
  } else {
    final router = GoRouter(
      initialLocation: switch (s.shell) {
        _Shell.files => '/files',
        _Shell.profile => '/profile',
        _ => '/',
      },
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, shell) => AppShell(shell: shell),
          branches: [
            StatefulShellBranch(
              routes: [GoRoute(path: '/', builder: (_, _) => const HomePage())],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(path: '/files', builder: (_, _) => const FilesPage()),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (_, _) => const ProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    app = MaterialApp.router(
      theme: AppTheme.dark(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: scaled,
      routerConfig: router,
    );
  }
  return BlocProvider<AccountCubit>.value(value: account, child: app);
}

Future<void> _loadRealFont() async {
  // The test font draws every glyph 1 em wide, which overflows far sooner
  // than any real face. The app has no fontFamily, so Android draws it
  // in Roboto; Noto Sans (bundled for the PDF export) has close metrics.
  final loader = FontLoader('Roboto');
  for (final f in ['NotoSans-Regular.ttf', 'NotoSans-Bold.ttf']) {
    final bytes = File('assets/fonts/$f').readAsBytesSync();
    loader.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

void main() {
  setUpAll(() async {
    registerFallbackValue('');
    await _loadRealFont();
  });

  setUp(_makeMocks);
  tearDown(() async => await getIt.reset());

  for (final s in _scenarios) {
    for (final c in _conditions) {
      testWidgets('${s.name} @ ${c.name}', (tester) async {
        s.arrange?.call();
        tester.view
          ..physicalSize = Size(c.w, c.h)
          ..devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        // Described at once: the creator chain needs the live element tree.
        final caught = <String>[];
        final previous = FlutterError.onError;
        FlutterError.onError = (d) => caught.add(_describe(d));
        try {
          await tester.pumpWidget(_app(s, c.scale));
          // Spinners never settle; a few frames are enough for layout.
          for (var i = 0; i < 4; i++) {
            await tester.pump(const Duration(milliseconds: 100));
          }
          for (final entry in s.measure.entries) {
            final f = entry.value();
            if (f.evaluate().isNotEmpty) {
              final w = tester.getSize(f.first).width;
              (_widths[s.name] ??= {})['${c.name} ${entry.key}'] = w;
            }
          }
          await tester.pumpWidget(const SizedBox());
        } finally {
          FlutterError.onError = previous;
        }
        final pending = tester.takeException();
        final lines = <String>{
          ...caught,
          if (pending != null) 'EXCEPTION ${'$pending'.split('\n').first}',
        }.toList();
        if (lines.isNotEmpty) _errors['${s.name} | ${c.name}'] = lines;
        if (Platform.environment['RESPONSIVE_REPORT_ONLY'] != '1') {
          expect(lines, isEmpty);
        }
      });
    }
  }

  tearDownAll(() {
    final out = StringBuffer()
      ..writeln('\n================ RESPONSIVE REPORT ================')
      ..writeln('Layout errors (${_errors.length} page×condition cells):');
    for (final e in _errors.entries) {
      out.writeln('  ${e.key}');
      for (final l in e.value) {
        out.writeln('      - $l');
      }
    }
    final clean = [
      for (final s in _scenarios)
        if (!_errors.keys.any((k) => k.startsWith('${s.name} |'))) s.name,
    ];
    out
      ..writeln('Clean everywhere: ${clean.join(', ')}')
      ..writeln('Widths of main content (logical px):');
    for (final p in _widths.entries) {
      out.writeln('  ${p.key}');
      for (final w in p.value.entries) {
        out.writeln('      ${w.key}: ${w.value.toStringAsFixed(0)}');
      }
    }
    // The report is the point of this file; print it with the run.
    // ignore: avoid_print
    print(out);
    File('build/responsive_report.txt')
      ..createSync(recursive: true)
      ..writeAsStringSync(out.toString());
    File('build/responsive_raw.txt').writeAsStringSync(_raw.toString());
  });
}
