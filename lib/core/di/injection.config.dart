// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:record/record.dart' as _i1039;
import 'package:transkriptor_uz/core/di/network_module.dart' as _i644;
import 'package:transkriptor_uz/core/events/library_changes.dart' as _i252;
import 'package:transkriptor_uz/core/network/session_manager.dart' as _i754;
import 'package:transkriptor_uz/core/network/token_interceptor.dart' as _i60;
import 'package:transkriptor_uz/core/router/app_router.dart' as _i1008;
import 'package:transkriptor_uz/core/storage/token_storage.dart' as _i933;
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart'
    as _i322;
import 'package:transkriptor_uz/features/auth/application/login_bloc.dart'
    as _i441;
import 'package:transkriptor_uz/features/auth/application/register_bloc.dart'
    as _i7;
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart'
    as _i865;
import 'package:transkriptor_uz/features/auth/infrastructure/facades/auth_facade.dart'
    as _i1041;
import 'package:transkriptor_uz/features/auth/infrastructure/repositories/auth_repository.dart'
    as _i838;
import 'package:transkriptor_uz/features/job/application/job_cubit.dart'
    as _i331;
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart'
    as _i669;
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart' as _i727;
import 'package:transkriptor_uz/features/job/infrastructure/facades/job_facade.dart'
    as _i367;
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart'
    as _i730;
import 'package:transkriptor_uz/features/library/application/library_bloc.dart'
    as _i224;
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart'
    as _i118;
import 'package:transkriptor_uz/features/library/infrastructure/facades/library_facade.dart'
    as _i985;
import 'package:transkriptor_uz/features/library/infrastructure/repositories/library_repository.dart'
    as _i203;
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart'
    as _i206;
import 'package:transkriptor_uz/features/recorder/domain/i_recorder_facade.dart'
    as _i239;
import 'package:transkriptor_uz/features/recorder/infrastructure/facades/recorder_facade.dart'
    as _i293;
import 'package:transkriptor_uz/features/recorder/infrastructure/recorder_module.dart'
    as _i540;
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart'
    as _i86;
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart'
    as _i899;
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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    final recorderModule = _$RecorderModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => networkModule.secureStorage,
    );
    gh.lazySingleton<_i252.LibraryChanges>(
      () => _i252.LibraryChanges(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i754.SessionManager>(() => _i754.SessionManager());
    gh.lazySingleton<_i669.JobPollPolicy>(() => _i669.JobPollPolicy());
    gh.lazySingleton<_i1039.AudioRecorder>(() => recorderModule.audioRecorder);
    gh.lazySingleton<_i155.MediaPicker>(() => _i155.MediaPicker());
    gh.lazySingleton<_i1008.AppRouter>(
      () => _i1008.AppRouter(gh<_i754.SessionManager>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.retryDio(),
      instanceName: 'retryDio',
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
      () => _i293.RecorderFacade(gh<_i1039.AudioRecorder>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i60.TokenInterceptor>()),
    );
    gh.lazySingleton<_i838.AuthRepository>(
      () => _i838.AuthRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i730.JobRepository>(
      () => _i730.JobRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i203.LibraryRepository>(
      () => _i203.LibraryRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i77.TranscriptRepository>(
      () => _i77.TranscriptRepository(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i118.ILibraryFacade>(
      () => _i985.LibraryFacade(gh<_i203.LibraryRepository>()),
    );
    gh.factory<_i206.RecorderCubit>(
      () => _i206.RecorderCubit(gh<_i239.IRecorderFacade>()),
    );
    gh.lazySingleton<_i198.UploadRepository>(
      () => _i198.UploadRepository(
        gh<_i361.Dio>(),
        gh<_i361.Dio>(instanceName: 'uploadDio'),
      ),
    );
    gh.lazySingleton<_i865.IAuthFacade>(
      () => _i1041.AuthFacade(
        gh<_i838.AuthRepository>(),
        gh<_i933.TokenStorage>(),
        gh<_i754.SessionManager>(),
      ),
    );
    gh.factory<_i322.AccountCubit>(
      () => _i322.AccountCubit(
        gh<_i865.IAuthFacade>(),
        gh<_i252.LibraryChanges>(),
        gh<_i754.SessionManager>(),
      ),
    );
    gh.factory<_i224.LibraryBloc>(
      () => _i224.LibraryBloc(
        gh<_i118.ILibraryFacade>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.factory<_i441.LoginBloc>(() => _i441.LoginBloc(gh<_i865.IAuthFacade>()));
    gh.factory<_i7.RegisterBloc>(
      () => _i7.RegisterBloc(gh<_i865.IAuthFacade>()),
    );
    gh.lazySingleton<_i899.ITranscriptFacade>(
      () => _i39.TranscriptFacade(gh<_i77.TranscriptRepository>()),
    );
    gh.lazySingleton<_i727.IJobFacade>(
      () => _i367.JobFacade(
        gh<_i730.JobRepository>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.lazySingleton<_i122.IUploadFacade>(
      () => _i612.UploadFacade(
        gh<_i198.UploadRepository>(),
        gh<_i730.JobRepository>(),
        gh<_i155.MediaPicker>(),
        gh<_i252.LibraryChanges>(),
      ),
    );
    gh.factory<_i86.TranscriptCubit>(
      () => _i86.TranscriptCubit(gh<_i899.ITranscriptFacade>()),
    );
    gh.factory<_i331.JobCubit>(
      () => _i331.JobCubit(
        gh<_i727.IJobFacade>(),
        gh<_i669.JobPollPolicy>(),
        gh<_i252.LibraryChanges>(),
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

class _$NetworkModule extends _i644.NetworkModule {}

class _$RecorderModule extends _i540.RecorderModule {}
