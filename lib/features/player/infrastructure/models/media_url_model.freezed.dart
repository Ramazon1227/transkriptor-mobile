// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_url_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaUrlModel {

@JsonKey(name: 'url') String get url;@JsonKey(name: 'mime') String get mime;@JsonKey(name: 'youtube_id') String? get youtubeId;
/// Create a copy of MediaUrlModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaUrlModelCopyWith<MediaUrlModel> get copyWith => _$MediaUrlModelCopyWithImpl<MediaUrlModel>(this as MediaUrlModel, _$identity);

  /// Serializes this MediaUrlModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MediaUrlModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaUrlModel&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.mime, _this.mime) || other.mime == _this.mime)&&(identical(other.youtubeId, _this.youtubeId) || other.youtubeId == _this.youtubeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MediaUrlModel;
  return Object.hash(runtimeType,_this.url,_this.mime,_this.youtubeId);
}

@override
String toString() {
  final _this = this as MediaUrlModel;
  return 'MediaUrlModel(url: ${_this.url}, mime: ${_this.mime}, youtubeId: ${_this.youtubeId})';
}


}

/// @nodoc
abstract mixin class $MediaUrlModelCopyWith<$Res>  {
  factory $MediaUrlModelCopyWith(MediaUrlModel value, $Res Function(MediaUrlModel) _then) = _$MediaUrlModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'url') String url,@JsonKey(name: 'mime') String mime,@JsonKey(name: 'youtube_id') String? youtubeId
});




}
/// @nodoc
class _$MediaUrlModelCopyWithImpl<$Res>
    implements $MediaUrlModelCopyWith<$Res> {
  _$MediaUrlModelCopyWithImpl(this._self, this._then);

  final MediaUrlModel _self;
  final $Res Function(MediaUrlModel) _then;

/// Create a copy of MediaUrlModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? mime = null,Object? youtubeId = freezed,}) {
  return _then(MediaUrlModel(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,mime: null == mime ? _self.mime : mime // ignore: cast_nullable_to_non_nullable
as String,youtubeId: freezed == youtubeId ? _self.youtubeId : youtubeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaUrlModel].
extension MediaUrlModelPatterns on MediaUrlModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaUrlModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaUrlModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaUrlModel value)  $default,){
final _that = this;
switch (_that) {
case _MediaUrlModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaUrlModel value)?  $default,){
final _that = this;
switch (_that) {
case _MediaUrlModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'url')  String url, @JsonKey(name: 'mime')  String mime, @JsonKey(name: 'youtube_id')  String? youtubeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaUrlModel() when $default != null:
return $default(_that.url,_that.mime,_that.youtubeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'url')  String url, @JsonKey(name: 'mime')  String mime, @JsonKey(name: 'youtube_id')  String? youtubeId)  $default,) {final _that = this;
switch (_that) {
case _MediaUrlModel():
return $default(_that.url,_that.mime,_that.youtubeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'url')  String url, @JsonKey(name: 'mime')  String mime, @JsonKey(name: 'youtube_id')  String? youtubeId)?  $default,) {final _that = this;
switch (_that) {
case _MediaUrlModel() when $default != null:
return $default(_that.url,_that.mime,_that.youtubeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaUrlModel extends MediaUrlModel {
  const _MediaUrlModel({@JsonKey(name: 'url') this.url = '', @JsonKey(name: 'mime') this.mime = '', @JsonKey(name: 'youtube_id') this.youtubeId}): super._();
  factory _MediaUrlModel.fromJson(Map<String, dynamic> json) => _$MediaUrlModelFromJson(json);

@override@JsonKey(name: 'url') final  String url;
@override@JsonKey(name: 'mime') final  String mime;
@override@JsonKey(name: 'youtube_id') final  String? youtubeId;

/// Create a copy of MediaUrlModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaUrlModelCopyWith<_MediaUrlModel> get copyWith => __$MediaUrlModelCopyWithImpl<_MediaUrlModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaUrlModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaUrlModel&&(identical(other.url, url) || other.url == url)&&(identical(other.mime, mime) || other.mime == mime)&&(identical(other.youtubeId, youtubeId) || other.youtubeId == youtubeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,url,mime,youtubeId);
}

@override
String toString() {
    return 'MediaUrlModel(url: $url, mime: $mime, youtubeId: $youtubeId)';
}


}

/// @nodoc
abstract mixin class _$MediaUrlModelCopyWith<$Res> implements $MediaUrlModelCopyWith<$Res> {
  factory _$MediaUrlModelCopyWith(_MediaUrlModel value, $Res Function(_MediaUrlModel) _then) = __$MediaUrlModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'url') String url,@JsonKey(name: 'mime') String mime,@JsonKey(name: 'youtube_id') String? youtubeId
});




}
/// @nodoc
class __$MediaUrlModelCopyWithImpl<$Res>
    implements _$MediaUrlModelCopyWith<$Res> {
  __$MediaUrlModelCopyWithImpl(this._self, this._then);

  final _MediaUrlModel _self;
  final $Res Function(_MediaUrlModel) _then;

/// Create a copy of MediaUrlModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? mime = null,Object? youtubeId = freezed,}) {
  return _then(_MediaUrlModel(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,mime: null == mime ? _self.mime : mime // ignore: cast_nullable_to_non_nullable
as String,youtubeId: freezed == youtubeId ? _self.youtubeId : youtubeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
