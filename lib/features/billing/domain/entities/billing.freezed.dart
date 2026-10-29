// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Plan {

 String get code; String get name;/// Minutes granted per month, in seconds.
 int get monthlySeconds;/// `num`: a so'm price can outgrow an int on no platform today, but
/// money stays out of int by rule.
 num get priceUzs; int get maxMembers;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Plan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.monthlySeconds, _this.monthlySeconds) || other.monthlySeconds == _this.monthlySeconds)&&(identical(other.priceUzs, _this.priceUzs) || other.priceUzs == _this.priceUzs)&&(identical(other.maxMembers, _this.maxMembers) || other.maxMembers == _this.maxMembers));
}


@override
int get hashCode {
  final _this = this as Plan;
  return Object.hash(runtimeType,_this.code,_this.name,_this.monthlySeconds,_this.priceUzs,_this.maxMembers);
}

@override
String toString() {
  final _this = this as Plan;
  return 'Plan(code: ${_this.code}, name: ${_this.name}, monthlySeconds: ${_this.monthlySeconds}, priceUzs: ${_this.priceUzs}, maxMembers: ${_this.maxMembers})';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 String code, String name, int monthlySeconds, num priceUzs, int maxMembers
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? monthlySeconds = null,Object? priceUzs = null,Object? maxMembers = null,}) {
  return _then(Plan(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,monthlySeconds: null == monthlySeconds ? _self.monthlySeconds : monthlySeconds // ignore: cast_nullable_to_non_nullable
as int,priceUzs: null == priceUzs ? _self.priceUzs : priceUzs // ignore: cast_nullable_to_non_nullable
as num,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  int monthlySeconds,  num priceUzs,  int maxMembers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.code,_that.name,_that.monthlySeconds,_that.priceUzs,_that.maxMembers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  int monthlySeconds,  num priceUzs,  int maxMembers)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.code,_that.name,_that.monthlySeconds,_that.priceUzs,_that.maxMembers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  int monthlySeconds,  num priceUzs,  int maxMembers)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.code,_that.name,_that.monthlySeconds,_that.priceUzs,_that.maxMembers);case _:
  return null;

}
}

}

/// @nodoc


class _Plan extends Plan {
  const _Plan({required this.code, required this.name, this.monthlySeconds = 0, this.priceUzs = 0, this.maxMembers = 0}): super._();
  

@override final  String code;
@override final  String name;
/// Minutes granted per month, in seconds.
@override@JsonKey() final  int monthlySeconds;
/// `num`: a so'm price can outgrow an int on no platform today, but
/// money stays out of int by rule.
@override@JsonKey() final  num priceUzs;
@override@JsonKey() final  int maxMembers;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.monthlySeconds, monthlySeconds) || other.monthlySeconds == monthlySeconds)&&(identical(other.priceUzs, priceUzs) || other.priceUzs == priceUzs)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code,name,monthlySeconds,priceUzs,maxMembers);
}

@override
String toString() {
    return 'Plan(code: $code, name: $name, monthlySeconds: $monthlySeconds, priceUzs: $priceUzs, maxMembers: $maxMembers)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, int monthlySeconds, num priceUzs, int maxMembers
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? monthlySeconds = null,Object? priceUzs = null,Object? maxMembers = null,}) {
  return _then(_Plan(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,monthlySeconds: null == monthlySeconds ? _self.monthlySeconds : monthlySeconds // ignore: cast_nullable_to_non_nullable
as int,priceUzs: null == priceUzs ? _self.priceUzs : priceUzs // ignore: cast_nullable_to_non_nullable
as num,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Balance {

 int get balanceSeconds; Plan? get plan; SubscriptionStatus get status; DateTime? get periodEnd;/// The subscription ends at [periodEnd] instead of renewing.
 bool get cancelAtPeriodEnd;
/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceCopyWith<Balance> get copyWith => _$BalanceCopyWithImpl<Balance>(this as Balance, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Balance;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Balance&&(identical(other.balanceSeconds, _this.balanceSeconds) || other.balanceSeconds == _this.balanceSeconds)&&(identical(other.plan, _this.plan) || other.plan == _this.plan)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.periodEnd, _this.periodEnd) || other.periodEnd == _this.periodEnd)&&(identical(other.cancelAtPeriodEnd, _this.cancelAtPeriodEnd) || other.cancelAtPeriodEnd == _this.cancelAtPeriodEnd));
}


@override
int get hashCode {
  final _this = this as Balance;
  return Object.hash(runtimeType,_this.balanceSeconds,_this.plan,_this.status,_this.periodEnd,_this.cancelAtPeriodEnd);
}

@override
String toString() {
  final _this = this as Balance;
  return 'Balance(balanceSeconds: ${_this.balanceSeconds}, plan: ${_this.plan}, status: ${_this.status}, periodEnd: ${_this.periodEnd}, cancelAtPeriodEnd: ${_this.cancelAtPeriodEnd})';
}


}

/// @nodoc
abstract mixin class $BalanceCopyWith<$Res>  {
  factory $BalanceCopyWith(Balance value, $Res Function(Balance) _then) = _$BalanceCopyWithImpl;
@useResult
$Res call({
 int balanceSeconds, Plan? plan, SubscriptionStatus status, DateTime? periodEnd, bool cancelAtPeriodEnd
});


$PlanCopyWith<$Res>? get plan;

}
/// @nodoc
class _$BalanceCopyWithImpl<$Res>
    implements $BalanceCopyWith<$Res> {
  _$BalanceCopyWithImpl(this._self, this._then);

  final Balance _self;
  final $Res Function(Balance) _then;

/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balanceSeconds = null,Object? plan = freezed,Object? status = null,Object? periodEnd = freezed,Object? cancelAtPeriodEnd = null,}) {
  return _then(Balance(
balanceSeconds: null == balanceSeconds ? _self.balanceSeconds : balanceSeconds // ignore: cast_nullable_to_non_nullable
as int,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as Plan?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,periodEnd: freezed == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelAtPeriodEnd: null == cancelAtPeriodEnd ? _self.cancelAtPeriodEnd : cancelAtPeriodEnd // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $PlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [Balance].
extension BalancePatterns on Balance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Balance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Balance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Balance value)  $default,){
final _that = this;
switch (_that) {
case _Balance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Balance value)?  $default,){
final _that = this;
switch (_that) {
case _Balance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int balanceSeconds,  Plan? plan,  SubscriptionStatus status,  DateTime? periodEnd,  bool cancelAtPeriodEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Balance() when $default != null:
return $default(_that.balanceSeconds,_that.plan,_that.status,_that.periodEnd,_that.cancelAtPeriodEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int balanceSeconds,  Plan? plan,  SubscriptionStatus status,  DateTime? periodEnd,  bool cancelAtPeriodEnd)  $default,) {final _that = this;
switch (_that) {
case _Balance():
return $default(_that.balanceSeconds,_that.plan,_that.status,_that.periodEnd,_that.cancelAtPeriodEnd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int balanceSeconds,  Plan? plan,  SubscriptionStatus status,  DateTime? periodEnd,  bool cancelAtPeriodEnd)?  $default,) {final _that = this;
switch (_that) {
case _Balance() when $default != null:
return $default(_that.balanceSeconds,_that.plan,_that.status,_that.periodEnd,_that.cancelAtPeriodEnd);case _:
  return null;

}
}

}

/// @nodoc


class _Balance implements Balance {
  const _Balance({this.balanceSeconds = 0, this.plan, this.status = SubscriptionStatus.none, this.periodEnd, this.cancelAtPeriodEnd = false});
  

@override@JsonKey() final  int balanceSeconds;
@override final  Plan? plan;
@override@JsonKey() final  SubscriptionStatus status;
@override final  DateTime? periodEnd;
/// The subscription ends at [periodEnd] instead of renewing.
@override@JsonKey() final  bool cancelAtPeriodEnd;

/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceCopyWith<_Balance> get copyWith => __$BalanceCopyWithImpl<_Balance>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Balance&&(identical(other.balanceSeconds, balanceSeconds) || other.balanceSeconds == balanceSeconds)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.cancelAtPeriodEnd, cancelAtPeriodEnd) || other.cancelAtPeriodEnd == cancelAtPeriodEnd));
}


@override
int get hashCode {
    return Object.hash(runtimeType,balanceSeconds,plan,status,periodEnd,cancelAtPeriodEnd);
}

@override
String toString() {
    return 'Balance(balanceSeconds: $balanceSeconds, plan: $plan, status: $status, periodEnd: $periodEnd, cancelAtPeriodEnd: $cancelAtPeriodEnd)';
}


}

/// @nodoc
abstract mixin class _$BalanceCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$BalanceCopyWith(_Balance value, $Res Function(_Balance) _then) = __$BalanceCopyWithImpl;
@override @useResult
$Res call({
 int balanceSeconds, Plan? plan, SubscriptionStatus status, DateTime? periodEnd, bool cancelAtPeriodEnd
});


@override $PlanCopyWith<$Res>? get plan;

}
/// @nodoc
class __$BalanceCopyWithImpl<$Res>
    implements _$BalanceCopyWith<$Res> {
  __$BalanceCopyWithImpl(this._self, this._then);

  final _Balance _self;
  final $Res Function(_Balance) _then;

/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balanceSeconds = null,Object? plan = freezed,Object? status = null,Object? periodEnd = freezed,Object? cancelAtPeriodEnd = null,}) {
  return _then(_Balance(
balanceSeconds: null == balanceSeconds ? _self.balanceSeconds : balanceSeconds // ignore: cast_nullable_to_non_nullable
as int,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as Plan?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,periodEnd: freezed == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelAtPeriodEnd: null == cancelAtPeriodEnd ? _self.cancelAtPeriodEnd : cancelAtPeriodEnd // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $PlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

// dart format on
