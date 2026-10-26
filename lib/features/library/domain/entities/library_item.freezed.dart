// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LibraryItem {

 String get mediaId; String get name; DateTime? get createdAt; Duration? get duration; MediaKind get kind; MediaSource get source;/// YOUTUBE, GDRIVE or DROPBOX for a link; null otherwise.
 String? get linkProvider; String? get jobId;/// Null when the file was saved without starting transcription.
 JobStatus? get jobStatus; String? get transcriptId; List<String> get tags;
/// Create a copy of LibraryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryItemCopyWith<LibraryItem> get copyWith => _$LibraryItemCopyWithImpl<LibraryItem>(this as LibraryItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LibraryItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryItem&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.linkProvider, _this.linkProvider) || other.linkProvider == _this.linkProvider)&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.jobStatus, _this.jobStatus) || other.jobStatus == _this.jobStatus)&&(identical(other.transcriptId, _this.transcriptId) || other.transcriptId == _this.transcriptId)&&const DeepCollectionEquality().equals(other.tags, _this.tags));
}


@override
int get hashCode {
  final _this = this as LibraryItem;
  return Object.hash(runtimeType,_this.mediaId,_this.name,_this.createdAt,_this.duration,_this.kind,_this.source,_this.linkProvider,_this.jobId,_this.jobStatus,_this.transcriptId,const DeepCollectionEquality().hash(_this.tags));
}

@override
String toString() {
  final _this = this as LibraryItem;
  return 'LibraryItem(mediaId: ${_this.mediaId}, name: ${_this.name}, createdAt: ${_this.createdAt}, duration: ${_this.duration}, kind: ${_this.kind}, source: ${_this.source}, linkProvider: ${_this.linkProvider}, jobId: ${_this.jobId}, jobStatus: ${_this.jobStatus}, transcriptId: ${_this.transcriptId}, tags: ${_this.tags})';
}


}

/// @nodoc
abstract mixin class $LibraryItemCopyWith<$Res>  {
  factory $LibraryItemCopyWith(LibraryItem value, $Res Function(LibraryItem) _then) = _$LibraryItemCopyWithImpl;
@useResult
$Res call({
 String mediaId, String name, DateTime? createdAt, Duration? duration, MediaKind kind, MediaSource source, String? linkProvider, String? jobId, JobStatus? jobStatus, String? transcriptId, List<String> tags
});




}
/// @nodoc
class _$LibraryItemCopyWithImpl<$Res>
    implements $LibraryItemCopyWith<$Res> {
  _$LibraryItemCopyWithImpl(this._self, this._then);

  final LibraryItem _self;
  final $Res Function(LibraryItem) _then;

/// Create a copy of LibraryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaId = null,Object? name = null,Object? createdAt = freezed,Object? duration = freezed,Object? kind = null,Object? source = null,Object? linkProvider = freezed,Object? jobId = freezed,Object? jobStatus = freezed,Object? transcriptId = freezed,Object? tags = null,}) {
  return _then(LibraryItem(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MediaKind,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as MediaSource,linkProvider: freezed == linkProvider ? _self.linkProvider : linkProvider // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,jobStatus: freezed == jobStatus ? _self.jobStatus : jobStatus // ignore: cast_nullable_to_non_nullable
as JobStatus?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [LibraryItem].
extension LibraryItemPatterns on LibraryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryItem value)  $default,){
final _that = this;
switch (_that) {
case _LibraryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryItem value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mediaId,  String name,  DateTime? createdAt,  Duration? duration,  MediaKind kind,  MediaSource source,  String? linkProvider,  String? jobId,  JobStatus? jobStatus,  String? transcriptId,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryItem() when $default != null:
return $default(_that.mediaId,_that.name,_that.createdAt,_that.duration,_that.kind,_that.source,_that.linkProvider,_that.jobId,_that.jobStatus,_that.transcriptId,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mediaId,  String name,  DateTime? createdAt,  Duration? duration,  MediaKind kind,  MediaSource source,  String? linkProvider,  String? jobId,  JobStatus? jobStatus,  String? transcriptId,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _LibraryItem():
return $default(_that.mediaId,_that.name,_that.createdAt,_that.duration,_that.kind,_that.source,_that.linkProvider,_that.jobId,_that.jobStatus,_that.transcriptId,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mediaId,  String name,  DateTime? createdAt,  Duration? duration,  MediaKind kind,  MediaSource source,  String? linkProvider,  String? jobId,  JobStatus? jobStatus,  String? transcriptId,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _LibraryItem() when $default != null:
return $default(_that.mediaId,_that.name,_that.createdAt,_that.duration,_that.kind,_that.source,_that.linkProvider,_that.jobId,_that.jobStatus,_that.transcriptId,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _LibraryItem implements LibraryItem {
  const _LibraryItem({required this.mediaId, required this.name, this.createdAt, this.duration, this.kind = MediaKind.unknown, this.source = MediaSource.unknown, this.linkProvider, this.jobId, this.jobStatus, this.transcriptId,  List<String> tags = const <String>[]}): _tags = tags;
  

@override final  String mediaId;
@override final  String name;
@override final  DateTime? createdAt;
@override final  Duration? duration;
@override@JsonKey() final  MediaKind kind;
@override@JsonKey() final  MediaSource source;
/// YOUTUBE, GDRIVE or DROPBOX for a link; null otherwise.
@override final  String? linkProvider;
@override final  String? jobId;
/// Null when the file was saved without starting transcription.
@override final  JobStatus? jobStatus;
@override final  String? transcriptId;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of LibraryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryItemCopyWith<_LibraryItem> get copyWith => __$LibraryItemCopyWithImpl<_LibraryItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryItem&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.source, source) || other.source == source)&&(identical(other.linkProvider, linkProvider) || other.linkProvider == linkProvider)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.jobStatus, jobStatus) || other.jobStatus == jobStatus)&&(identical(other.transcriptId, transcriptId) || other.transcriptId == transcriptId)&&const DeepCollectionEquality().equals(other.tags, _tags));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mediaId,name,createdAt,duration,kind,source,linkProvider,jobId,jobStatus,transcriptId,const DeepCollectionEquality().hash(_tags));
}

@override
String toString() {
    return 'LibraryItem(mediaId: $mediaId, name: $name, createdAt: $createdAt, duration: $duration, kind: $kind, source: $source, linkProvider: $linkProvider, jobId: $jobId, jobStatus: $jobStatus, transcriptId: $transcriptId, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$LibraryItemCopyWith<$Res> implements $LibraryItemCopyWith<$Res> {
  factory _$LibraryItemCopyWith(_LibraryItem value, $Res Function(_LibraryItem) _then) = __$LibraryItemCopyWithImpl;
@override @useResult
$Res call({
 String mediaId, String name, DateTime? createdAt, Duration? duration, MediaKind kind, MediaSource source, String? linkProvider, String? jobId, JobStatus? jobStatus, String? transcriptId, List<String> tags
});




}
/// @nodoc
class __$LibraryItemCopyWithImpl<$Res>
    implements _$LibraryItemCopyWith<$Res> {
  __$LibraryItemCopyWithImpl(this._self, this._then);

  final _LibraryItem _self;
  final $Res Function(_LibraryItem) _then;

/// Create a copy of LibraryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaId = null,Object? name = null,Object? createdAt = freezed,Object? duration = freezed,Object? kind = null,Object? source = null,Object? linkProvider = freezed,Object? jobId = freezed,Object? jobStatus = freezed,Object? transcriptId = freezed,Object? tags = null,}) {
  return _then(_LibraryItem(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MediaKind,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as MediaSource,linkProvider: freezed == linkProvider ? _self.linkProvider : linkProvider // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,jobStatus: freezed == jobStatus ? _self.jobStatus : jobStatus // ignore: cast_nullable_to_non_nullable
as JobStatus?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
