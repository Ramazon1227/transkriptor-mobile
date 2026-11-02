// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'held_files_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HeldFilesState {

 List<HeldFile> get items;/// The file being deleted; nothing else is deleted meanwhile.
 String? get deletingId; Failure? get failure;
/// Create a copy of HeldFilesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeldFilesStateCopyWith<HeldFilesState> get copyWith => _$HeldFilesStateCopyWithImpl<HeldFilesState>(this as HeldFilesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HeldFilesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeldFilesState&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.deletingId, _this.deletingId) || other.deletingId == _this.deletingId)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as HeldFilesState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.deletingId,_this.failure);
}

@override
String toString() {
  final _this = this as HeldFilesState;
  return 'HeldFilesState(items: ${_this.items}, deletingId: ${_this.deletingId}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $HeldFilesStateCopyWith<$Res>  {
  factory $HeldFilesStateCopyWith(HeldFilesState value, $Res Function(HeldFilesState) _then) = _$HeldFilesStateCopyWithImpl;
@useResult
$Res call({
 List<HeldFile> items, String? deletingId, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$HeldFilesStateCopyWithImpl<$Res>
    implements $HeldFilesStateCopyWith<$Res> {
  _$HeldFilesStateCopyWithImpl(this._self, this._then);

  final HeldFilesState _self;
  final $Res Function(HeldFilesState) _then;

/// Create a copy of HeldFilesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? deletingId = freezed,Object? failure = freezed,}) {
  return _then(HeldFilesState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HeldFile>,deletingId: freezed == deletingId ? _self.deletingId : deletingId // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of HeldFilesState
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


/// Adds pattern-matching-related methods to [HeldFilesState].
extension HeldFilesStatePatterns on HeldFilesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeldFilesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeldFilesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeldFilesState value)  $default,){
final _that = this;
switch (_that) {
case _HeldFilesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeldFilesState value)?  $default,){
final _that = this;
switch (_that) {
case _HeldFilesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HeldFile> items,  String? deletingId,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeldFilesState() when $default != null:
return $default(_that.items,_that.deletingId,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HeldFile> items,  String? deletingId,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _HeldFilesState():
return $default(_that.items,_that.deletingId,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HeldFile> items,  String? deletingId,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _HeldFilesState() when $default != null:
return $default(_that.items,_that.deletingId,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _HeldFilesState implements HeldFilesState {
  const _HeldFilesState({ List<HeldFile> items = const <HeldFile>[], this.deletingId, this.failure}): _items = items;
  

 final  List<HeldFile> _items;
@override@JsonKey() List<HeldFile> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// The file being deleted; nothing else is deleted meanwhile.
@override final  String? deletingId;
@override final  Failure? failure;

/// Create a copy of HeldFilesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeldFilesStateCopyWith<_HeldFilesState> get copyWith => __$HeldFilesStateCopyWithImpl<_HeldFilesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeldFilesState&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.deletingId, deletingId) || other.deletingId == deletingId)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),deletingId,failure);
}

@override
String toString() {
    return 'HeldFilesState(items: $items, deletingId: $deletingId, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$HeldFilesStateCopyWith<$Res> implements $HeldFilesStateCopyWith<$Res> {
  factory _$HeldFilesStateCopyWith(_HeldFilesState value, $Res Function(_HeldFilesState) _then) = __$HeldFilesStateCopyWithImpl;
@override @useResult
$Res call({
 List<HeldFile> items, String? deletingId, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$HeldFilesStateCopyWithImpl<$Res>
    implements _$HeldFilesStateCopyWith<$Res> {
  __$HeldFilesStateCopyWithImpl(this._self, this._then);

  final _HeldFilesState _self;
  final $Res Function(_HeldFilesState) _then;

/// Create a copy of HeldFilesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? deletingId = freezed,Object? failure = freezed,}) {
  return _then(_HeldFilesState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HeldFile>,deletingId: freezed == deletingId ? _self.deletingId : deletingId // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of HeldFilesState
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
