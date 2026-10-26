import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_pair.freezed.dart';
part 'token_pair.g.dart';

/// `data` of `POST /api/v1/auth/refresh`.
@freezed
abstract class TokenPair with _$TokenPair {
  const factory TokenPair({
    @JsonKey(name: 'access_token') @Default('') String accessToken,
    @JsonKey(name: 'refresh_token') @Default('') String refreshToken,
    @JsonKey(name: 'expires_in') int? expiresIn,
  }) = _TokenPair;

  factory TokenPair.fromJson(Map<String, dynamic> json) =>
      _$TokenPairFromJson(json);
}
