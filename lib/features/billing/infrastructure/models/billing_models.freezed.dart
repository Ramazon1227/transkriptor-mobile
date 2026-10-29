// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanModel {

@JsonKey(name: 'code') String get code;@JsonKey(name: 'name') String get name;@JsonKey(name: 'monthly_seconds') int get monthlySeconds;@JsonKey(name: 'price_uzs') num get priceUzs;@JsonKey(name: 'max_members') int get maxMembers;
/// Create a copy of PlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanModelCopyWith<PlanModel> get copyWith => _$PlanModelCopyWithImpl<PlanModel>(this as PlanModel, _$identity);

  /// Serializes this PlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanModel&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.monthlySeconds, _this.monthlySeconds) || other.monthlySeconds == _this.monthlySeconds)&&(identical(other.priceUzs, _this.priceUzs) || other.priceUzs == _this.priceUzs)&&(identical(other.maxMembers, _this.maxMembers) || other.maxMembers == _this.maxMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanModel;
  return Object.hash(runtimeType,_this.code,_this.name,_this.monthlySeconds,_this.priceUzs,_this.maxMembers);
}

@override
String toString() {
  final _this = this as PlanModel;
  return 'PlanModel(code: ${_this.code}, name: ${_this.name}, monthlySeconds: ${_this.monthlySeconds}, priceUzs: ${_this.priceUzs}, maxMembers: ${_this.maxMembers})';
}


}

/// @nodoc
abstract mixin class $PlanModelCopyWith<$Res>  {
  factory $PlanModelCopyWith(PlanModel value, $Res Function(PlanModel) _then) = _$PlanModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'code') String code,@JsonKey(name: 'name') String name,@JsonKey(name: 'monthly_seconds') int monthlySeconds,@JsonKey(name: 'price_uzs') num priceUzs,@JsonKey(name: 'max_members') int maxMembers
});




}
/// @nodoc
class _$PlanModelCopyWithImpl<$Res>
    implements $PlanModelCopyWith<$Res> {
  _$PlanModelCopyWithImpl(this._self, this._then);

  final PlanModel _self;
  final $Res Function(PlanModel) _then;

/// Create a copy of PlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? monthlySeconds = null,Object? priceUzs = null,Object? maxMembers = null,}) {
  return _then(PlanModel(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,monthlySeconds: null == monthlySeconds ? _self.monthlySeconds : monthlySeconds // ignore: cast_nullable_to_non_nullable
as int,priceUzs: null == priceUzs ? _self.priceUzs : priceUzs // ignore: cast_nullable_to_non_nullable
as num,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanModel].
extension PlanModelPatterns on PlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'code')  String code, @JsonKey(name: 'name')  String name, @JsonKey(name: 'monthly_seconds')  int monthlySeconds, @JsonKey(name: 'price_uzs')  num priceUzs, @JsonKey(name: 'max_members')  int maxMembers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'code')  String code, @JsonKey(name: 'name')  String name, @JsonKey(name: 'monthly_seconds')  int monthlySeconds, @JsonKey(name: 'price_uzs')  num priceUzs, @JsonKey(name: 'max_members')  int maxMembers)  $default,) {final _that = this;
switch (_that) {
case _PlanModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'code')  String code, @JsonKey(name: 'name')  String name, @JsonKey(name: 'monthly_seconds')  int monthlySeconds, @JsonKey(name: 'price_uzs')  num priceUzs, @JsonKey(name: 'max_members')  int maxMembers)?  $default,) {final _that = this;
switch (_that) {
case _PlanModel() when $default != null:
return $default(_that.code,_that.name,_that.monthlySeconds,_that.priceUzs,_that.maxMembers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanModel extends PlanModel {
  const _PlanModel({@JsonKey(name: 'code') this.code = '', @JsonKey(name: 'name') this.name = '', @JsonKey(name: 'monthly_seconds') this.monthlySeconds = 0, @JsonKey(name: 'price_uzs') this.priceUzs = 0, @JsonKey(name: 'max_members') this.maxMembers = 0}): super._();
  factory _PlanModel.fromJson(Map<String, dynamic> json) => _$PlanModelFromJson(json);

@override@JsonKey(name: 'code') final  String code;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'monthly_seconds') final  int monthlySeconds;
@override@JsonKey(name: 'price_uzs') final  num priceUzs;
@override@JsonKey(name: 'max_members') final  int maxMembers;

/// Create a copy of PlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanModelCopyWith<_PlanModel> get copyWith => __$PlanModelCopyWithImpl<_PlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanModel&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.monthlySeconds, monthlySeconds) || other.monthlySeconds == monthlySeconds)&&(identical(other.priceUzs, priceUzs) || other.priceUzs == priceUzs)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,name,monthlySeconds,priceUzs,maxMembers);
}

@override
String toString() {
    return 'PlanModel(code: $code, name: $name, monthlySeconds: $monthlySeconds, priceUzs: $priceUzs, maxMembers: $maxMembers)';
}


}

/// @nodoc
abstract mixin class _$PlanModelCopyWith<$Res> implements $PlanModelCopyWith<$Res> {
  factory _$PlanModelCopyWith(_PlanModel value, $Res Function(_PlanModel) _then) = __$PlanModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'code') String code,@JsonKey(name: 'name') String name,@JsonKey(name: 'monthly_seconds') int monthlySeconds,@JsonKey(name: 'price_uzs') num priceUzs,@JsonKey(name: 'max_members') int maxMembers
});




}
/// @nodoc
class __$PlanModelCopyWithImpl<$Res>
    implements _$PlanModelCopyWith<$Res> {
  __$PlanModelCopyWithImpl(this._self, this._then);

  final _PlanModel _self;
  final $Res Function(_PlanModel) _then;

/// Create a copy of PlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? monthlySeconds = null,Object? priceUzs = null,Object? maxMembers = null,}) {
  return _then(_PlanModel(
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
mixin _$PlanListModel {

@JsonKey(name: 'items') List<PlanModel> get items;
/// Create a copy of PlanListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanListModelCopyWith<PlanListModel> get copyWith => _$PlanListModelCopyWithImpl<PlanListModel>(this as PlanListModel, _$identity);

  /// Serializes this PlanListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanListModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanListModel&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanListModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as PlanListModel;
  return 'PlanListModel(items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $PlanListModelCopyWith<$Res>  {
  factory $PlanListModelCopyWith(PlanListModel value, $Res Function(PlanListModel) _then) = _$PlanListModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'items') List<PlanModel> items
});




}
/// @nodoc
class _$PlanListModelCopyWithImpl<$Res>
    implements $PlanListModelCopyWith<$Res> {
  _$PlanListModelCopyWithImpl(this._self, this._then);

  final PlanListModel _self;
  final $Res Function(PlanListModel) _then;

/// Create a copy of PlanListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(PlanListModel(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PlanModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanListModel].
extension PlanListModelPatterns on PlanListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanListModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanListModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<PlanModel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanListModel() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<PlanModel> items)  $default,) {final _that = this;
switch (_that) {
case _PlanListModel():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'items')  List<PlanModel> items)?  $default,) {final _that = this;
switch (_that) {
case _PlanListModel() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanListModel implements PlanListModel {
  const _PlanListModel({@JsonKey(name: 'items')  List<PlanModel> items = const <PlanModel>[]}): _items = items;
  factory _PlanListModel.fromJson(Map<String, dynamic> json) => _$PlanListModelFromJson(json);

 final  List<PlanModel> _items;
@override@JsonKey(name: 'items') List<PlanModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of PlanListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanListModelCopyWith<_PlanListModel> get copyWith => __$PlanListModelCopyWithImpl<_PlanListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanListModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanListModel&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'PlanListModel(items: $items)';
}


}

/// @nodoc
abstract mixin class _$PlanListModelCopyWith<$Res> implements $PlanListModelCopyWith<$Res> {
  factory _$PlanListModelCopyWith(_PlanListModel value, $Res Function(_PlanListModel) _then) = __$PlanListModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'items') List<PlanModel> items
});




}
/// @nodoc
class __$PlanListModelCopyWithImpl<$Res>
    implements _$PlanListModelCopyWith<$Res> {
  __$PlanListModelCopyWithImpl(this._self, this._then);

  final _PlanListModel _self;
  final $Res Function(_PlanListModel) _then;

/// Create a copy of PlanListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_PlanListModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PlanModel>,
  ));
}


}


/// @nodoc
mixin _$BalanceModel {

@JsonKey(name: 'balance_seconds') int get balanceSeconds;@JsonKey(name: 'plan') PlanModel? get plan;@JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown) SubscriptionStatus get status;@JsonKey(name: 'period_end') DateTime? get periodEnd;@JsonKey(name: 'cancel_at_period_end') bool get cancelAtPeriodEnd;
/// Create a copy of BalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceModelCopyWith<BalanceModel> get copyWith => _$BalanceModelCopyWithImpl<BalanceModel>(this as BalanceModel, _$identity);

  /// Serializes this BalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BalanceModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceModel&&(identical(other.balanceSeconds, _this.balanceSeconds) || other.balanceSeconds == _this.balanceSeconds)&&(identical(other.plan, _this.plan) || other.plan == _this.plan)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.periodEnd, _this.periodEnd) || other.periodEnd == _this.periodEnd)&&(identical(other.cancelAtPeriodEnd, _this.cancelAtPeriodEnd) || other.cancelAtPeriodEnd == _this.cancelAtPeriodEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BalanceModel;
  return Object.hash(runtimeType,_this.balanceSeconds,_this.plan,_this.status,_this.periodEnd,_this.cancelAtPeriodEnd);
}

@override
String toString() {
  final _this = this as BalanceModel;
  return 'BalanceModel(balanceSeconds: ${_this.balanceSeconds}, plan: ${_this.plan}, status: ${_this.status}, periodEnd: ${_this.periodEnd}, cancelAtPeriodEnd: ${_this.cancelAtPeriodEnd})';
}


}

/// @nodoc
abstract mixin class $BalanceModelCopyWith<$Res>  {
  factory $BalanceModelCopyWith(BalanceModel value, $Res Function(BalanceModel) _then) = _$BalanceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'balance_seconds') int balanceSeconds,@JsonKey(name: 'plan') PlanModel? plan,@JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown) SubscriptionStatus status,@JsonKey(name: 'period_end') DateTime? periodEnd,@JsonKey(name: 'cancel_at_period_end') bool cancelAtPeriodEnd
});


$PlanModelCopyWith<$Res>? get plan;

}
/// @nodoc
class _$BalanceModelCopyWithImpl<$Res>
    implements $BalanceModelCopyWith<$Res> {
  _$BalanceModelCopyWithImpl(this._self, this._then);

  final BalanceModel _self;
  final $Res Function(BalanceModel) _then;

/// Create a copy of BalanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balanceSeconds = null,Object? plan = freezed,Object? status = null,Object? periodEnd = freezed,Object? cancelAtPeriodEnd = null,}) {
  return _then(BalanceModel(
balanceSeconds: null == balanceSeconds ? _self.balanceSeconds : balanceSeconds // ignore: cast_nullable_to_non_nullable
as int,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as PlanModel?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,periodEnd: freezed == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelAtPeriodEnd: null == cancelAtPeriodEnd ? _self.cancelAtPeriodEnd : cancelAtPeriodEnd // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BalanceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanModelCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $PlanModelCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [BalanceModel].
extension BalanceModelPatterns on BalanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceModel value)  $default,){
final _that = this;
switch (_that) {
case _BalanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'balance_seconds')  int balanceSeconds, @JsonKey(name: 'plan')  PlanModel? plan, @JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown)  SubscriptionStatus status, @JsonKey(name: 'period_end')  DateTime? periodEnd, @JsonKey(name: 'cancel_at_period_end')  bool cancelAtPeriodEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'balance_seconds')  int balanceSeconds, @JsonKey(name: 'plan')  PlanModel? plan, @JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown)  SubscriptionStatus status, @JsonKey(name: 'period_end')  DateTime? periodEnd, @JsonKey(name: 'cancel_at_period_end')  bool cancelAtPeriodEnd)  $default,) {final _that = this;
switch (_that) {
case _BalanceModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'balance_seconds')  int balanceSeconds, @JsonKey(name: 'plan')  PlanModel? plan, @JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown)  SubscriptionStatus status, @JsonKey(name: 'period_end')  DateTime? periodEnd, @JsonKey(name: 'cancel_at_period_end')  bool cancelAtPeriodEnd)?  $default,) {final _that = this;
switch (_that) {
case _BalanceModel() when $default != null:
return $default(_that.balanceSeconds,_that.plan,_that.status,_that.periodEnd,_that.cancelAtPeriodEnd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BalanceModel extends BalanceModel {
  const _BalanceModel({@JsonKey(name: 'balance_seconds') this.balanceSeconds = 0, @JsonKey(name: 'plan') this.plan, @JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown) this.status = SubscriptionStatus.none, @JsonKey(name: 'period_end') this.periodEnd, @JsonKey(name: 'cancel_at_period_end') this.cancelAtPeriodEnd = false}): super._();
  factory _BalanceModel.fromJson(Map<String, dynamic> json) => _$BalanceModelFromJson(json);

@override@JsonKey(name: 'balance_seconds') final  int balanceSeconds;
@override@JsonKey(name: 'plan') final  PlanModel? plan;
@override@JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown) final  SubscriptionStatus status;
@override@JsonKey(name: 'period_end') final  DateTime? periodEnd;
@override@JsonKey(name: 'cancel_at_period_end') final  bool cancelAtPeriodEnd;

/// Create a copy of BalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceModelCopyWith<_BalanceModel> get copyWith => __$BalanceModelCopyWithImpl<_BalanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BalanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceModel&&(identical(other.balanceSeconds, balanceSeconds) || other.balanceSeconds == balanceSeconds)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.cancelAtPeriodEnd, cancelAtPeriodEnd) || other.cancelAtPeriodEnd == cancelAtPeriodEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,balanceSeconds,plan,status,periodEnd,cancelAtPeriodEnd);
}

@override
String toString() {
    return 'BalanceModel(balanceSeconds: $balanceSeconds, plan: $plan, status: $status, periodEnd: $periodEnd, cancelAtPeriodEnd: $cancelAtPeriodEnd)';
}


}

/// @nodoc
abstract mixin class _$BalanceModelCopyWith<$Res> implements $BalanceModelCopyWith<$Res> {
  factory _$BalanceModelCopyWith(_BalanceModel value, $Res Function(_BalanceModel) _then) = __$BalanceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'balance_seconds') int balanceSeconds,@JsonKey(name: 'plan') PlanModel? plan,@JsonKey(name: 'status', unknownEnumValue: SubscriptionStatus.unknown) SubscriptionStatus status,@JsonKey(name: 'period_end') DateTime? periodEnd,@JsonKey(name: 'cancel_at_period_end') bool cancelAtPeriodEnd
});


@override $PlanModelCopyWith<$Res>? get plan;

}
/// @nodoc
class __$BalanceModelCopyWithImpl<$Res>
    implements _$BalanceModelCopyWith<$Res> {
  __$BalanceModelCopyWithImpl(this._self, this._then);

  final _BalanceModel _self;
  final $Res Function(_BalanceModel) _then;

/// Create a copy of BalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balanceSeconds = null,Object? plan = freezed,Object? status = null,Object? periodEnd = freezed,Object? cancelAtPeriodEnd = null,}) {
  return _then(_BalanceModel(
balanceSeconds: null == balanceSeconds ? _self.balanceSeconds : balanceSeconds // ignore: cast_nullable_to_non_nullable
as int,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as PlanModel?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,periodEnd: freezed == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelAtPeriodEnd: null == cancelAtPeriodEnd ? _self.cancelAtPeriodEnd : cancelAtPeriodEnd // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BalanceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanModelCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $PlanModelCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// @nodoc
mixin _$BalanceResponseModel {

@JsonKey(name: 'balance') BalanceModel get balance;
/// Create a copy of BalanceResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceResponseModelCopyWith<BalanceResponseModel> get copyWith => _$BalanceResponseModelCopyWithImpl<BalanceResponseModel>(this as BalanceResponseModel, _$identity);

  /// Serializes this BalanceResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BalanceResponseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceResponseModel&&(identical(other.balance, _this.balance) || other.balance == _this.balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BalanceResponseModel;
  return Object.hash(runtimeType,_this.balance);
}

@override
String toString() {
  final _this = this as BalanceResponseModel;
  return 'BalanceResponseModel(balance: ${_this.balance})';
}


}

/// @nodoc
abstract mixin class $BalanceResponseModelCopyWith<$Res>  {
  factory $BalanceResponseModelCopyWith(BalanceResponseModel value, $Res Function(BalanceResponseModel) _then) = _$BalanceResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'balance') BalanceModel balance
});


$BalanceModelCopyWith<$Res> get balance;

}
/// @nodoc
class _$BalanceResponseModelCopyWithImpl<$Res>
    implements $BalanceResponseModelCopyWith<$Res> {
  _$BalanceResponseModelCopyWithImpl(this._self, this._then);

  final BalanceResponseModel _self;
  final $Res Function(BalanceResponseModel) _then;

/// Create a copy of BalanceResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,}) {
  return _then(BalanceResponseModel(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as BalanceModel,
  ));
}
/// Create a copy of BalanceResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceModelCopyWith<$Res> get balance {
  
  return $BalanceModelCopyWith<$Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}
}


/// Adds pattern-matching-related methods to [BalanceResponseModel].
extension BalanceResponseModelPatterns on BalanceResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _BalanceResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'balance')  BalanceModel balance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceResponseModel() when $default != null:
return $default(_that.balance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'balance')  BalanceModel balance)  $default,) {final _that = this;
switch (_that) {
case _BalanceResponseModel():
return $default(_that.balance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'balance')  BalanceModel balance)?  $default,) {final _that = this;
switch (_that) {
case _BalanceResponseModel() when $default != null:
return $default(_that.balance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BalanceResponseModel implements BalanceResponseModel {
  const _BalanceResponseModel({@JsonKey(name: 'balance') this.balance = const BalanceModel()});
  factory _BalanceResponseModel.fromJson(Map<String, dynamic> json) => _$BalanceResponseModelFromJson(json);

@override@JsonKey(name: 'balance') final  BalanceModel balance;

/// Create a copy of BalanceResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceResponseModelCopyWith<_BalanceResponseModel> get copyWith => __$BalanceResponseModelCopyWithImpl<_BalanceResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BalanceResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceResponseModel&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,balance);
}

@override
String toString() {
    return 'BalanceResponseModel(balance: $balance)';
}


}

/// @nodoc
abstract mixin class _$BalanceResponseModelCopyWith<$Res> implements $BalanceResponseModelCopyWith<$Res> {
  factory _$BalanceResponseModelCopyWith(_BalanceResponseModel value, $Res Function(_BalanceResponseModel) _then) = __$BalanceResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'balance') BalanceModel balance
});


@override $BalanceModelCopyWith<$Res> get balance;

}
/// @nodoc
class __$BalanceResponseModelCopyWithImpl<$Res>
    implements _$BalanceResponseModelCopyWith<$Res> {
  __$BalanceResponseModelCopyWithImpl(this._self, this._then);

  final _BalanceResponseModel _self;
  final $Res Function(_BalanceResponseModel) _then;

/// Create a copy of BalanceResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,}) {
  return _then(_BalanceResponseModel(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as BalanceModel,
  ));
}

/// Create a copy of BalanceResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceModelCopyWith<$Res> get balance {
  
  return $BalanceModelCopyWith<$Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}
}

// dart format on
