// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter/services.dart' as _i281;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:record/record.dart' as _i1039;
import 'package:share_plus/share_plus.dart' as _i998;
import 'package:transkriptor_uz/core/di/network_module.dart' as _i645;
import 'package:transkriptor_uz/core/events/library_changes.dart' as _i252;
import 'package:transkriptor_uz/core/network/session_manager.dart' as _i754;
import 'package:transkriptor_uz/core/network/token_interceptor.dart' as _i60;
import 'package:transkriptor_uz/core/router/app_router.dart' as _i1008;
import 'package:transkriptor_uz/core/storage/token_storage.dart' as _i933;
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart'
    as _i322;
import 'package:transkriptor_uz/features/auth/application/delete_account_cubit.dart'
    as _i506;
import 'package:transkriptor_uz/features/auth/application/forgot_password_bloc.dart'
    as _i595;
import 'package:transkriptor_uz/features/auth/application/login_bloc.dart'
    as _i441;
import 'package:transkriptor_uz/features/auth/application/register_bloc.dart'
    as _i7;
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart'
    as _i865;
import 'package:transkriptor_uz/features/auth/infrastructure/facades/auth_facade.dart'
    as _i1041;
import 'package:transkriptor_uz/features/auth/infrastructure/google_module.dart'
    as _i64;
import 'package:transkriptor_uz/features/auth/infrastructure/repositories/auth_repository.dart'
    as _i838;
import 'package:transkriptor_uz/features/auth/infrastructure/services/google_id_token_source.dart'
    as _i605;
import 'package:transkriptor_uz/features/billing/application/balance_cubit.dart'
    as _i207;
import 'package:transkriptor_uz/features/billing/application/plans_cubit.dart'
    as _i992;
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart'
    as _i171;
import 'package:transkriptor_uz/features/billing/infrastructure/facades/billing_facade.dart'
    as _i375;
import 'package:transkriptor_uz/features/billing/infrastructure/repositories/billing_repository.dart'
    as _i354;
import 'package:transkriptor_uz/features/calendar/application/calendar_cubit.dart'
    as _i698;
import 'package:transkriptor_uz/features/calendar/domain/i_calendar_facade.dart'
    as _i763;
import 'package:transkriptor_uz/features/calendar/infrastructure/facades/calendar_facade.dart'
    as _i65;
import 'package:transkriptor_uz/features/calendar/infrastructure/repositories/calendar_repository.dart'
    as _i602;
import 'package:transkriptor_uz/features/capture/application/screen_capture_cubit.dart'
    as _i88;
import 'package:transkriptor_uz/features/capture/domain/i_screen_capture_facade.dart'
    as _i266;
import 'package:transkriptor_uz/features/capture/infrastructure/facades/screen_capture_facade.dart'
    as _i760;
import 'package:transkriptor_uz/features/capture/infrastructure/sources/screen_audio_source.dart'
    as _i76;
import 'package:transkriptor_uz/features/export/application/export_cubit.dart'
    as _i644;
import 'package:transkriptor_uz/features/export/domain/i_export_facade.dart'
    as _i938;
import 'package:transkriptor_uz/features/export/infrastructure/facades/export_facade.dart'
    as _i469;
import 'package:transkriptor_uz/features/export/infrastructure/share_module.dart'
    as _i41;
import 'package:transkriptor_uz/features/job/application/job_cubit.dart'
    as _i331;
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart'
    as _i669;
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart' as _i727;
import 'package:transkriptor_uz/features/job/infrastructure/facades/job_facade.dart'
    as _i367;
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart'
    as _i730;
import 'package:transkriptor_uz/features/library/application/file_actions_cubit.dart'
    as _i899;
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart'
    as _i568;
import 'package:transkriptor_uz/features/library/application/library_bloc.dart'
    as _i224;
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart'
    as _i118;
import 'package:transkriptor_uz/features/library/infrastructure/facades/library_facade.dart'
    as _i985;
import 'package:transkriptor_uz/features/library/infrastructure/repositories/library_repository.dart'
    as _i203;
import 'package:transkriptor_uz/features/push/application/push_cubit.dart'
    as _i752;
import 'package:transkriptor_uz/features/push/domain/i_push_facade.dart'
    as _i201;
import 'package:transkriptor_uz/features/push/infrastructure/facades/push_facade.dart'
    as _i32;
import 'package:transkriptor_uz/features/push/infrastructure/messaging/messaging_source.dart'
    as _i1027;
import 'package:transkriptor_uz/features/push/infrastructure/repositories/push_repository.dart'
    as _i765;
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart'
    as _i206;
import 'package:transkriptor_uz/features/recorder/application/recovery_cubit.dart'
    as _i764;
import 'package:transkriptor_uz/features/recorder/domain/i_recorder_facade.dart'
    as _i239;
import 'package:transkriptor_uz/features/recorder/infrastructure/facades/recorder_facade.dart'
    as _i293;
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart'
    as _i597;
import 'package:transkriptor_uz/features/recorder/infrastructure/recorder_module.dart'
    as _i540;
import 'package:transkriptor_uz/features/recorder/infrastructure/store/recordings_store.dart'
    as _i1005;
import 'package:transkriptor_uz/features/share/application/share_cubit.dart'
    as _i966;
import 'package:transkriptor_uz/features/share/domain/i_share_facade.dart'
    as _i1064;
import 'package:transkriptor_uz/features/share/infrastructure/facades/share_facade.dart'
    as _i68;
import 'package:transkriptor_uz/features/share/infrastructure/repositories/share_repository.dart'
    as _i438;
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart'
    as _i86;
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart'
    as _i900;
import 'package:transkriptor_uz/features/transcript/infrastructure/facades/transcript_facade.dart'
    as _i39;
import 'package:transkriptor_uz/features/transcript/infrastructure/repositories/transcript_repository.dart'
    as _i77;
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart'
    as _i741;
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart'
    as _i956;
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart'
    as _i122;
import 'package:transkriptor_uz/features/upload/infrastructure/facades/upload_facade.dart'
    as _i612;
import 'package:transkriptor_uz/features/upload/infrastructure/media_picker.dart'
    as _i155;
import 'package:transkriptor_uz/features/upload/infrastructure/repositories/upload_repository.dart'
    as _i198;
import 'package:transkriptor_uz/features/workspace/application/workspace_list_cubit.dart'
    as _i720;
import 'package:transkriptor_uz/features/workspace/domain/i_workspace_facade.dart'
    as _i537;
import 'package:transkriptor_uz/features/workspace/infrastructure/facades/workspace_facade.dart'
    as _i37;
import 'package:transkriptor_uz/features/workspace/infrastructure/repositories/workspace_repository.dart'
    as _i385;
import 'package:transkriptor_uz/features/workspace/infrastructure/storage/workspace_selection_storage.dart'
    as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    final googleModule = _$GoogleModule();
    final shareModule = _$ShareModule();
    final recorderModule = _$RecorderModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => networkModule.secureStorage,
    );
    gh.lazySingleton<_i252.LibraryChanges>(
      () => _i252.LibraryChanges(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i754.SessionManager>(() => _i754.SessionManager());
    gh.lazySingleton<_i116.GoogleSignIn>(() => googleModule.googleSignIn);
    gh.lazySingleton<_i76.ScreenAudioSource>(() => _i76.ScreenAudioSource());
    gh.lazySingleton<_i998.SharePlus>(() => shareModule.sharePlus);
    gh.lazySingleton<_i281.AssetBundle>(() => shareModule.assetBundle);
    gh.lazySingleton<_i669.JobPollPolicy>(() => _i669.JobPollPolicy());
    gh.lazySingleton<_i597.NativeCaptureChannel>(
      () => _i597.NativeCaptureChannel(),
    );
    gh.lazySingleton<_i1039.AudioRecorder>(() => recorderModule.audioRecorder);
    gh.lazySingleton<_i155.MediaPicker>(() => _i155.MediaPicker());
    gh.lazySingleton<_i1008.AppRouter>(
      () => _i1008.AppRouter(gh<_i754.SessionManager>()),
    );
    gh.lazySingleton<_i1027.MessagingSource>(
      () => _i1027.FirebaseMessagingSource(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.retryDio(),
      instanceName: 'retryDio',
    );
    gh.lazySingleton<_i1005.RecordingsStore>(
      () => _i1005.RecordingsStore(gh<_i597.NativeCaptureChannel>()),
    );
    gh.lazySingleton<_i464.WorkspaceSelectionStorage>(
      () => _i464.WorkspaceSelectionStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.uploadDio(),
      instanceName: 'uploadDio',
    );
    gh.lazySingleton<_i933.TokenStorage>(
      () => _i933.SecureTokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i60.TokenInterceptor>(
      () => _i60.TokenInterceptor(
        gh<_i933.TokenStorage>(),
        gh<_i754.SessionManager>(),
        gh<_i361.Dio>(instanceName: 'retryDio'),
      ),
    );
    gh.lazySingleton<_i239.IRecorderFacade>(
      () => _i293.RecorderFacade(
        gh<_i1039.AudioRecorder>(),
        gh<_i1005.RecordingsStore>(),
        gh<_i597.NativeCaptureChannel>(),
      ),
    );
    gh.lazySingleton<_i938.IExportFacade>(
      () => _i469.ExportFacade(gh<_i998.SharePlus>(), gh<_i281.AssetBundle>()),
    );
    gh.lazySingleton<_i266.IScreenCaptureFacade>(
      () => _i760.ScreenCaptureFacade(
        gh<_i76.ScreenAudioSource>(),
        gh<_i1039.AudioRecorder>(),
        gh<_i597.NativeCaptureChannel>(),
        gh<_i1005.RecordingsStore>(),
      ),
    );
    gh.lazySingleton<_i605.GoogleIdTokenSource>(
      () => _i605.GoogleIdTokenSource(gh<_i116.GoogleSignIn>()),
    );
    gh.factory<_i88.ScreenCaptureCubit>(
      () => _i88.ScreenCaptureCubit(gh<_i266.IScreenCaptureFacade>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i60.TokenInterceptor>()),
    );
    gh.lazySingleton<_i838.AuthRepository>(
      () => _i838.AuthRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i354.BillingRepository>(
      () => _i354.BillingRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i602.CalendarRepository>(
      () => _i602.CalendarRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i730.JobRepository>(
      () => _i730.JobRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i203.LibraryRepository>(
      () => _i203.LibraryRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i765.PushRepository>(
      () => _i765.PushRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i438.ShareRepository>(
      () => _i438.ShareRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i77.TranscriptRepository>(
      () => _i77.TranscriptRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i385.WorkspaceRepository>(
      () => _i385.WorkspaceRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i118.ILibraryFacade>(
      () => _i985.LibraryFacade(gh<_i203.LibraryRepository>()),
    );
    gh.lazySingleton<_i865.IAuthFacade>(
      () => _i1041.AuthFacade(
        gh<_i838.AuthRepository>(),
        gh<_i933.TokenStorage>(),
        gh<_i754.SessionManager>(),
        gh<_i605.GoogleIdTokenSource>(),
      ),
    );
    gh.factory<_i899.FileActionsCubit>(
      () => _i899.FileActionsCubit(
        gh<_i118.ILibraryFacade>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.factory<_i568.FoldersCubit>(
      () => _i568.FoldersCubit(
        gh<_i118.ILibraryFacade>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.factory<_i206.RecorderCubit>(
      () => _i206.RecorderCubit(gh<_i239.IRecorderFacade>()),
    );
    gh.factory<_i764.RecoveryCubit>(
      () => _i764.RecoveryCubit(gh<_i239.IRecorderFacade>()),
    );
    gh.lazySingleton<_i198.UploadRepository>(
      () => _i198.UploadRepository(
        gh<_i361.Dio>(),
        gh<_i361.Dio>(instanceName: 'uploadDio'),
      ),
    );
    gh.factory<_i644.ExportCubit>(
      () => _i644.ExportCubit(gh<_i938.IExportFacade>()),
    );
    gh.lazySingleton<_i537.IWorkspaceFacade>(
      () => _i37.WorkspaceFacade(
        gh<_i385.WorkspaceRepository>(),
        gh<_i464.WorkspaceSelectionStorage>(),
      ),
    );
    gh.lazySingleton<_i171.IBillingFacade>(
      () => _i375.BillingFacade(gh<_i354.BillingRepository>()),
    );
    gh.factory<_i224.LibraryBloc>(
      () => _i224.LibraryBloc(
        gh<_i118.ILibraryFacade>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.factory<_i506.DeleteAccountCubit>(
      () => _i506.DeleteAccountCubit(gh<_i865.IAuthFacade>()),
    );
    gh.factory<_i595.ForgotPasswordBloc>(
      () => _i595.ForgotPasswordBloc(gh<_i865.IAuthFacade>()),
    );
    gh.factory<_i441.LoginBloc>(() => _i441.LoginBloc(gh<_i865.IAuthFacade>()));
    gh.factory<_i7.RegisterBloc>(
      () => _i7.RegisterBloc(gh<_i865.IAuthFacade>()),
    );
    gh.lazySingleton<_i1064.IShareFacade>(
      () => _i68.ShareFacade(gh<_i438.ShareRepository>()),
    );
    gh.lazySingleton<_i201.IPushFacade>(
      () => _i32.PushFacade(
        gh<_i1027.MessagingSource>(),
        gh<_i765.PushRepository>(),
      ),
    );
    gh.lazySingleton<_i900.ITranscriptFacade>(
      () => _i39.TranscriptFacade(gh<_i77.TranscriptRepository>()),
    );
    gh.lazySingleton<_i763.ICalendarFacade>(
      () => _i65.CalendarFacade(gh<_i602.CalendarRepository>()),
    );
    gh.factory<_i966.ShareCubit>(
      () => _i966.ShareCubit(gh<_i1064.IShareFacade>()),
    );
    gh.factory<_i207.BalanceCubit>(
      () => _i207.BalanceCubit(gh<_i171.IBillingFacade>()),
    );
    gh.factory<_i992.PlansCubit>(
      () => _i992.PlansCubit(gh<_i171.IBillingFacade>()),
    );
    gh.lazySingleton<_i727.IJobFacade>(
      () => _i367.JobFacade(
        gh<_i730.JobRepository>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.factory<_i698.CalendarCubit>(
      () => _i698.CalendarCubit(gh<_i763.ICalendarFacade>()),
    );
    gh.lazySingleton<_i122.IUploadFacade>(
      () => _i612.UploadFacade(
        gh<_i198.UploadRepository>(),
        gh<_i730.JobRepository>(),
        gh<_i155.MediaPicker>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.factory<_i752.PushCubit>(
      () =>
          _i752.PushCubit(gh<_i201.IPushFacade>(), gh<_i252.LibraryChanges>()),
    );
    gh.factory<_i720.WorkspaceListCubit>(
      () => _i720.WorkspaceListCubit(gh<_i537.IWorkspaceFacade>()),
    );
    gh.factory<_i86.TranscriptCubit>(
      () => _i86.TranscriptCubit(gh<_i900.ITranscriptFacade>()),
    );
    gh.factory<_i331.JobCubit>(
      () => _i331.JobCubit(
        gh<_i727.IJobFacade>(),
        gh<_i669.JobPollPolicy>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.factory<_i322.AccountCubit>(
      () => _i322.AccountCubit(
        gh<_i865.IAuthFacade>(),
        gh<_i252.LibraryChanges>(),
        gh<_i754.SessionManager>(),
        gh<_i201.IPushFacade>(),
        gh<_i537.IWorkspaceFacade>(),
      ),
    );
    gh.factory<_i741.PickFileCubit>(
      () => _i741.PickFileCubit(gh<_i122.IUploadFacade>()),
    );
    gh.factory<_i956.UploadBloc>(
      () => _i956.UploadBloc(gh<_i122.IUploadFacade>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i645.NetworkModule {}

class _$GoogleModule extends _i64.GoogleModule {}

class _$ShareModule extends _i41.ShareModule {}

class _$RecorderModule extends _i540.RecorderModule {}
