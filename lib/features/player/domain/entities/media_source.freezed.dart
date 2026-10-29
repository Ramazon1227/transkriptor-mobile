// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MediaSource {

/// A signed read link for an upload, the canonical download link for
/// a Drive/Dropbox file, the watch URL for YouTube.
 String get url; String get mime;/// Set for YouTube media only: no bytes on our side, and no package
/// here plays YouTube, so there is no in-app playback.
 String? get youtubeId;
/// Create a copy of MediaSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaSourceCopyWith<MediaSource> get copyWith => _$MediaSourceCopyWithImpl<MediaSource>(this as MediaSource, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MediaSource;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaSource&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.mime, _this.mime) || other.mime == _this.mime)&&(identical(other.youtubeId, _this.youtubeId) || other.youtubeId == _this.youtubeId));
}


@override
int get hashCode {
  final _this = this as MediaSource;
  return Object.hash(runtimeType,_this.url,_this.mime,_this.youtubeId);
}

@override
String toString() {
  final _this = this as MediaSource;
  return 'MediaSource(url: ${_this.url}, mime: ${_this.mime}, youtubeId: ${_this.youtubeId})';
}


}

/// @nodoc
abstract mixin class $MediaSourceCopyWith<$Res>  {
  factory $MediaSourceCopyWith(MediaSource value, $Res Function(MediaSource) _then) = _$MediaSourceCopyWithImpl;
@useResult
$Res call({
 String url, String mime, String? youtubeId
});




}
/// @nodoc
class _$MediaSourceCopyWithImpl<$Res>
    implements $MediaSourceCopyWith<$Res> {
  _$MediaSourceCopyWithImpl(this._self, this._then);

  final MediaSource _self;
  final $Res Function(MediaSource) _then;

/// Create a copy of MediaSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? mime = null,Object? youtubeId = freezed,}) {
  return _then(MediaSource(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,mime: null == mime ? _self.mime : mime // ignore: cast_nullable_to_non_nullable
as String,youtubeId: freezed == youtubeId ? _self.youtubeId : youtubeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaSource].
extension MediaSourcePatterns on MediaSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaSource value)  $default,){
final _that = this;
switch (_that) {
case _MediaSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaSource value)?  $default,){
final _that = this;
switch (_that) {
case _MediaSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String mime,  String? youtubeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaSource() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String mime,  String? youtubeId)  $default,) {final _that = this;
switch (_that) {
case _MediaSource():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String mime,  String? youtubeId)?  $default,) {final _that = this;
switch (_that) {
case _MediaSource() when $default != null:
return $default(_that.url,_that.mime,_that.youtubeId);case _:
  return null;

}
}

}

/// @nodoc


class _MediaSource extends MediaSource {
  const _MediaSource({required this.url, this.mime = '', this.youtubeId}): super._();
  

/// A signed read link for an upload, the canonical download link for
/// a Drive/Dropbox file, the watch URL for YouTube.
@override final  String url;
@override@JsonKey() final  String mime;
/// Set for YouTube media only: no bytes on our side, and no package
/// here plays YouTube, so there is no in-app playback.
@override final  String? youtubeId;

/// Create a copy of MediaSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaSourceCopyWith<_MediaSource> get copyWith => __$MediaSourceCopyWithImpl<_MediaSource>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaSource&&(identical(other.url, url) || other.url == url)&&(identical(other.mime, mime) || other.mime == mime)&&(identical(other.youtubeId, youtubeId) || other.youtubeId == youtubeId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,url,mime,youtubeId);
}

@override
String toString() {
    return 'MediaSource(url: $url, mime: $mime, youtubeId: $youtubeId)';
}


}

/// @nodoc
abstract mixin class _$MediaSourceCopyWith<$Res> implements $MediaSourceCopyWith<$Res> {
  factory _$MediaSourceCopyWith(_MediaSource value, $Res Function(_MediaSource) _then) = __$MediaSourceCopyWithImpl;
@override @useResult
$Res call({
 String url, String mime, String? youtubeId
});




}
/// @nodoc
class __$MediaSourceCopyWithImpl<$Res>
    implements _$MediaSourceCopyWith<$Res> {
  __$MediaSourceCopyWithImpl(this._self, this._then);

  final _MediaSource _self;
  final $Res Function(_MediaSource) _then;

/// Create a copy of MediaSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? mime = null,Object? youtubeId = freezed,}) {
  return _then(_MediaSource(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,mime: null == mime ? _self.mime : mime // ignore: cast_nullable_to_non_nullable
as String,youtubeId: freezed == youtubeId ? _self.youtubeId : youtubeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
