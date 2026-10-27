// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_link_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShareLinkModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'expires_at') DateTime? get expiresAt;@JsonKey(name: 'view_count') int get viewCount;@JsonKey(name: 'include_media') bool get includeMedia;@JsonKey(name: 'url') String? get url;
/// Create a copy of ShareLinkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareLinkModelCopyWith<ShareLinkModel> get copyWith => _$ShareLinkModelCopyWithImpl<ShareLinkModel>(this as ShareLinkModel, _$identity);

  /// Serializes this ShareLinkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ShareLinkModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareLinkModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.viewCount, _this.viewCount) || other.viewCount == _this.viewCount)&&(identical(other.includeMedia, _this.includeMedia) || other.includeMedia == _this.includeMedia)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ShareLinkModel;
  return Object.hash(runtimeType,_this.id,_this.createdAt,_this.expiresAt,_this.viewCount,_this.includeMedia,_this.url);
}

@override
String toString() {
  final _this = this as ShareLinkModel;
  return 'ShareLinkModel(id: ${_this.id}, createdAt: ${_this.createdAt}, expiresAt: ${_this.expiresAt}, viewCount: ${_this.viewCount}, includeMedia: ${_this.includeMedia}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $ShareLinkModelCopyWith<$Res>  {
  factory $ShareLinkModelCopyWith(ShareLinkModel value, $Res Function(ShareLinkModel) _then) = _$ShareLinkModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'expires_at') DateTime? expiresAt,@JsonKey(name: 'view_count') int viewCount,@JsonKey(name: 'include_media') bool includeMedia,@JsonKey(name: 'url') String? url
});




}
/// @nodoc
class _$ShareLinkModelCopyWithImpl<$Res>
    implements $ShareLinkModelCopyWith<$Res> {
  _$ShareLinkModelCopyWithImpl(this._self, this._then);

  final ShareLinkModel _self;
  final $Res Function(ShareLinkModel) _then;

/// Create a copy of ShareLinkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = freezed,Object? expiresAt = freezed,Object? viewCount = null,Object? includeMedia = null,Object? url = freezed,}) {
  return _then(ShareLinkModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,includeMedia: null == includeMedia ? _self.includeMedia : includeMedia // ignore: cast_nullable_to_non_nullable
as bool,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShareLinkModel].
extension ShareLinkModelPatterns on ShareLinkModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareLinkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareLinkModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareLinkModel value)  $default,){
final _that = this;
switch (_that) {
case _ShareLinkModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareLinkModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShareLinkModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'view_count')  int viewCount, @JsonKey(name: 'include_media')  bool includeMedia, @JsonKey(name: 'url')  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareLinkModel() when $default != null:
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.viewCount,_that.includeMedia,_that.url);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'view_count')  int viewCount, @JsonKey(name: 'include_media')  bool includeMedia, @JsonKey(name: 'url')  String? url)  $default,) {final _that = this;
switch (_that) {
case _ShareLinkModel():
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.viewCount,_that.includeMedia,_that.url);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'view_count')  int viewCount, @JsonKey(name: 'include_media')  bool includeMedia, @JsonKey(name: 'url')  String? url)?  $default,) {final _that = this;
switch (_that) {
case _ShareLinkModel() when $default != null:
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.viewCount,_that.includeMedia,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShareLinkModel extends ShareLinkModel {
  const _ShareLinkModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'expires_at') this.expiresAt, @JsonKey(name: 'view_count') this.viewCount = 0, @JsonKey(name: 'include_media') this.includeMedia = false, @JsonKey(name: 'url') this.url}): super._();
  factory _ShareLinkModel.fromJson(Map<String, dynamic> json) => _$ShareLinkModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'expires_at') final  DateTime? expiresAt;
@override@JsonKey(name: 'view_count') final  int viewCount;
@override@JsonKey(name: 'include_media') final  bool includeMedia;
@override@JsonKey(name: 'url') final  String? url;

/// Create a copy of ShareLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareLinkModelCopyWith<_ShareLinkModel> get copyWith => __$ShareLinkModelCopyWithImpl<_ShareLinkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShareLinkModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareLinkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.includeMedia, includeMedia) || other.includeMedia == includeMedia)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,expiresAt,viewCount,includeMedia,url);
}

@override
String toString() {
    return 'ShareLinkModel(id: $id, createdAt: $createdAt, expiresAt: $expiresAt, viewCount: $viewCount, includeMedia: $includeMedia, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ShareLinkModelCopyWith<$Res> implements $ShareLinkModelCopyWith<$Res> {
  factory _$ShareLinkModelCopyWith(_ShareLinkModel value, $Res Function(_ShareLinkModel) _then) = __$ShareLinkModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'expires_at') DateTime? expiresAt,@JsonKey(name: 'view_count') int viewCount,@JsonKey(name: 'include_media') bool includeMedia,@JsonKey(name: 'url') String? url
});




}
/// @nodoc
class __$ShareLinkModelCopyWithImpl<$Res>
    implements _$ShareLinkModelCopyWith<$Res> {
  __$ShareLinkModelCopyWithImpl(this._self, this._then);

  final _ShareLinkModel _self;
  final $Res Function(_ShareLinkModel) _then;

/// Create a copy of ShareLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = freezed,Object? expiresAt = freezed,Object? viewCount = null,Object? includeMedia = null,Object? url = freezed,}) {
  return _then(_ShareLinkModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,includeMedia: null == includeMedia ? _self.includeMedia : includeMedia // ignore: cast_nullable_to_non_nullable
as bool,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
