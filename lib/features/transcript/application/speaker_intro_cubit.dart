import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_speaker_intro_facade.dart';
import 'package:transkriptor_uz/features/transcript/domain/speaker_intro.dart';

part 'speaker_intro_cubit.freezed.dart';

@freezed
abstract class SpeakerIntroState with _$SpeakerIntroState {
  const factory SpeakerIntroState({
    /// The page opens the sheet when this turns true.
    @Default(false) bool due,

    /// «Ochilganda maʼruzachilarni soʻramaslik».
    @Default(false) bool off,
  }) = _SpeakerIntroState;
}

/// Whether to ask for names when a transcript opens, and the switch that
/// silences it.
@injectable
class SpeakerIntroCubit extends Cubit<SpeakerIntroState> {
  SpeakerIntroCubit(this._facade) : super(const SpeakerIntroState());

  final ISpeakerIntroFacade _facade;

  Future<void> check(Transcript transcript) async {
    if (!SpeakerIntro.applies(transcript)) return;
    final due = await _facade.isDue(transcript.id);
    final off = await _facade.isOff();
    if (!isClosed) emit(state.copyWith(due: due, off: off));
  }

  /// However the sheet closed: it does not come back for this transcript.
  Future<void> closed(String transcriptId) async {
    emit(state.copyWith(due: false));
    await _facade.markSeen(transcriptId);
  }

  Future<void> loadOff() async {
    final off = await _facade.isOff();
    if (!isClosed) emit(state.copyWith(off: off));
  }

  Future<void> setOff({required bool off}) async {
    emit(state.copyWith(off: off));
    await _facade.setOff(off: off);
  }
}
