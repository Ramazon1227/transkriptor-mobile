import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/core/error/held_file.dart';

part 'held_file_model.freezed.dart';
part 'held_file_model.g.dart';

/// One row of `data.held` in a 409 PENDING_LIMIT (`models.HeldMedia`).
@freezed
abstract class HeldFileModel with _$HeldFileModel {
  const factory HeldFileModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'size_bytes') @Default(0) int sizeBytes,
    @JsonKey(name: 'state') @Default('') String state,
    @JsonKey(name: 'expires_at') String? expiresAt,
    @JsonKey(name: 'deletable') @Default(false) bool deletable,
  }) = _HeldFileModel;

  const HeldFileModel._();

  factory HeldFileModel.fromJson(Map<String, dynamic> json) =>
      _$HeldFileModelFromJson(json);

  HeldFile toEntity() => HeldFile(
    id: id,
    name: name,
    sizeBytes: sizeBytes,
    state: switch (state) {
      'UNCONFIRMED' => HeldFileState.unconfirmed,
      'FAILED' => HeldFileState.failed,
      'CANCELLED' => HeldFileState.cancelled,
      _ => HeldFileState.waiting,
    },
    expiresAt: expiresAt == null ? null : DateTime.tryParse(expiresAt!),
    deletable: deletable,
  );
}
