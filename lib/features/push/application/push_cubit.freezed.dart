// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PushState {

/// The last notification tapped; the app opens its page.
 PushMessage? get opened;/// Bumped per tap, so the same message tapped twice opens twice.
 int get tapCount;
/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushStateCopyWith<PushState> get copyWith => _$PushStateCopyWithImpl<PushState>(this as PushState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PushState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushState&&(identical(other.opened, _this.opened) || other.opened == _this.opened)&&(identical(other.tapCount, _this.tapCount) || other.tapCount == _this.tapCount));
}


@override
int get hashCode {
  final _this = this as PushState;
  return Object.hash(runtimeType,_this.opened,_this.tapCount);
}

@override
String toString() {
  final _this = this as PushState;
  return 'PushState(opened: ${_this.opened}, tapCount: ${_this.tapCount})';
}


}

/// @nodoc
abstract mixin class $PushStateCopyWith<$Res>  {
  factory $PushStateCopyWith(PushState value, $Res Function(PushState) _then) = _$PushStateCopyWithImpl;
@useResult
$Res call({
 PushMessage? opened, int tapCount
});


$PushMessageCopyWith<$Res>? get opened;

}
/// @nodoc
class _$PushStateCopyWithImpl<$Res>
    implements $PushStateCopyWith<$Res> {
  _$PushStateCopyWithImpl(this._self, this._then);

  final PushState _self;
  final $Res Function(PushState) _then;

/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opened = freezed,Object? tapCount = null,}) {
  return _then(PushState(
opened: freezed == opened ? _self.opened : opened // ignore: cast_nullable_to_non_nullable
as PushMessage?,tapCount: null == tapCount ? _self.tapCount : tapCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PushMessageCopyWith<$Res>? get opened {
    if (_self.opened == null) {
    return null;
  }

  return $PushMessageCopyWith<$Res>(_self.opened!, (value) {
    return _then(_self.copyWith(opened: value));
  });
}
}


/// Adds pattern-matching-related methods to [PushState].
extension PushStatePatterns on PushState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushState value)  $default,){
final _that = this;
switch (_that) {
case _PushState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushState value)?  $default,){
final _that = this;
switch (_that) {
case _PushState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PushMessage? opened,  int tapCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushState() when $default != null:
return $default(_that.opened,_that.tapCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PushMessage? opened,  int tapCount)  $default,) {final _that = this;
switch (_that) {
case _PushState():
return $default(_that.opened,_that.tapCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PushMessage? opened,  int tapCount)?  $default,) {final _that = this;
switch (_that) {
case _PushState() when $default != null:
return $default(_that.opened,_that.tapCount);case _:
  return null;

}
}

}

/// @nodoc


class _PushState implements PushState {
  const _PushState({this.opened, this.tapCount = 0});
  

/// The last notification tapped; the app opens its page.
@override final  PushMessage? opened;
/// Bumped per tap, so the same message tapped twice opens twice.
@override@JsonKey() final  int tapCount;

/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushStateCopyWith<_PushState> get copyWith => __$PushStateCopyWithImpl<_PushState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushState&&(identical(other.opened, opened) || other.opened == opened)&&(identical(other.tapCount, tapCount) || other.tapCount == tapCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,opened,tapCount);
}

@override
String toString() {
    return 'PushState(opened: $opened, tapCount: $tapCount)';
}


}

/// @nodoc
abstract mixin class _$PushStateCopyWith<$Res> implements $PushStateCopyWith<$Res> {
  factory _$PushStateCopyWith(_PushState value, $Res Function(_PushState) _then) = __$PushStateCopyWithImpl;
@override @useResult
$Res call({
 PushMessage? opened, int tapCount
});


@override $PushMessageCopyWith<$Res>? get opened;

}
/// @nodoc
class __$PushStateCopyWithImpl<$Res>
    implements _$PushStateCopyWith<$Res> {
  __$PushStateCopyWithImpl(this._self, this._then);

  final _PushState _self;
  final $Res Function(_PushState) _then;

/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opened = freezed,Object? tapCount = null,}) {
  return _then(_PushState(
opened: freezed == opened ? _self.opened : opened // ignore: cast_nullable_to_non_nullable
as PushMessage?,tapCount: null == tapCount ? _self.tapCount : tapCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PushState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PushMessageCopyWith<$Res>? get opened {
    if (_self.opened == null) {
    return null;
  }

  return $PushMessageCopyWith<$Res>(_self.opened!, (value) {
    return _then(_self.copyWith(opened: value));
  });
}
}

// dart format on
