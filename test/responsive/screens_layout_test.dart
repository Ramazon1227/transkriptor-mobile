// Responsive audit: pumps every page with stress data at phone, tablet and
// landscape sizes and at large text scales, and collects every FlutterError
// (RenderFlex overflow, unbounded constraints, ...) instead of failing on
// the first one. It also records how wide the main content gets, so a form
// stretched edge to edge across a tablet shows up in the report.
//
// Any layout error fails its case (since 2026-10-28, when all were fixed).
// RESPONSIVE_REPORT_ONLY=1 turns that off to just collect the summary,
// which goes to build/responsive_report.txt.
// RESPONSIVE_SHOTS=<dir> also writes a PNG of every page at 393x852 into
// <dir>, for looking at the design without a device.
//
// The mock holders are top-level `late` variables of private types, shared
// by setUp and the scenarios; nothing outside this file sees them.
// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'dart:ui' as ui;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/illustrated_card.dart';
import 'package:transkriptor_uz/features/ai_chat/application/ai_chat_cubit.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/ai_chat_tab.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/application/delete_account_cubit.dart';
import 'package:transkriptor_uz/features/auth/application/forgot_password_bloc.dart';
import 'package:transkriptor_uz/features/auth/application/login_bloc.dart';
import 'package:transkriptor_uz/features/auth/application/profile_name_cubit.dart';
import 'package:transkriptor_uz/features/auth/application/register_bloc.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/name_rules.dart';
import 'package:transkriptor_uz/features/auth/domain/password_rules.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/login_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/profile_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/register_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/profile_name_sheet.dart';
import 'package:transkriptor_uz/features/billing/application/balance_cubit.dart';
import 'package:transkriptor_uz/features/billing/application/plans_cubit.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/presentation/pages/plans_page.dart';
import 'package:transkriptor_uz/features/calendar/application/calendar_cubit.dart';
import 'package:transkriptor_uz/features/calendar/domain/entities/calendar_event.dart';
import 'package:transkriptor_uz/features/capture/application/dictation_cubit.dart';
import 'package:transkriptor_uz/features/capture/application/screen_capture_cubit.dart';
import 'package:transkriptor_uz/features/capture/application/url_import_cubit.dart';
import 'package:transkriptor_uz/features/capture/presentation/pages/dictation_page.dart';
import 'package:transkriptor_uz/features/capture/presentation/pages/screen_record_page.dart';
import 'package:transkriptor_uz/features/capture/presentation/pages/url_page.dart';
import 'package:transkriptor_uz/features/home/presentation/pages/home_page.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/app_shell.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/source_sheet.dart';
import 'package:transkriptor_uz/features/job/application/job_cubit.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/presentation/pages/job_page.dart';
import 'package:transkriptor_uz/features/learn/application/flashcards_cubit.dart';
import 'package:transkriptor_uz/features/learn/application/learn_cubit.dart';
import 'package:transkriptor_uz/features/learn/application/quiz_cubit.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/presentation/pages/flashcards_page.dart';
import 'package:transkriptor_uz/features/learn/presentation/pages/quiz_page.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_create_sheet.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_tab.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/presentation/pages/files_page.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/file_actions_sheet.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_tile.dart';
import 'package:transkriptor_uz/features/links/application/links_cubit.dart';
import 'package:transkriptor_uz/features/meeting_bot/application/meeting_bot_cubit.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';
import 'package:transkriptor_uz/features/meeting_bot/presentation/pages/meeting_page.dart';
import 'package:transkriptor_uz/features/meeting_bot/presentation/widgets/meeting_summary_options.dart';
import 'package:transkriptor_uz/features/notes/application/note_cubit.dart';
import 'package:transkriptor_uz/features/notes/application/notes_cubit.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';
import 'package:transkriptor_uz/features/notes/presentation/pages/note_page.dart';
import 'package:transkriptor_uz/features/notes/presentation/widgets/notes_list.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';
import 'package:transkriptor_uz/features/push/application/push_cubit.dart';
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart';
import 'package:transkriptor_uz/features/recorder/application/recovery_cubit.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/presentation/pages/recorder_page.dart';
import 'package:transkriptor_uz/features/recorder/presentation/widgets/level_meter.dart';
import 'package:transkriptor_uz/features/recorder/presentation/widgets/recovery_widgets.dart';
import 'package:transkriptor_uz/features/settings/presentation/pages/settings_page.dart';
import 'package:transkriptor_uz/features/settings/presentation/widgets/delete_account_sheet.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/summary_tab.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/template_picker_sheet.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/presentation/pages/transcript_page.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/editor_actions_sheet.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/segment_tile.dart';
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/link_page.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/send_page.dart';
import 'package:transkriptor_uz/features/workspace/application/workspace_list_cubit.dart';
import 'package:transkriptor_uz/features/workspace/presentation/widgets/workspace_switcher_sheet.dart';

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

class _Player extends MockCubit<PlayerState> implements PlayerCubit;

class _Calendar extends MockCubit<CalendarState> implements CalendarCubit;

class _Balance extends MockCubit<BalanceState> implements BalanceCubit;

class _Plans extends MockCubit<PlansState> implements PlansCubit;

class _Push extends MockCubit<PushState> implements PushCubit;

class _Links extends MockCubit<LinksState> implements LinksCubit;

class _WorkspaceList extends MockCubit<WorkspaceListState>
    implements WorkspaceListCubit;

class _Delete extends MockCubit<DeleteAccountState>
    implements DeleteAccountCubit;

class _Notes extends MockCubit<NotesState> implements NotesCubit;

class _Note extends MockCubit<NoteState> implements NoteCubit;
class _Recovery extends MockCubit<RecoveryState> implements RecoveryCubit;

class _Screen extends MockCubit<ScreenCaptureState>
    implements ScreenCaptureCubit;

class _Meeting extends MockCubit<MeetingBotState> implements MeetingBotCubit;

class _UrlImport extends MockCubit<UrlImportState> implements UrlImportCubit;

class _Dictation extends MockCubit<DictationState> implements DictationCubit;
class _AiChat extends MockCubit<AiChatState> implements AiChatCubit;

class _Summary extends MockCubit<SummaryState> implements SummaryCubit;

class _ProfileName extends MockCubit<ProfileNameState>
    implements ProfileNameCubit;

class _Learn extends MockCubit<LearnState> implements LearnCubit;

class _Flashcards extends MockCubit<FlashcardsState> implements FlashcardsCubit;

class _Quiz extends MockCubit<QuizState> implements QuizCubit;

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
    role: WorkspaceRole.owner,
    planCode: 'team',
    planName: 'Jamoa — korporativ tarif',
  ),
  Workspace(
    id: 'w2',
    name:
        'Ташкентский областной хокимият — '
        'пресс-служба и связи с общественностью',
    balanceSeconds: 123456,
    role: WorkspaceRole.admin,
  ),
  Workspace(
    id: 'w3',
    name: 'Call-markaz «1092» — tungi smena',
    role: WorkspaceRole.viewer,
  ),
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
      meetingTitle: i % 4 == 1 ? _longName : null,
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

const _audioPlayer = PlayerState(
  status: PlayerStatus.ready,
  source: PlayableMedia(url: 'https://s3.test/a.m4a', mime: 'audio/mp4'),
  position: Duration(hours: 1, minutes: 23, seconds: 45),
  duration: Duration(hours: 2, minutes: 59, seconds: 59),
  playing: true,
  speed: 1.25,
);

const _videoPlayer = PlayerState(
  status: PlayerStatus.ready,
  source: PlayableMedia(url: 'https://s3.test/v.mp4', mime: 'video/mp4'),
  position: Duration(minutes: 7),
  duration: Duration(hours: 2, minutes: 59, seconds: 59),
  hasVideo: true,
  speed: 0.75,
);

TranscriptState _loaded({bool edit = false}) => TranscriptState(
  status: TranscriptStatus.success,
  transcript: _transcript,
  editMode: edit,
  speakerFilter: edit ? 's2' : null,
);

Widget _editor() => const TranscriptPage(transcriptId: 't1');

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

final List<CalendarEvent> _events = [
  for (var i = 0; i < 5; i++)
    CalendarEvent(
      id: 'e$i',
      title: i.isEven ? _longName : _cyrName,
      startsAt: DateTime(2026, 10, 30 + i, 9, 30),
      joinUrl: i.isEven ? 'https://meet.google.com/abc-defg-hij' : '',
      platform: i.isEven ? 'MEET' : '',
    ),
];

final _balance = Balance(
  balanceSeconds: 5999 * 60,
  plan: const Plan(
    code: 'team',
    name: 'Jamoa — korporativ tarif',
    monthlySeconds: 600000,
    priceUzs: 1999000,
    maxMembers: 50,
  ),
  status: SubscriptionStatus.pastDue,
  periodEnd: DateTime(2026, 11, 29),
);

const _plans = [
  Plan(code: 'free', name: 'Bepul', monthlySeconds: 1800),
  Plan(
    code: 'pro',
    name: 'Pro — mustaqil jurnalistlar uchun',
    monthlySeconds: 36000,
    priceUzs: 99000,
  ),
  Plan(
    code: 'team',
    name: 'Jamoa — korporativ tarif',
    monthlySeconds: 600000,
    priceUzs: 1999000,
    maxMembers: 50,
  ),
];

const _longError =
    'Faylni yuklab boʻlmadi: havola yopiq yoki fayl oʻchirilgan. '
    'Iltimos, havolani tekshirib, qaytadan urinib koʻring. '
    'Файл не удалось загрузить: ссылка закрыта или файл удалён.';

final List<NoteSummary> _notes = [
  for (var i = 0; i < 20; i++)
    NoteSummary(
      id: 'n$i',
      title: i.isEven ? _longName : '',
      excerpt: _cyrName * 2,
      updatedAt: DateTime(2026, 10, 28, 9, 5),
    ),
];

final Note _note = Note(
  id: 'n1',
  title: _longName,
  revision: 3,
  updatedAt: DateTime(2026, 10, 28, 9, 5),
  origin: const NoteOrigin(
    transcriptId: 't1',
    title: _cyrName,
    available: true,
  ),
  blocks: [
    for (var i = 0; i < 12; i++) ...[
      NoteBlock(kind: NoteBlockKind.heading, text: _longName, level: i % 3 + 1),
      const NoteBlock(kind: NoteBlockKind.paragraph, text: _cyrName),
      NoteBlock(
        kind: NoteBlockKind.listItem,
        text: _longName,
        marker: '${100 + i}.',
        depth: i % 4,
      ),
      const NoteBlock(kind: NoteBlockKind.code, text: _cyrName, quoted: true),
    ],
  ],
);
final List<RecoverableRecording> _recoverable = [
  for (var i = 0; i < 3; i++)
    RecoverableRecording(
      path: '/r$i.aac',
      kind: i.isEven ? RecordingKind.microphone : RecordingKind.screen,
      state: i == 0
          ? RecordingCompletion.interrupted
          : RecordingCompletion.finished,
      createdAt: DateTime(2026, 10, 20 + i, 18, 40),
      sizeBytes: 987654321,
      duration: i == 2 ? null : Duration(hours: 9, minutes: 59, seconds: i),
    ),
];

final List<MeetingBot> _bots = [
  for (var i = 0; i < 6; i++)
    MeetingBot(
      id: 'b$i',
      status: MeetingBotStatus.values[i % MeetingBotStatus.values.length],
      meetUrl: 'https://meet.google.com/abc-defg-hij',
      botName: 'Abdulazizxoʻja Muhammadqodirov yordamchisi (yozib olmoqda)',
      meetingTitle: i.isEven ? _longName : null,
      createdAt: DateTime(2026, 10, 29, 9, 30),
    ),
];
// ------------------------------------------------- editor AI tabs data

const _longAnswer =
    'Yigʻilishda uchta asosiy mavzu koʻrildi [00:01:23]: byudjet, '
    'raqamlashtirish va kadrlar. Toshkent shahar hokimining birinchi '
    'oʻrinbosari [1:02:03] muddatlarni belgiladi; Докладчик 2 предложил '
    'закупку оборудования [59:59]. Supercalifragilisticexpialidociousword.';

final List<AiMessage> _chat = [
  for (var i = 0; i < 6; i++) ...[
    AiMessage(
      id: 'q$i',
      role: AiRole.user,
      status: AiMessageStatus.done,
      content: i.isEven ? _longName : _cyrName,
    ),
    AiMessage(
      id: 'a$i',
      role: AiRole.assistant,
      status: i == 4 ? AiMessageStatus.failed : AiMessageStatus.done,
      content: _longAnswer,
      error: i == 4 ? _longError : null,
    ),
  ],
  const AiMessage(
    id: 'q9',
    role: AiRole.user,
    status: AiMessageStatus.done,
    content: _longName,
  ),
  const AiMessage(
    id: 'a9',
    role: AiRole.assistant,
    status: AiMessageStatus.pending,
  ),
];

const _templateName =
    'Yigʻilish bayonnomasi — qarorlar, masʼullar va muddatlar '
    'boʻyicha batafsil';

final _templates = SummaryTemplateLibrary(
  categories: [
    for (var c = 0; c < 3; c++)
      SummaryTemplateCategory(id: 'c$c', name: '$_cyrName $c', position: c),
  ],
  templates: [
    for (var i = 0; i < 12; i++)
      SummaryTemplate(
        id: 'tp$i',
        name: i.isEven ? '$_templateName $i' : '$_cyrName $i',
        owner: i > 9 ? SummaryTemplateOwner.user : SummaryTemplateOwner.system,
        categoryId: i > 9 ? null : 'c${i % 3}',
        favorite: i % 4 == 0,
      ),
  ],
);

final _summaryState = SummaryState(
  templatesStatus: TemplatesStatus.success,
  library: _templates,
  template: _templates.templates.first,
  status: SummaryStatus.success,
  sample: true,
  summary: Summary(
    templateName: _templateName,
    sample: true,
    sections: [
      const SummarySection(
        kind: SummarySectionKind.overview,
        paragraph: _longAnswer,
      ),
      const SummarySection(
        kind: SummarySectionKind.keyPoints,
        bullets: [_longName, _cyrName, _longAnswer],
      ),
      SummarySection(
        kind: SummarySectionKind.speakers,
        bullets: [for (final s in _speakers) '${s.label}: $_longName'],
      ),
      const SummarySection(
        kind: SummarySectionKind.custom,
        title: _cyrName,
        bullets: [_longError],
      ),
    ],
  ),
);

_ProfileName _profileName(ProfileNameState state) {
  final cubit = _ProfileName();
  when(() => cubit.state).thenReturn(state);
  return cubit;
}

final SummaryState _serverSummaryState = _summaryState.copyWith(
  sample: false,
  summary: Summary(
    id: 's1',
    templateName: _longName,
    body: const {'type': 'doc'},
    blocks: [
      const NoteBlock(kind: NoteBlockKind.heading, text: _longName, level: 2),
      const NoteBlock(kind: NoteBlockKind.paragraph, text: _longAnswer),
      for (var i = 0; i < 4; i++)
        NoteBlock(
          kind: NoteBlockKind.listItem,
          text: i.isEven ? _cyrName : _longError,
          marker: '${i + 1}.',
          depth: i % 2,
        ),
    ],
  ),
);

final _flashSet = FlashcardSet(
  id: 'f1',
  difficulty: LearnDifficulty.medium,
  createdAt: DateTime(2026, 10, 29, 12, 30),
  cards: [
    for (var i = 0; i < 20; i++)
      const Flashcard(
        front: '$_longName _____ $_cyrName',
        back: 'Supercalifragilisticexpialidociousword',
        source: _longAnswer,
      ),
  ],
);

final _quizSet = QuizSet(
  id: 'q1',
  difficulty: LearnDifficulty.hard,
  createdAt: DateTime(2026, 10, 29, 12, 45),
  types: QuizQuestionType.values,
  questions: [
    for (var i = 0; i < 20; i++)
      QuizQuestion(
        type: i.isEven
            ? QuizQuestionType.multipleChoice
            : QuizQuestionType.trueFalse,
        prompt: '$_longName _____ $_cyrName',
        options: i.isEven
            ? const [
                'Supercalifragilisticexpialidociousword',
                'раскрепощённость',
                'oʻzbekistonliklarimizdanmisiz',
                'qonunchilik',
              ]
            : const [],
        correctIndex: 1,
        source: _longAnswer,
      ),
  ],
);

final _learnSets = LearnSets(
  flashcards: [
    _flashSet,
    _flashSet.copyWith(id: 'f2'),
  ],
  quizzes: [_quizSet],
);

/// The editor's tab area: a player above, the tab in what is left.
Widget _tabHost(Widget tab) => Scaffold(
  body: SafeArea(
    child: Column(
      children: [
        const SizedBox(height: 180, child: ColoredBox(color: Colors.black)),
        Expanded(child: tab),
      ],
    ),
  ),
);

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
late _Player player;
late _Calendar calendar;
late _Balance balance;
late _Plans plans;
late _Push push;
late _Links links;
late _WorkspaceList workspaceList;
late _Delete deleteAccount;
late _Notes notes;
late _Note note;
late _Recovery recovery;
late _Screen screen;
late _Meeting meeting;
late _UrlImport urlImport;
late _Dictation dictation;
late _AiChat aiChat;
late _Summary summary;
late _Learn learn;
late _Flashcards flashcards;
late _Quiz quiz;

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
  player = _Player();
  calendar = _Calendar();
  balance = _Balance();
  plans = _Plans();
  push = _Push();
  links = _Links();
  workspaceList = _WorkspaceList();
  deleteAccount = _Delete();
  notes = _Notes();
  note = _Note();
  when(() => notes.state)
      .thenReturn(NotesState(status: NotesStatus.success, items: _notes));
  when(() => notes.load(any())).thenAnswer((_) async {});
  when(() => note.state).thenReturn(
    NoteState(status: NoteStatus.success, noteId: 'n1', note: _note),
  );
  when(() => note.load(any())).thenAnswer((_) async {});
  recovery = _Recovery();
  screen = _Screen();
  meeting = _Meeting();
  urlImport = _UrlImport();
  dictation = _Dictation();

  when(() => recovery.state).thenReturn(const RecoveryState());
  when(() => recovery.load()).thenAnswer((_) async {});
  when(() => screen.state).thenReturn(const ScreenCaptureState());
  when(() => screen.init()).thenAnswer((_) async {});
  when(() => meeting.state).thenReturn(const MeetingBotState());
  when(() => meeting.load(any())).thenAnswer((_) async {});
  when(() => urlImport.state).thenReturn(const UrlImportState());
  when(() => dictation.state).thenReturn(const DictationState());
  aiChat = _AiChat();
  summary = _Summary();
  learn = _Learn();
  flashcards = _Flashcards();
  quiz = _Quiz();

  when(() => aiChat.state).thenReturn(
    AiChatState(
      status: AiChatStatus.success,
      items: _chat,
      actionFailure: const Failure.server(statusCode: 409),
    ),
  );
  when(() => aiChat.load(any())).thenAnswer((_) async {});
  when(() => summary.state).thenReturn(_summaryState);
  when(() => summary.start(any())).thenAnswer((_) async {});
  when(() => learn.state).thenReturn(
    LearnState(
      status: LearnStatus.ready,
      sets: _learnSets,
      createStatus: LearnCreateStatus.empty,
    ),
  );
  when(() => learn.start(any())).thenAnswer((_) async {});
  when(() => flashcards.state).thenReturn(
    FlashcardsState(
      cards: _flashSet.cards,
      index: 18,
      known: {for (var i = 0; i < 9; i++) i},
      repeat: {for (var i = 9; i < 18; i++) i},
    ),
  );
  when(() => flashcards.start(any())).thenReturn(null);
  when(() => quiz.state).thenReturn(
    QuizState(
      questions: _quizSet.questions,
      index: 18,
      answers: [
        for (var i = 0; i < 20; i++)
          if (i == 18) 2 else if (i < 19) i % 4 else null,
      ],
    ),
  );
  when(() => quiz.start(any())).thenReturn(null);

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
  when(() => player.state).thenReturn(_audioPlayer);
  when(() => player.open(any())).thenAnswer((_) async {});
  when(() => player.pause()).thenAnswer((_) async {});
  when(
    () => calendar.state,
  ).thenReturn(CalendarState(status: CalendarStatus.success, events: _events));
  when(() => calendar.load()).thenAnswer((_) async {});
  when(() => balance.state).thenReturn(
    BalanceState(
      status: BalanceStatus.success,
      workspaceId: 'w1',
      balance: _balance,
    ),
  );
  when(() => balance.load(any())).thenAnswer((_) async {});
  when(() => plans.state)
      .thenReturn(const PlansState(status: PlansStatus.success, plans: _plans));
  when(() => plans.load()).thenAnswer((_) async {});
  when(() => push.state).thenReturn(const PushState());
  when(() => links.state).thenReturn(const LinksState());
  when(() => workspaceList.state).thenReturn(
    const WorkspaceListState(
      status: WorkspaceListStatus.success,
      items: _workspaces,
    ),
  );
  when(() => workspaceList.load()).thenAnswer((_) async {});
  when(() => deleteAccount.state).thenReturn(
    const DeleteAccountState(
      status: DeleteAccountStatus.failure,
      failure: Failure.server(statusCode: 409),
    ),
  );

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
    ..registerFactory<TranscriptCubit>(() => transcript)
    ..registerFactory<PlayerCubit>(() => player)
    ..registerFactory<CalendarCubit>(() => calendar)
    ..registerFactory<BalanceCubit>(() => balance)
    ..registerFactory<PlansCubit>(() => plans)
    ..registerFactory<WorkspaceListCubit>(() => workspaceList)
    ..registerFactory<DeleteAccountCubit>(() => deleteAccount)
    ..registerFactory<NotesCubit>(() => notes)
    ..registerFactory<NoteCubit>(() => note)
    ..registerFactory<RecoveryCubit>(() => recovery)
    ..registerFactory<ScreenCaptureCubit>(() => screen)
    ..registerFactory<MeetingBotCubit>(() => meeting)
    ..registerFactory<UrlImportCubit>(() => urlImport)
    ..registerFactory<DictationCubit>(() => dictation)
    ..registerFactory<AiChatCubit>(() => aiChat)
    ..registerFactory<SummaryCubit>(() => summary)
    ..registerFactory<LearnCubit>(() => learn)
    ..registerFactory<FlashcardsCubit>(() => flashcards)
    ..registerFactory<QuizCubit>(() => quiz);
}

// ----------------------------------------------------------- scenarios

/// Which page sits in the bottom-nav shell, as in the real router.
enum _Shell { none, home, files }

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
    measure: {'IllustratedCard': () => find.byType(IllustratedCard)},
  ),
  _Scenario(
    'files',
    FilesPage.new,
    shell: _Shell.files,
    measure: {'LibraryTile': () => find.byType(LibraryTile)},
  ),
  _Scenario(
    'files(empty)',
    FilesPage.new,
    shell: _Shell.files,
    arrange: () {
      when(() => library.state).thenReturn(
        const LibraryState(status: LibraryStatus.empty, workspaceId: 'w1'),
      );
      when(() => folders.state).thenReturn(const FoldersState());
    },
  ),
  _Scenario(
    'files(viewer)',
    FilesPage.new,
    shell: _Shell.files,
    arrange: () => when(() => account.state).thenReturn(
      const AccountState(
        status: AccountStatus.success,
        account: Account(
          user: _user,
          workspaces: _workspaces,
          selectedWorkspaceId: 'w3',
        ),
      ),
    ),
  ),
  _Scenario(
    'files(failure)',
    FilesPage.new,
    shell: _Shell.files,
    arrange: () => when(() => library.state).thenReturn(
      const LibraryState(
        status: LibraryStatus.failure,
        workspaceId: 'w1',
        failure: Failure.network(),
      ),
    ),
  ),
  _Scenario(
    'files(notes list)',
    () => Scaffold(
      body: BlocProvider<NotesCubit>.value(
        value: notes,
        child: const NotesList(),
      ),
    ),
  ),
  _Scenario(
    'files(notes empty)',
    () => Scaffold(
      body: BlocProvider<NotesCubit>.value(
        value: notes,
        child: const NotesList(),
      ),
    ),
    arrange: () =>
        when(() => notes.state)
            .thenReturn(const NotesState(status: NotesStatus.empty)),
  ),
  _Scenario(
    'sheet(file menu)',
    () => Scaffold(body: FileMenuSheet(item: _items[2])),
  ),
  _Scenario('note', () => const NotePage(noteId: 'n1')),
  _Scenario(
    'home(calendar off)',
    HomePage.new,
    shell: _Shell.home,
    arrange: () => when(() => calendar.state)
        .thenReturn(const CalendarState(status: CalendarStatus.notConnected)),
  ),
  const _Scenario('settings', SettingsPage.new),
  _Scenario(
    'settings(google, no plan)',
    SettingsPage.new,
    arrange: () {
      when(() => account.state).thenReturn(
        AccountState(
          status: AccountStatus.success,
          account: _account.account!.copyWith(
            user: _user.copyWith(hasPassword: false),
          ),
        ),
      );
      when(() => balance.state).thenReturn(const BalanceState());
    },
  ),
  const _Scenario('profile', ProfilePage.new),
  _Scenario(
    'sheet(profile name, error)',
    () => Scaffold(
      body: BlocProvider<ProfileNameCubit>.value(
        value: _profileName(const ProfileNameState(invalid: NameError.tooLong)),
        child: const ProfileNameSheet(initial: _longName),
      ),
    ),
    measure: {'TextField': _field, 'FilledButton': _filled},
  ),
  _Scenario(
    'sheet(profile name, saving)',
    () => Scaffold(
      body: BlocProvider<ProfileNameCubit>.value(
        value: _profileName(
          const ProfileNameState(status: ProfileNameStatus.saving),
        ),
        child: const ProfileNameSheet(initial: _cyrName),
      ),
    ),
  ),
  const _Scenario('plans', PlansPage.new),
  _Scenario(
    'home(recovery banner)',
    HomePage.new,
    shell: _Shell.home,
    arrange: () => when(() => recovery.state).thenReturn(
      RecoveryState(
        status: RecoveryStatus.success,
        items: [_recoverable.first],
      ),
    ),
  ),
  _Scenario(
    'sheet(recovery)',
    () => Scaffold(
      body: BlocProvider<RecoveryCubit>.value(
        value: recovery,
        child: const RecoverySheet(),
      ),
    ),
    arrange: () => when(() => recovery.state).thenReturn(
      RecoveryState(
        status: RecoveryStatus.success,
        items: _recoverable,
        busyPath: _recoverable.last.path,
        failure: const Failure.storage(),
      ),
    ),
  ),
  _Scenario(
    'recorder(idle+recovery)',
    RecorderPage.new,
    arrange: () => when(() => recovery.state).thenReturn(
      RecoveryState(status: RecoveryStatus.success, items: _recoverable),
    ),
  ),
  _Scenario(
    'screen(unsupported)',
    ScreenRecordPage.new,
    arrange: () =>
        when(() => screen.state)
            .thenReturn(const ScreenCaptureState(supported: false)),
  ),
  _Scenario(
    'screen(idle)',
    ScreenRecordPage.new,
    arrange: () =>
        when(() => screen.state)
            .thenReturn(const ScreenCaptureState(supported: true)),
    measure: {'FilledButton': _filled},
  ),
  _Scenario(
    'screen(failure)',
    ScreenRecordPage.new,
    arrange: () => when(() => screen.state).thenReturn(
      const ScreenCaptureState(
        supported: true,
        status: ScreenCaptureStatus.failure,
        failure: Failure.permissionDenied(),
      ),
    ),
  ),
  _Scenario(
    'screen(recording+silent)',
    ScreenRecordPage.new,
    arrange: () => when(() => screen.state).thenReturn(
      ScreenCaptureState(
        supported: true,
        status: ScreenCaptureStatus.recording,
        withMic: true,
        playbackSilent: true,
        elapsed: const Duration(hours: 10, minutes: 1),
        levels: [for (var i = 0; i < 48; i++) (i % 5) / 5],
      ),
    ),
  ),
  _Scenario(
    'meeting(form+list)',
    MeetingPage.new,
    arrange: () => when(() => meeting.state).thenReturn(
      MeetingBotState(
        workspaceId: 'w1',
        listStatus: MeetingListStatus.success,
        items: _bots,
        available: false,
        defaultBotName: _bots.first.botName,
        urlInvalid: true,
        actionFailure: const Failure.server(statusCode: 402),
      ),
    ),
    measure: {'TextField': _field, 'FilledButton': _filled},
  ),
  _Scenario(
    'meeting(summary options)',
    () => Scaffold(
      body: BlocProvider<SummaryCubit>.value(
        value: summary,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            MeetingSummaryOptions(
              summarize: true,
              shareInternal: true,
              onSummarize: (_) {},
              onShareInternal: (_) {},
            ),
          ],
        ),
      ),
    ),
    arrange: () => when(() => summary.state).thenReturn(
      _summaryState.copyWith(
        templatesStatus: TemplatesStatus.loading,
        template: _templates.templates.first.copyWith(name: _longName),
      ),
    ),
  ),
  _Scenario(
    'meeting(recording)',
    MeetingPage.new,
    arrange: () => when(() => meeting.state).thenReturn(
      MeetingBotState(
        workspaceId: 'w1',
        active: _bots.first.copyWith(status: MeetingBotStatus.recording),
        pollFailure: const Failure.network(),
      ),
    ),
  ),
  _Scenario(
    'meeting(denied)',
    MeetingPage.new,
    arrange: () => when(() => meeting.state).thenReturn(
      MeetingBotState(
        workspaceId: 'w1',
        active: _bots.first.copyWith(
          status: MeetingBotStatus.denied,
          errorMessage: _longError,
        ),
      ),
    ),
  ),
  _Scenario(
    'meeting(route missing)',
    MeetingPage.new,
    arrange: () =>
        when(() => meeting.state)
            .thenReturn(const MeetingBotState(routeMissing: true)),
  ),
  _Scenario(
    'url(not available)',
    UrlPage.new,
    arrange: () => when(() => urlImport.state)
        .thenReturn(const UrlImportState(status: UrlImportStatus.notAvailable)),
    measure: {'TextField': _field, 'FilledButton': _filled},
  ),
  _Scenario(
    'url(invalid)',
    UrlPage.new,
    arrange: () =>
        when(() => urlImport.state)
            .thenReturn(const UrlImportState(urlInvalid: true)),
  ),
  const _Scenario('dictation(idle)', DictationPage.new),
  _Scenario(
    'dictation(listening)',
    DictationPage.new,
    arrange: () => when(() => dictation.state).thenReturn(
      DictationState(
        status: DictationStatus.listening,
        finals: [
          for (var i = 0; i < 6; i++) ...[_longName, _cyrName],
        ],
        partial: _longError,
        elapsed: const Duration(hours: 1, minutes: 2),
      ),
    ),
  ),
  const _Scenario(
    'dictation(stopped)',
    DictationPage.new,
    arrange: _dictationStopped,
  ),
  _Scenario('sheet(sources)', () => const Scaffold(body: SourceSheet())),
  _Scenario(
    'sheet(workspaces)',
    () => Scaffold(
      body: BlocProvider<WorkspaceListCubit>.value(
        value: workspaceList,
        child: const WorkspaceSwitcherSheet(),
      ),
    ),
  ),
  _Scenario(
    'sheet(delete,409)',
    () => Scaffold(
      body: BlocProvider<DeleteAccountCubit>.value(
        value: deleteAccount,
        child: const DeleteAccountSheet(user: _user),
      ),
    ),
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
    'editor(audio, 200 segs)',
    _editor,
    arrange: () => when(() => transcript.state).thenReturn(_loaded()),
    measure: {'SegmentTile': () => find.byType(SegmentTile)},
  ),
  _Scenario(
    'editor(video, edit mode, filter)',
    _editor,
    arrange: () {
      when(() => transcript.state).thenReturn(_loaded(edit: true));
      when(() => player.state).thenReturn(_videoPlayer);
    },
  ),
  _Scenario(
    'editor(video folded)',
    _editor,
    arrange: () {
      when(() => transcript.state).thenReturn(_loaded());
      when(() => player.state)
          .thenReturn(_videoPlayer.copyWith(videoFolded: true));
    },
  ),
  _Scenario(
    'editor(youtube)',
    _editor,
    arrange: () {
      when(() => transcript.state).thenReturn(_loaded());
      when(() => player.state).thenReturn(
        const PlayerState(
          status: PlayerStatus.youtube,
          source: PlayableMedia(
            url: 'https://www.youtube.com/watch?v=jNQXAC9IVRw',
            youtubeId: 'jNQXAC9IVRw',
          ),
        ),
      );
    },
  ),
  _Scenario(
    'editor(audio gone)',
    _editor,
    arrange: () {
      when(() => transcript.state).thenReturn(_loaded());
      when(() => player.state).thenReturn(
        const PlayerState(
          status: PlayerStatus.unavailable,
          failure: Failure.server(statusCode: 410),
        ),
      );
    },
  ),
  _Scenario(
    'editor(player failed)',
    _editor,
    arrange: () {
      when(() => transcript.state).thenReturn(_loaded());
      when(() => player.state).thenReturn(
        const PlayerState(
          status: PlayerStatus.failure,
          failure: Failure.network(),
        ),
      );
    },
  ),
  _Scenario(
    'editor(loading)',
    _editor,
    arrange: () => when(() => transcript.state)
        .thenReturn(const TranscriptState(status: TranscriptStatus.loading)),
  ),
  _Scenario(
    'editor(error)',
    _editor,
    arrange: () => when(() => transcript.state).thenReturn(
      const TranscriptState(
        status: TranscriptStatus.failure,
        failure: Failure.server(statusCode: 500),
      ),
    ),
  ),
  _Scenario(
    'sheet(file actions)',
    () => Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TranscriptCubit>.value(value: transcript),
          BlocProvider<PlayerCubit>.value(value: player),
        ],
        child: const EditorActionsSheet(),
      ),
    ),
    arrange: () => when(() => transcript.state).thenReturn(_loaded()),
  ),
  _Scenario(
    'tab(ai chat)',
    () => _tabHost(AiChatTab(transcriptId: 't1', onSeek: (_) {})),
  ),
  _Scenario(
    'tab(ai chat,empty)',
    () => _tabHost(const AiChatTab(transcriptId: 't1')),
    arrange: () =>
        when(() => aiChat.state)
            .thenReturn(const AiChatState(status: AiChatStatus.success)),
  ),
  _Scenario(
    'tab(summary)',
    () => _tabHost(SummaryTab(transcript: _transcript)),
  ),
  _Scenario(
    'tab(summary,empty)',
    () => _tabHost(SummaryTab(transcript: _transcript)),
    arrange: () => when(() => summary.state).thenReturn(
      _summaryState.copyWith(status: SummaryStatus.idle, summary: null),
    ),
  ),
  _Scenario(
    'tab(summary,generating)',
    () => _tabHost(SummaryTab(transcript: _transcript)),
    arrange: () => when(() => summary.state)
        .thenReturn(_summaryState.copyWith(status: SummaryStatus.generating)),
  ),
  _Scenario(
    'tab(summary,server)',
    () => _tabHost(SummaryTab(transcript: _transcript)),
    arrange: () => when(() => summary.state).thenReturn(_serverSummaryState),
  ),
  _Scenario(
    'tab(summary,loading)',
    () => _tabHost(SummaryTab(transcript: _transcript)),
    arrange: () =>
        when(() => summary.state)
            .thenReturn(const SummaryState(status: SummaryStatus.loading)),
  ),
  _Scenario(
    'tab(summary,failed)',
    () => _tabHost(SummaryTab(transcript: _transcript)),
    arrange: () => when(() => summary.state).thenReturn(
      _serverSummaryState.copyWith(
        status: SummaryStatus.failure,
        summary: const Summary(
          id: 's1',
          progress: SummaryProgress.failed,
          error: _longError,
        ),
      ),
    ),
  ),
  _Scenario(
    'tab(summary,short)',
    () => _tabHost(SummaryTab(transcript: _transcript)),
    arrange: () =>
        when(() => summary.state)
            .thenReturn(const SummaryState(status: SummaryStatus.tooShort)),
  ),
  _Scenario(
    'sheet(summary templates)',
    () => Scaffold(
      body: BlocProvider<SummaryCubit>.value(
        value: summary,
        child: const TemplatePickerSheet(),
      ),
    ),
  ),
  _Scenario('tab(learn)', () => _tabHost(LearnTab(transcript: _transcript))),
  _Scenario(
    'tab(learn,short)',
    () => _tabHost(LearnTab(transcript: _transcript)),
    arrange: () =>
        when(() => learn.state)
            .thenReturn(const LearnState(status: LearnStatus.tooShort)),
  ),
  const _Scenario('sheet(learn quiz create)', _learnCreateQuiz),
  _Scenario('flashcards', () => FlashcardsPage(set: _flashSet)),
  _Scenario(
    'flashcards(flipped)',
    () => FlashcardsPage(set: _flashSet),
    arrange: () => when(() => flashcards.state).thenReturn(
      FlashcardsState(cards: _flashSet.cards, index: 3, flipped: true),
    ),
  ),
  _Scenario(
    'flashcards(done)',
    () => FlashcardsPage(set: _flashSet),
    arrange: () => when(() => flashcards.state).thenReturn(
      FlashcardsState(
        cards: _flashSet.cards,
        index: 19,
        finished: true,
        known: {1, 2},
        repeat: {3},
      ),
    ),
  ),
  _Scenario('quiz(answered)', () => QuizPage(set: _quizSet)),
  _Scenario(
    'quiz(result)',
    () => QuizPage(set: _quizSet),
    arrange: () => when(() => quiz.state).thenReturn(
      QuizState(
        questions: _quizSet.questions,
        index: 19,
        finished: true,
        answers: [for (var i = 0; i < 20; i++) i % 3],
      ),
    ),
  ),
];

Widget _learnCreateQuiz() => const Scaffold(body: LearnCreateSheet(quiz: true));

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
      initialLocation: s.shell == _Shell.files ? '/files' : '/',
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
  return MultiBlocProvider(
    providers: [
      BlocProvider<AccountCubit>.value(value: account),
      BlocProvider<PushCubit>.value(value: push),
      BlocProvider<LinksCubit>.value(value: links),
    ],
    child: app,
  );
}

Future<void> _loadRealFont() async {
  // The test font draws every glyph 1 em wide, which overflows far sooner
  // than any real face. The app's own faces are bundled, so they are
  // loaded under their family names; Roboto (Noto Sans metrics) covers
  // anything that asks for the platform default.
  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final f in files) {
      final bytes = File('assets/fonts/$f').readAsBytesSync();
      loader.addFont(Future.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  await load('Roboto', ['NotoSans-Regular.ttf', 'NotoSans-Bold.ttf']);
  await load('GolosText', ['GolosText-Variable.ttf']);
  await load('Unbounded', ['Unbounded-Variable.ttf']);
  // Icons draw as boxes in tests unless their font is loaded too; only the
  // screenshots need it.
  final icons = File(
    '${Platform.environment['FLUTTER_ROOT'] ?? '/opt/flutter'}'
    '/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
  if (icons.existsSync()) {
    final loader = FontLoader('MaterialIcons')
      ..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync())));
    await loader.load();
  }
}

final String? _shotsDir = Platform.environment['RESPONSIVE_SHOTS'];
const _shotKey = Key('responsive_shot');

Future<void> _shot(WidgetTester tester, String name) async {
  final boundary =
      tester.renderObject(find.byKey(_shotKey)) as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final safe = name.replaceAll(RegExp('[^A-Za-z0-9_-]+'), '_');
    File('$_shotsDir/$safe.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(data!.buffer.asUint8List());
  });
}

void main() {
  setUpAll(() async {
    registerFallbackValue('');
    registerFallbackValue(_transcript);
    registerFallbackValue(_flashSet);
    registerFallbackValue(_quizSet);
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
          await tester.pumpWidget(
            RepaintBoundary(key: _shotKey, child: _app(s, c.scale)),
          );
          // Spinners never settle; a few frames are enough for layout.
          for (var i = 0; i < 4; i++) {
            await tester.pump(const Duration(milliseconds: 100));
          }
          if (_shotsDir != null && c.name == '393x852') {
            await _shot(tester, s.name);
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

void _dictationStopped() => when(() => dictation.state).thenReturn(
  const DictationState(
    status: DictationStatus.stopped,
    finals: [_longName, _cyrName],
    failure: Failure.network(),
  ),
);
