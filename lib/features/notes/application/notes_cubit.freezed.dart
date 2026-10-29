// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotesState {

 NotesStatus get status; List<NoteSummary> get items;/// Null when the last page is loaded.
 String? get nextCursor;/// The next page is loading below the rows.
 bool get loadingMore;/// A reload runs while the previous rows stay visible.
 bool get refreshing;/// The files screen's search text; filters the loaded rows.
 String get query; Failure? get failure;
/// Create a copy of NotesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotesStateCopyWith<NotesState> get copyWith => _$NotesStateCopyWithImpl<NotesState>(this as NotesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.loadingMore, _this.loadingMore) || other.loadingMore == _this.loadingMore)&&(identical(other.refreshing, _this.refreshing) || other.refreshing == _this.refreshing)&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as NotesState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.items),_this.nextCursor,_this.loadingMore,_this.refreshing,_this.query,_this.failure);
}

@override
String toString() {
  final _this = this as NotesState;
  return 'NotesState(status: ${_this.status}, items: ${_this.items}, nextCursor: ${_this.nextCursor}, loadingMore: ${_this.loadingMore}, refreshing: ${_this.refreshing}, query: ${_this.query}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $NotesStateCopyWith<$Res>  {
  factory $NotesStateCopyWith(NotesState value, $Res Function(NotesState) _then) = _$NotesStateCopyWithImpl;
@useResult
$Res call({
 NotesStatus status, List<NoteSummary> items, String? nextCursor, bool loadingMore, bool refreshing, String query, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$NotesStateCopyWithImpl<$Res>
    implements $NotesStateCopyWith<$Res> {
  _$NotesStateCopyWithImpl(this._self, this._then);

  final NotesState _self;
  final $Res Function(NotesState) _then;

/// Create a copy of NotesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? nextCursor = freezed,Object? loadingMore = null,Object? refreshing = null,Object? query = null,Object? failure = freezed,}) {
  return _then(NotesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotesStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<NoteSummary>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,refreshing: null == refreshing ? _self.refreshing : refreshing // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of NotesState
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


/// Adds pattern-matching-related methods to [NotesState].
extension NotesStatePatterns on NotesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotesState value)  $default,){
final _that = this;
switch (_that) {
case _NotesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotesState value)?  $default,){
final _that = this;
switch (_that) {
case _NotesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotesStatus status,  List<NoteSummary> items,  String? nextCursor,  bool loadingMore,  bool refreshing,  String query,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotesState() when $default != null:
return $default(_that.status,_that.items,_that.nextCursor,_that.loadingMore,_that.refreshing,_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotesStatus status,  List<NoteSummary> items,  String? nextCursor,  bool loadingMore,  bool refreshing,  String query,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _NotesState():
return $default(_that.status,_that.items,_that.nextCursor,_that.loadingMore,_that.refreshing,_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotesStatus status,  List<NoteSummary> items,  String? nextCursor,  bool loadingMore,  bool refreshing,  String query,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _NotesState() when $default != null:
return $default(_that.status,_that.items,_that.nextCursor,_that.loadingMore,_that.refreshing,_that.query,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _NotesState implements NotesState {
  const _NotesState({this.status = NotesStatus.initial,  List<NoteSummary> items = const <NoteSummary>[], this.nextCursor, this.loadingMore = false, this.refreshing = false, this.query = '', this.failure}): _items = items;
  

@override@JsonKey() final  NotesStatus status;
 final  List<NoteSummary> _items;
@override@JsonKey() List<NoteSummary> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Null when the last page is loaded.
@override final  String? nextCursor;
/// The next page is loading below the rows.
@override@JsonKey() final  bool loadingMore;
/// A reload runs while the previous rows stay visible.
@override@JsonKey() final  bool refreshing;
/// The files screen's search text; filters the loaded rows.
@override@JsonKey() final  String query;
@override final  Failure? failure;

/// Create a copy of NotesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotesStateCopyWith<_NotesState> get copyWith => __$NotesStateCopyWithImpl<_NotesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&(identical(other.refreshing, refreshing) || other.refreshing == refreshing)&&(identical(other.query, query) || other.query == query)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),nextCursor,loadingMore,refreshing,query,failure);
}

@override
String toString() {
    return 'NotesState(status: $status, items: $items, nextCursor: $nextCursor, loadingMore: $loadingMore, refreshing: $refreshing, query: $query, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$NotesStateCopyWith<$Res> implements $NotesStateCopyWith<$Res> {
  factory _$NotesStateCopyWith(_NotesState value, $Res Function(_NotesState) _then) = __$NotesStateCopyWithImpl;
@override @useResult
$Res call({
 NotesStatus status, List<NoteSummary> items, String? nextCursor, bool loadingMore, bool refreshing, String query, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$NotesStateCopyWithImpl<$Res>
    implements _$NotesStateCopyWith<$Res> {
  __$NotesStateCopyWithImpl(this._self, this._then);

  final _NotesState _self;
  final $Res Function(_NotesState) _then;

/// Create a copy of NotesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? nextCursor = freezed,Object? loadingMore = null,Object? refreshing = null,Object? query = null,Object? failure = freezed,}) {
  return _then(_NotesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotesStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<NoteSummary>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,refreshing: null == refreshing ? _self.refreshing : refreshing // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of NotesState
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
