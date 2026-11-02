// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaker_intro_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeakerIntroState {

/// The page opens the sheet when this turns true.
 bool get due;/// «Ochilganda maʼruzachilarni soʻramaslik».
 bool get off;
/// Create a copy of SpeakerIntroState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerIntroStateCopyWith<SpeakerIntroState> get copyWith => _$SpeakerIntroStateCopyWithImpl<SpeakerIntroState>(this as SpeakerIntroState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SpeakerIntroState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakerIntroState&&(identical(other.due, _this.due) || other.due == _this.due)&&(identical(other.off, _this.off) || other.off == _this.off));
}


@override
int get hashCode {
  final _this = this as SpeakerIntroState;
  return Object.hash(runtimeType,_this.due,_this.off);
}

@override
String toString() {
  final _this = this as SpeakerIntroState;
  return 'SpeakerIntroState(due: ${_this.due}, off: ${_this.off})';
}


}

/// @nodoc
abstract mixin class $SpeakerIntroStateCopyWith<$Res>  {
  factory $SpeakerIntroStateCopyWith(SpeakerIntroState value, $Res Function(SpeakerIntroState) _then) = _$SpeakerIntroStateCopyWithImpl;
@useResult
$Res call({
 bool due, bool off
});




}
/// @nodoc
class _$SpeakerIntroStateCopyWithImpl<$Res>
    implements $SpeakerIntroStateCopyWith<$Res> {
  _$SpeakerIntroStateCopyWithImpl(this._self, this._then);

  final SpeakerIntroState _self;
  final $Res Function(SpeakerIntroState) _then;

/// Create a copy of SpeakerIntroState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? due = null,Object? off = null,}) {
  return _then(SpeakerIntroState(
due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as bool,off: null == off ? _self.off : off // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakerIntroState].
extension SpeakerIntroStatePatterns on SpeakerIntroState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakerIntroState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakerIntroState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakerIntroState value)  $default,){
final _that = this;
switch (_that) {
case _SpeakerIntroState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakerIntroState value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakerIntroState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool due,  bool off)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakerIntroState() when $default != null:
return $default(_that.due,_that.off);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool due,  bool off)  $default,) {final _that = this;
switch (_that) {
case _SpeakerIntroState():
return $default(_that.due,_that.off);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool due,  bool off)?  $default,) {final _that = this;
switch (_that) {
case _SpeakerIntroState() when $default != null:
return $default(_that.due,_that.off);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakerIntroState implements SpeakerIntroState {
  const _SpeakerIntroState({this.due = false, this.off = false});
  

/// The page opens the sheet when this turns true.
@override@JsonKey() final  bool due;
/// «Ochilganda maʼruzachilarni soʻramaslik».
@override@JsonKey() final  bool off;

/// Create a copy of SpeakerIntroState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerIntroStateCopyWith<_SpeakerIntroState> get copyWith => __$SpeakerIntroStateCopyWithImpl<_SpeakerIntroState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakerIntroState&&(identical(other.due, due) || other.due == due)&&(identical(other.off, off) || other.off == off));
}


@override
int get hashCode {
    return Object.hash(runtimeType,due,off);
}

@override
String toString() {
    return 'SpeakerIntroState(due: $due, off: $off)';
}


}

/// @nodoc
abstract mixin class _$SpeakerIntroStateCopyWith<$Res> implements $SpeakerIntroStateCopyWith<$Res> {
  factory _$SpeakerIntroStateCopyWith(_SpeakerIntroState value, $Res Function(_SpeakerIntroState) _then) = __$SpeakerIntroStateCopyWithImpl;
@override @useResult
$Res call({
 bool due, bool off
});




}
/// @nodoc
class __$SpeakerIntroStateCopyWithImpl<$Res>
    implements _$SpeakerIntroStateCopyWith<$Res> {
  __$SpeakerIntroStateCopyWithImpl(this._self, this._then);

  final _SpeakerIntroState _self;
  final $Res Function(_SpeakerIntroState) _then;

/// Create a copy of SpeakerIntroState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? due = null,Object? off = null,}) {
  return _then(_SpeakerIntroState(
due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as bool,off: null == off ? _self.off : off // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
