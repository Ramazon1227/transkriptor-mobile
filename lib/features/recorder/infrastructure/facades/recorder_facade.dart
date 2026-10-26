import 'dart:io';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/i_recorder_facade.dart';

/// AAC-LC in .m4a, 16 kHz mono: what the STT service resamples to anyway,
/// so higher rates only make the upload bigger. The backend accepts m4a.
const _config = RecordConfig(sampleRate: 16000, numChannels: 1, bitRate: 48000);

/// The meter treats this as silence; speech sits roughly at -30..-10 dBFS.
const double _floorDb = -50;

@LazySingleton(as: IRecorderFacade)
class RecorderFacade implements IRecorderFacade {
  RecorderFacade(this._recorder);

  final AudioRecorder _recorder;

  @override
  Future<Either<Failure, Unit>> start() async {
    try {
      if (!await _recorder.hasPermission()) {
        return const Left(Failure.permissionDenied());
      }
      // Documents, not temp: the file must survive until it is uploaded.
      final dir = Directory(
        '${(await getApplicationDocumentsDirectory()).path}/recordings',
      );
      await dir.create(recursive: true);
      final name = 'rec_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(_config, path: '${dir.path}/$name');
      return const Right(unit);
    } on Object {
      return const Left(Failure.storage());
    }
  }

  @override
  Future<Either<Failure, Unit>> pause() => _guard(_recorder.pause);

  @override
  Future<Either<Failure, Unit>> resume() => _guard(_recorder.resume);

  @override
  Future<Either<Failure, Recording>> stop({required Duration duration}) async {
    try {
      final path = await _recorder.stop();
      if (path == null) return const Left(Failure.storage());
      final file = File(path);
      final size = await file.length();
      if (size <= 0) return const Left(Failure.storage());
      return Right(Recording(path: path, sizeBytes: size, duration: duration));
    } on Object {
      return const Left(Failure.storage());
    }
  }

  @override
  Future<void> discard() async {
    try {
      // cancel() stops and deletes the file.
      await _recorder.cancel();
    } on Object {
      // Nothing to keep and nothing to report.
    }
  }

  @override
  Stream<double> levels() => _recorder
      .onAmplitudeChanged(const Duration(milliseconds: 120))
      .map((a) => ((a.current - _floorDb) / -_floorDb).clamp(0.0, 1.0));

  Future<Either<Failure, Unit>> _guard(Future<void> Function() call) async {
    try {
      await call();
      return const Right(unit);
    } on Object {
      return const Left(Failure.unknown());
    }
  }
}
