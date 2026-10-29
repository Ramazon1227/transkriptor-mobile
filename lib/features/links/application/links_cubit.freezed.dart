// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'links_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LinksState {

/// iOS: pages that ask for a permission show «Sozlamalarni ochish».
 bool get canOpenAppSettings;
/// Create a copy of LinksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinksStateCopyWith<LinksState> get copyWith => _$LinksStateCopyWithImpl<LinksState>(this as LinksState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LinksState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinksState&&(identical(other.canOpenAppSettings, _this.canOpenAppSettings) || other.canOpenAppSettings == _this.canOpenAppSettings));
}


@override
int get hashCode {
  final _this = this as LinksState;
  return Object.hash(runtimeType,_this.canOpenAppSettings);
}

@override
String toString() {
  final _this = this as LinksState;
  return 'LinksState(canOpenAppSettings: ${_this.canOpenAppSettings})';
}


}

/// @nodoc
abstract mixin class $LinksStateCopyWith<$Res>  {
  factory $LinksStateCopyWith(LinksState value, $Res Function(LinksState) _then) = _$LinksStateCopyWithImpl;
@useResult
$Res call({
 bool canOpenAppSettings
});




}
/// @nodoc
class _$LinksStateCopyWithImpl<$Res>
    implements $LinksStateCopyWith<$Res> {
  _$LinksStateCopyWithImpl(this._self, this._then);

  final LinksState _self;
  final $Res Function(LinksState) _then;

/// Create a copy of LinksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? canOpenAppSettings = null,}) {
  return _then(LinksState(
canOpenAppSettings: null == canOpenAppSettings ? _self.canOpenAppSettings : canOpenAppSettings // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LinksState].
extension LinksStatePatterns on LinksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinksState value)  $default,){
final _that = this;
switch (_that) {
case _LinksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinksState value)?  $default,){
final _that = this;
switch (_that) {
case _LinksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool canOpenAppSettings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinksState() when $default != null:
return $default(_that.canOpenAppSettings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool canOpenAppSettings)  $default,) {final _that = this;
switch (_that) {
case _LinksState():
return $default(_that.canOpenAppSettings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool canOpenAppSettings)?  $default,) {final _that = this;
switch (_that) {
case _LinksState() when $default != null:
return $default(_that.canOpenAppSettings);case _:
  return null;

}
}

}

/// @nodoc


class _LinksState implements LinksState {
  const _LinksState({this.canOpenAppSettings = false});
  

/// iOS: pages that ask for a permission show «Sozlamalarni ochish».
@override@JsonKey() final  bool canOpenAppSettings;

/// Create a copy of LinksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinksStateCopyWith<_LinksState> get copyWith => __$LinksStateCopyWithImpl<_LinksState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinksState&&(identical(other.canOpenAppSettings, canOpenAppSettings) || other.canOpenAppSettings == canOpenAppSettings));
}


@override
int get hashCode {
    return Object.hash(runtimeType,canOpenAppSettings);
}

@override
String toString() {
    return 'LinksState(canOpenAppSettings: $canOpenAppSettings)';
}


}

/// @nodoc
abstract mixin class _$LinksStateCopyWith<$Res> implements $LinksStateCopyWith<$Res> {
  factory _$LinksStateCopyWith(_LinksState value, $Res Function(_LinksState) _then) = __$LinksStateCopyWithImpl;
@override @useResult
$Res call({
 bool canOpenAppSettings
});




}
/// @nodoc
class __$LinksStateCopyWithImpl<$Res>
    implements _$LinksStateCopyWith<$Res> {
  __$LinksStateCopyWithImpl(this._self, this._then);

  final _LinksState _self;
  final $Res Function(_LinksState) _then;

/// Create a copy of LinksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? canOpenAppSettings = null,}) {
  return _then(_LinksState(
canOpenAppSettings: null == canOpenAppSettings ? _self.canOpenAppSettings : canOpenAppSettings // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
