// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playable_media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayableMedia {

/// A signed read link for an upload, the canonical download link for
/// a Drive/Dropbox file, the watch URL for YouTube.
 String get url; String get mime;/// Set for YouTube media only: no bytes on our side, and no package
/// here plays YouTube, so there is no in-app playback.
 String? get youtubeId;
/// Create a copy of PlayableMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayableMediaCopyWith<PlayableMedia> get copyWith => _$PlayableMediaCopyWithImpl<PlayableMedia>(this as PlayableMedia, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlayableMedia;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayableMedia&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.mime, _this.mime) || other.mime == _this.mime)&&(identical(other.youtubeId, _this.youtubeId) || other.youtubeId == _this.youtubeId));
}


@override
int get hashCode {
  final _this = this as PlayableMedia;
  return Object.hash(runtimeType,_this.url,_this.mime,_this.youtubeId);
}

@override
String toString() {
  final _this = this as PlayableMedia;
  return 'PlayableMedia(url: ${_this.url}, mime: ${_this.mime}, youtubeId: ${_this.youtubeId})';
}


}

/// @nodoc
abstract mixin class $PlayableMediaCopyWith<$Res>  {
  factory $PlayableMediaCopyWith(PlayableMedia value, $Res Function(PlayableMedia) _then) = _$PlayableMediaCopyWithImpl;
@useResult
$Res call({
 String url, String mime, String? youtubeId
});




}
/// @nodoc
class _$PlayableMediaCopyWithImpl<$Res>
    implements $PlayableMediaCopyWith<$Res> {
  _$PlayableMediaCopyWithImpl(this._self, this._then);

  final PlayableMedia _self;
  final $Res Function(PlayableMedia) _then;

/// Create a copy of PlayableMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? mime = null,Object? youtubeId = freezed,}) {
  return _then(PlayableMedia(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,mime: null == mime ? _self.mime : mime // ignore: cast_nullable_to_non_nullable
as String,youtubeId: freezed == youtubeId ? _self.youtubeId : youtubeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayableMedia].
extension PlayableMediaPatterns on PlayableMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayableMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayableMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayableMedia value)  $default,){
final _that = this;
switch (_that) {
case _PlayableMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayableMedia value)?  $default,){
final _that = this;
switch (_that) {
case _PlayableMedia() when $default != null:
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
case _PlayableMedia() when $default != null:
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
case _PlayableMedia():
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
case _PlayableMedia() when $default != null:
return $default(_that.url,_that.mime,_that.youtubeId);case _:
  return null;

}
}

}

/// @nodoc


class _PlayableMedia extends PlayableMedia {
  const _PlayableMedia({required this.url, this.mime = '', this.youtubeId}): super._();
  

/// A signed read link for an upload, the canonical download link for
/// a Drive/Dropbox file, the watch URL for YouTube.
@override final  String url;
@override@JsonKey() final  String mime;
/// Set for YouTube media only: no bytes on our side, and no package
/// here plays YouTube, so there is no in-app playback.
@override final  String? youtubeId;

/// Create a copy of PlayableMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayableMediaCopyWith<_PlayableMedia> get copyWith => __$PlayableMediaCopyWithImpl<_PlayableMedia>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayableMedia&&(identical(other.url, url) || other.url == url)&&(identical(other.mime, mime) || other.mime == mime)&&(identical(other.youtubeId, youtubeId) || other.youtubeId == youtubeId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,url,mime,youtubeId);
}

@override
String toString() {
    return 'PlayableMedia(url: $url, mime: $mime, youtubeId: $youtubeId)';
}


}

/// @nodoc
abstract mixin class _$PlayableMediaCopyWith<$Res> implements $PlayableMediaCopyWith<$Res> {
  factory _$PlayableMediaCopyWith(_PlayableMedia value, $Res Function(_PlayableMedia) _then) = __$PlayableMediaCopyWithImpl;
@override @useResult
$Res call({
 String url, String mime, String? youtubeId
});




}
/// @nodoc
class __$PlayableMediaCopyWithImpl<$Res>
    implements _$PlayableMediaCopyWith<$Res> {
  __$PlayableMediaCopyWithImpl(this._self, this._then);

  final _PlayableMedia _self;
  final $Res Function(_PlayableMedia) _then;

/// Create a copy of PlayableMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? mime = null,Object? youtubeId = freezed,}) {
  return _then(_PlayableMedia(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,mime: null == mime ? _self.mime : mime // ignore: cast_nullable_to_non_nullable
as String,youtubeId: freezed == youtubeId ? _self.youtubeId : youtubeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
