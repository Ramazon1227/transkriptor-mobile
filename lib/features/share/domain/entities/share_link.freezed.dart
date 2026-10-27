// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShareLink {

 String get id; DateTime? get createdAt;/// Null: the link never expires.
 DateTime? get expiresAt; int get viewCount; bool get includeMedia;/// `PUBLIC_APP_URL/s/<token>`. Only on the link just created: the
/// server keeps a hash of the token and never shows it again.
 String? get url;
/// Create a copy of ShareLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareLinkCopyWith<ShareLink> get copyWith => _$ShareLinkCopyWithImpl<ShareLink>(this as ShareLink, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ShareLink;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareLink&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.viewCount, _this.viewCount) || other.viewCount == _this.viewCount)&&(identical(other.includeMedia, _this.includeMedia) || other.includeMedia == _this.includeMedia)&&(identical(other.url, _this.url) || other.url == _this.url));
}


@override
int get hashCode {
  final _this = this as ShareLink;
  return Object.hash(runtimeType,_this.id,_this.createdAt,_this.expiresAt,_this.viewCount,_this.includeMedia,_this.url);
}

@override
String toString() {
  final _this = this as ShareLink;
  return 'ShareLink(id: ${_this.id}, createdAt: ${_this.createdAt}, expiresAt: ${_this.expiresAt}, viewCount: ${_this.viewCount}, includeMedia: ${_this.includeMedia}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $ShareLinkCopyWith<$Res>  {
  factory $ShareLinkCopyWith(ShareLink value, $Res Function(ShareLink) _then) = _$ShareLinkCopyWithImpl;
@useResult
$Res call({
 String id, DateTime? createdAt, DateTime? expiresAt, int viewCount, bool includeMedia, String? url
});




}
/// @nodoc
class _$ShareLinkCopyWithImpl<$Res>
    implements $ShareLinkCopyWith<$Res> {
  _$ShareLinkCopyWithImpl(this._self, this._then);

  final ShareLink _self;
  final $Res Function(ShareLink) _then;

/// Create a copy of ShareLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = freezed,Object? expiresAt = freezed,Object? viewCount = null,Object? includeMedia = null,Object? url = freezed,}) {
  return _then(ShareLink(
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


/// Adds pattern-matching-related methods to [ShareLink].
extension ShareLinkPatterns on ShareLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareLink value)  $default,){
final _that = this;
switch (_that) {
case _ShareLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareLink value)?  $default,){
final _that = this;
switch (_that) {
case _ShareLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime? createdAt,  DateTime? expiresAt,  int viewCount,  bool includeMedia,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareLink() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime? createdAt,  DateTime? expiresAt,  int viewCount,  bool includeMedia,  String? url)  $default,) {final _that = this;
switch (_that) {
case _ShareLink():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime? createdAt,  DateTime? expiresAt,  int viewCount,  bool includeMedia,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _ShareLink() when $default != null:
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.viewCount,_that.includeMedia,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _ShareLink implements ShareLink {
  const _ShareLink({required this.id, this.createdAt, this.expiresAt, this.viewCount = 0, this.includeMedia = false, this.url});
  

@override final  String id;
@override final  DateTime? createdAt;
/// Null: the link never expires.
@override final  DateTime? expiresAt;
@override@JsonKey() final  int viewCount;
@override@JsonKey() final  bool includeMedia;
/// `PUBLIC_APP_URL/s/<token>`. Only on the link just created: the
/// server keeps a hash of the token and never shows it again.
@override final  String? url;

/// Create a copy of ShareLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareLinkCopyWith<_ShareLink> get copyWith => __$ShareLinkCopyWithImpl<_ShareLink>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareLink&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.includeMedia, includeMedia) || other.includeMedia == includeMedia)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,expiresAt,viewCount,includeMedia,url);
}

@override
String toString() {
    return 'ShareLink(id: $id, createdAt: $createdAt, expiresAt: $expiresAt, viewCount: $viewCount, includeMedia: $includeMedia, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ShareLinkCopyWith<$Res> implements $ShareLinkCopyWith<$Res> {
  factory _$ShareLinkCopyWith(_ShareLink value, $Res Function(_ShareLink) _then) = __$ShareLinkCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime? createdAt, DateTime? expiresAt, int viewCount, bool includeMedia, String? url
});




}
/// @nodoc
class __$ShareLinkCopyWithImpl<$Res>
    implements _$ShareLinkCopyWith<$Res> {
  __$ShareLinkCopyWithImpl(this._self, this._then);

  final _ShareLink _self;
  final $Res Function(_ShareLink) _then;

/// Create a copy of ShareLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = freezed,Object? expiresAt = freezed,Object? viewCount = null,Object? includeMedia = null,Object? url = freezed,}) {
  return _then(_ShareLink(
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
