import 'package:freezed_annotation/freezed_annotation.dart';

part 'glossary.freezed.dart';

/// One «Atamalar» list of a workspace. Mobile only reads them, to pick one
/// for an upload (ClickUp A-1); they are made and edited on the web.
@freezed
abstract class Glossary with _$Glossary {
  const factory Glossary({
    required String id,
    required String name,
    @Default(0) int termCount,
  }) = _Glossary;
}
