// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LibraryState {

 LibraryStatus get status; List<LibraryItem> get items;/// Null when the last page is loaded, or while a new filter's first
/// page is awaited.
 String? get nextCursor;/// Every row matching the filters, not only the loaded ones.
 int get total; String? get workspaceId;/// The open folder; null is every file.
 String? get folderId;/// The tag the server narrows the rows to; null shows them all.
 String? get tag;/// The workspace's tags, most used first. Kept when a fetch fails.
 List<String> get tags;/// The source tab; [LibraryState.items] already match it.
 FilesSource get source;/// The search text as sent to the server, trimmed; empty shows every row.
 String get query;/// A reload is running while the previous rows stay visible.
 bool get refreshing;/// The next page is loading below the rows.
 bool get loadingMore; Failure? get failure;
/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryStateCopyWith<LibraryState> get copyWith => _$LibraryStateCopyWithImpl<LibraryState>(this as LibraryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LibraryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.workspaceId, _this.workspaceId) || other.workspaceId == _this.workspaceId)&&(identical(other.folderId, _this.folderId) || other.folderId == _this.folderId)&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.refreshing, _this.refreshing) || other.refreshing == _this.refreshing)&&(identical(other.loadingMore, _this.loadingMore) || other.loadingMore == _this.loadingMore)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as LibraryState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.items),_this.nextCursor,_this.total,_this.workspaceId,_this.folderId,_this.tag,const DeepCollectionEquality().hash(_this.tags),_this.source,_this.query,_this.refreshing,_this.loadingMore,_this.failure);
}

@override
String toString() {
  final _this = this as LibraryState;
  return 'LibraryState(status: ${_this.status}, items: ${_this.items}, nextCursor: ${_this.nextCursor}, total: ${_this.total}, workspaceId: ${_this.workspaceId}, folderId: ${_this.folderId}, tag: ${_this.tag}, tags: ${_this.tags}, source: ${_this.source}, query: ${_this.query}, refreshing: ${_this.refreshing}, loadingMore: ${_this.loadingMore}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $LibraryStateCopyWith<$Res>  {
  factory $LibraryStateCopyWith(LibraryState value, $Res Function(LibraryState) _then) = _$LibraryStateCopyWithImpl;
@useResult
$Res call({
 LibraryStatus status, List<LibraryItem> items, String? nextCursor, int total, String? workspaceId, String? folderId, String? tag, List<String> tags, FilesSource source, String query, bool refreshing, bool loadingMore, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$LibraryStateCopyWithImpl<$Res>
    implements $LibraryStateCopyWith<$Res> {
  _$LibraryStateCopyWithImpl(this._self, this._then);

  final LibraryState _self;
  final $Res Function(LibraryState) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? nextCursor = freezed,Object? total = null,Object? workspaceId = freezed,Object? folderId = freezed,Object? tag = freezed,Object? tags = null,Object? source = null,Object? query = null,Object? refreshing = null,Object? loadingMore = null,Object? failure = freezed,}) {
  return _then(LibraryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LibraryStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<LibraryItem>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,workspaceId: freezed == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String?,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as FilesSource,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,refreshing: null == refreshing ? _self.refreshing : refreshing // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [LibraryState].
extension LibraryStatePatterns on LibraryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryState value)  $default,){
final _that = this;
switch (_that) {
case _LibraryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryState value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LibraryStatus status,  List<LibraryItem> items,  String? nextCursor,  int total,  String? workspaceId,  String? folderId,  String? tag,  List<String> tags,  FilesSource source,  String query,  bool refreshing,  bool loadingMore,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
return $default(_that.status,_that.items,_that.nextCursor,_that.total,_that.workspaceId,_that.folderId,_that.tag,_that.tags,_that.source,_that.query,_that.refreshing,_that.loadingMore,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LibraryStatus status,  List<LibraryItem> items,  String? nextCursor,  int total,  String? workspaceId,  String? folderId,  String? tag,  List<String> tags,  FilesSource source,  String query,  bool refreshing,  bool loadingMore,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _LibraryState():
return $default(_that.status,_that.items,_that.nextCursor,_that.total,_that.workspaceId,_that.folderId,_that.tag,_that.tags,_that.source,_that.query,_that.refreshing,_that.loadingMore,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LibraryStatus status,  List<LibraryItem> items,  String? nextCursor,  int total,  String? workspaceId,  String? folderId,  String? tag,  List<String> tags,  FilesSource source,  String query,  bool refreshing,  bool loadingMore,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
return $default(_that.status,_that.items,_that.nextCursor,_that.total,_that.workspaceId,_that.folderId,_that.tag,_that.tags,_that.source,_that.query,_that.refreshing,_that.loadingMore,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _LibraryState implements LibraryState {
  const _LibraryState({this.status = LibraryStatus.initial,  List<LibraryItem> items = const <LibraryItem>[], this.nextCursor, this.total = 0, this.workspaceId, this.folderId, this.tag,  List<String> tags = const <String>[], this.source = FilesSource.all, this.query = '', this.refreshing = false, this.loadingMore = false, this.failure}): _items = items,_tags = tags;
  

@override@JsonKey() final  LibraryStatus status;
 final  List<LibraryItem> _items;
@override@JsonKey() List<LibraryItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Null when the last page is loaded, or while a new filter's first
/// page is awaited.
@override final  String? nextCursor;
/// Every row matching the filters, not only the loaded ones.
@override@JsonKey() final  int total;
@override final  String? workspaceId;
/// The open folder; null is every file.
@override final  String? folderId;
/// The tag the server narrows the rows to; null shows them all.
@override final  String? tag;
/// The workspace's tags, most used first. Kept when a fetch fails.
 final  List<String> _tags;
/// The workspace's tags, most used first. Kept when a fetch fails.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// The source tab; [LibraryState.items] already match it.
@override@JsonKey() final  FilesSource source;
/// The search text as sent to the server, trimmed; empty shows every row.
@override@JsonKey() final  String query;
/// A reload is running while the previous rows stay visible.
@override@JsonKey() final  bool refreshing;
/// The next page is loading below the rows.
@override@JsonKey() final  bool loadingMore;
@override final  Failure? failure;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryStateCopyWith<_LibraryState> get copyWith => __$LibraryStateCopyWithImpl<_LibraryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.total, total) || other.total == total)&&(identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId)&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.tag, tag) || other.tag == tag)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.source, source) || other.source == source)&&(identical(other.query, query) || other.query == query)&&(identical(other.refreshing, refreshing) || other.refreshing == refreshing)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),nextCursor,total,workspaceId,folderId,tag,const DeepCollectionEquality().hash(_tags),source,query,refreshing,loadingMore,failure);
}

@override
String toString() {
    return 'LibraryState(status: $status, items: $items, nextCursor: $nextCursor, total: $total, workspaceId: $workspaceId, folderId: $folderId, tag: $tag, tags: $tags, source: $source, query: $query, refreshing: $refreshing, loadingMore: $loadingMore, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$LibraryStateCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$LibraryStateCopyWith(_LibraryState value, $Res Function(_LibraryState) _then) = __$LibraryStateCopyWithImpl;
@override @useResult
$Res call({
 LibraryStatus status, List<LibraryItem> items, String? nextCursor, int total, String? workspaceId, String? folderId, String? tag, List<String> tags, FilesSource source, String query, bool refreshing, bool loadingMore, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$LibraryStateCopyWithImpl<$Res>
    implements _$LibraryStateCopyWith<$Res> {
  __$LibraryStateCopyWithImpl(this._self, this._then);

  final _LibraryState _self;
  final $Res Function(_LibraryState) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? nextCursor = freezed,Object? total = null,Object? workspaceId = freezed,Object? folderId = freezed,Object? tag = freezed,Object? tags = null,Object? source = null,Object? query = null,Object? refreshing = null,Object? loadingMore = null,Object? failure = freezed,}) {
  return _then(_LibraryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LibraryStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LibraryItem>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,workspaceId: freezed == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String?,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as FilesSource,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,refreshing: null == refreshing ? _self.refreshing : refreshing // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
