import 'package:freezed_annotation/freezed_annotation.dart';

part 'dictation_event.freezed.dart';

/// What a live dictation source reports while the person speaks.
@freezed
sealed class DictationEvent with _$DictationEvent {
  /// The sentence being heard; it may still change. Replaces the previous
  /// partial.
  const factory DictationEvent.partial(String text) = DictationPartial;

  /// A settled sentence; the partial is cleared.
  const factory DictationEvent.finalText(String text) = DictationFinal;
}
