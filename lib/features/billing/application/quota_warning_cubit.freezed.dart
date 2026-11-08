// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quota_warning_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuotaWarningState {

 String? get workspaceId; Balance? get balance; QuotaLevel get level;/// The closable 95 % warning is on screen.
 bool get banner;
/// Create a copy of QuotaWarningState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuotaWarningStateCopyWith<QuotaWarningState> get copyWith => _$QuotaWarningStateCopyWithImpl<QuotaWarningState>(this as QuotaWarningState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuotaWarningState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuotaWarningState&&(identical(other.workspaceId, _this.workspaceId) || other.workspaceId == _this.workspaceId)&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.banner, _this.banner) || other.banner == _this.banner));
}


@override
int get hashCode {
  final _this = this as QuotaWarningState;
  return Object.hash(runtimeType,_this.workspaceId,_this.balance,_this.level,_this.banner);
}

@override
String toString() {
  final _this = this as QuotaWarningState;
  return 'QuotaWarningState(workspaceId: ${_this.workspaceId}, balance: ${_this.balance}, level: ${_this.level}, banner: ${_this.banner})';
}


}

/// @nodoc
abstract mixin class $QuotaWarningStateCopyWith<$Res>  {
  factory $QuotaWarningStateCopyWith(QuotaWarningState value, $Res Function(QuotaWarningState) _then) = _$QuotaWarningStateCopyWithImpl;
@useResult
$Res call({
 String? workspaceId, Balance? balance, QuotaLevel level, bool banner
});


$BalanceCopyWith<$Res>? get balance;

}
/// @nodoc
class _$QuotaWarningStateCopyWithImpl<$Res>
    implements $QuotaWarningStateCopyWith<$Res> {
  _$QuotaWarningStateCopyWithImpl(this._self, this._then);

  final QuotaWarningState _self;
  final $Res Function(QuotaWarningState) _then;

/// Create a copy of QuotaWarningState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workspaceId = freezed,Object? balance = freezed,Object? level = null,Object? banner = null,}) {
  return _then(QuotaWarningState(
workspaceId: freezed == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Balance?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as QuotaLevel,banner: null == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of QuotaWarningState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceCopyWith<$Res>? get balance {
    if (_self.balance == null) {
    return null;
  }

  return $BalanceCopyWith<$Res>(_self.balance!, (value) {
    return _then(_self.copyWith(balance: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuotaWarningState].
extension QuotaWarningStatePatterns on QuotaWarningState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuotaWarningState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuotaWarningState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuotaWarningState value)  $default,){
final _that = this;
switch (_that) {
case _QuotaWarningState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuotaWarningState value)?  $default,){
final _that = this;
switch (_that) {
case _QuotaWarningState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? workspaceId,  Balance? balance,  QuotaLevel level,  bool banner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuotaWarningState() when $default != null:
return $default(_that.workspaceId,_that.balance,_that.level,_that.banner);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? workspaceId,  Balance? balance,  QuotaLevel level,  bool banner)  $default,) {final _that = this;
switch (_that) {
case _QuotaWarningState():
return $default(_that.workspaceId,_that.balance,_that.level,_that.banner);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? workspaceId,  Balance? balance,  QuotaLevel level,  bool banner)?  $default,) {final _that = this;
switch (_that) {
case _QuotaWarningState() when $default != null:
return $default(_that.workspaceId,_that.balance,_that.level,_that.banner);case _:
  return null;

}
}

}

/// @nodoc


class _QuotaWarningState implements QuotaWarningState {
  const _QuotaWarningState({this.workspaceId, this.balance, this.level = QuotaLevel.none, this.banner = false});
  

@override final  String? workspaceId;
@override final  Balance? balance;
@override@JsonKey() final  QuotaLevel level;
/// The closable 95 % warning is on screen.
@override@JsonKey() final  bool banner;

/// Create a copy of QuotaWarningState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuotaWarningStateCopyWith<_QuotaWarningState> get copyWith => __$QuotaWarningStateCopyWithImpl<_QuotaWarningState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuotaWarningState&&(identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.level, level) || other.level == level)&&(identical(other.banner, banner) || other.banner == banner));
}


@override
int get hashCode {
    return Object.hash(runtimeType,workspaceId,balance,level,banner);
}

@override
String toString() {
    return 'QuotaWarningState(workspaceId: $workspaceId, balance: $balance, level: $level, banner: $banner)';
}


}

/// @nodoc
abstract mixin class _$QuotaWarningStateCopyWith<$Res> implements $QuotaWarningStateCopyWith<$Res> {
  factory _$QuotaWarningStateCopyWith(_QuotaWarningState value, $Res Function(_QuotaWarningState) _then) = __$QuotaWarningStateCopyWithImpl;
@override @useResult
$Res call({
 String? workspaceId, Balance? balance, QuotaLevel level, bool banner
});


@override $BalanceCopyWith<$Res>? get balance;

}
/// @nodoc
class __$QuotaWarningStateCopyWithImpl<$Res>
    implements _$QuotaWarningStateCopyWith<$Res> {
  __$QuotaWarningStateCopyWithImpl(this._self, this._then);

  final _QuotaWarningState _self;
  final $Res Function(_QuotaWarningState) _then;

/// Create a copy of QuotaWarningState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workspaceId = freezed,Object? balance = freezed,Object? level = null,Object? banner = null,}) {
  return _then(_QuotaWarningState(
workspaceId: freezed == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Balance?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as QuotaLevel,banner: null == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of QuotaWarningState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceCopyWith<$Res>? get balance {
    if (_self.balance == null) {
    return null;
  }

  return $BalanceCopyWith<$Res>(_self.balance!, (value) {
    return _then(_self.copyWith(balance: value));
  });
}
}

// dart format on
