import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/upload/domain/advanced_rules.dart';

part 'advanced_options.freezed.dart';

/// The choice made in «Qoʻshimcha sozlamalar» (ClickUp A-0…A-4) for one
/// upload. Nothing is kept between uploads: a page starts from
/// [AdvancedOptions.initial] and «Saqlash» applies to that upload only.
/// The names are kept beside the ids so the summary line needs no load.
@freezed
abstract class AdvancedOptions with _$AdvancedOptions {
  const factory AdvancedOptions({
    /// Where the file lands and whose balance pays (A-2).
    required String workspaceId,
    @Default('') String workspaceName,

    /// Null: no folder («Fayllar»).
    String? folderId,
    @Default('') String folderName,

    /// Null is Auto (A-4).
    int? numSpeakers,

    /// An «Atamalar» list of [workspaceId] (A-1); null: none.
    String? glossaryId,
    @Default('') String glossaryName,

    /// Terms for this upload only, one per line, as typed.
    @Default('') String termsText,

    /// Speaker hints by file key (A-3): a hint belongs to one file.
    @Default(<String, List<SpeakerHint>>{})
    Map<String, List<SpeakerHint>> hints,
  }) = _AdvancedOptions;

  const AdvancedOptions._();

  /// The default: the given workspace, no folder, Auto, no terms.
  factory AdvancedOptions.initial({
    required String workspaceId,
    String workspaceName = '',
  }) => AdvancedOptions(workspaceId: workspaceId, workspaceName: workspaceName);

  List<String> get terms => AdvancedRules.parseTerms(termsText);

  int get hintCount => hints.values.fold(0, (n, h) => n + h.length);

  /// What a job of the file [hintKey] sends; a link or a file without
  /// hints gets the shared part only.
  JobOptions jobOptionsFor([String? hintKey]) => JobOptions(
    glossaryId: glossaryId,
    terms: terms,
    speakerHints: hintKey == null
        ? const []
        : AdvancedRules.sorted(hints[hintKey] ?? const []),
  );
}

/// A picked local file the panel can play to mark speakers (A-3). [key]
/// ties its hints to it — the file's path.
@freezed
abstract class HintSource with _$HintSource {
  const factory HintSource({
    required String key,
    required String name,
    required String path,
  }) = _HintSource;
}
