import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/network/session_manager.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/login_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/profile_page.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/register_page.dart';
import 'package:transkriptor_uz/features/billing/presentation/pages/plans_page.dart';
import 'package:transkriptor_uz/features/capture/presentation/pages/dictation_page.dart';
import 'package:transkriptor_uz/features/capture/presentation/pages/meeting_page.dart';
import 'package:transkriptor_uz/features/capture/presentation/pages/screen_record_page.dart';
import 'package:transkriptor_uz/features/capture/presentation/pages/url_page.dart';
import 'package:transkriptor_uz/features/home/presentation/pages/home_page.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/app_shell.dart';
import 'package:transkriptor_uz/features/job/presentation/pages/job_page.dart';
import 'package:transkriptor_uz/features/library/presentation/pages/files_page.dart';
import 'package:transkriptor_uz/features/recorder/presentation/pages/recorder_page.dart';
import 'package:transkriptor_uz/features/settings/presentation/pages/settings_page.dart';
import 'package:transkriptor_uz/features/transcript/presentation/pages/transcript_page.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/link_page.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/send_page.dart';

/// Owns the [GoRouter]. Session expiry reaches it through [SessionManager]
/// as a listenable, so the network layer never needs a navigation context.
@lazySingleton
class AppRouter {
  AppRouter(this._session);

  final SessionManager _session;

  late final GoRouter config = GoRouter(
    initialLocation: Routes.home,
    refreshListenable: _session,
    redirect: (context, state) {
      // Login, register and password reset are open without a session.
      final atAuth =
          state.matchedLocation == Routes.login ||
          state.matchedLocation == Routes.register ||
          state.matchedLocation == Routes.forgotPassword;
      // Leaving them is the page's own job: it navigates once the account
      // is stored, never before.
      if (_session.isExpired && !atAuth) return Routes.login;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'forgot',
            builder: (context, state) => ForgotPasswordPage(
              initialEmail: state.extra is String ? state.extra! as String : '',
            ),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.files,
                builder: (context, state) => const FilesPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsPage(),
        routes: [
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: 'plans',
            builder: (context, state) => const PlansPage(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.record,
        builder: (context, state) => const RecorderPage(),
      ),
      GoRoute(
        path: Routes.send,
        // Without a file there is nothing to send (e.g. a restored route).
        redirect: (context, state) =>
            state.extra is PendingFile ? null : Routes.home,
        builder: (context, state) =>
            SendPage(file: state.extra! as PendingFile),
      ),
      GoRoute(path: Routes.link, builder: (context, state) => const LinkPage()),
      GoRoute(
        path: Routes.dictation,
        builder: (context, state) => const DictationPage(),
      ),
      GoRoute(
        path: Routes.screenRecord,
        builder: (context, state) => const ScreenRecordPage(),
      ),
      GoRoute(
        path: Routes.meeting,
        builder: (context, state) => const MeetingPage(),
      ),
      GoRoute(path: Routes.url, builder: (context, state) => const UrlPage()),
      GoRoute(
        path: Routes.job,
        builder: (context, state) =>
            JobPage(jobId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.transcript,
        builder: (context, state) =>
            TranscriptPage(transcriptId: state.pathParameters['id']!),
      ),
    ],
  );
}
