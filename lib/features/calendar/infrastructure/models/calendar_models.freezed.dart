// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarAccountModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'email') String get email;@JsonKey(name: 'needs_reconnect') bool get needsReconnect;
/// Create a copy of CalendarAccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarAccountModelCopyWith<CalendarAccountModel> get copyWith => _$CalendarAccountModelCopyWithImpl<CalendarAccountModel>(this as CalendarAccountModel, _$identity);

  /// Serializes this CalendarAccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalendarAccountModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarAccountModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.needsReconnect, _this.needsReconnect) || other.needsReconnect == _this.needsReconnect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalendarAccountModel;
  return Object.hash(runtimeType,_this.id,_this.email,_this.needsReconnect);
}

@override
String toString() {
  final _this = this as CalendarAccountModel;
  return 'CalendarAccountModel(id: ${_this.id}, email: ${_this.email}, needsReconnect: ${_this.needsReconnect})';
}


}

/// @nodoc
abstract mixin class $CalendarAccountModelCopyWith<$Res>  {
  factory $CalendarAccountModelCopyWith(CalendarAccountModel value, $Res Function(CalendarAccountModel) _then) = _$CalendarAccountModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'email') String email,@JsonKey(name: 'needs_reconnect') bool needsReconnect
});




}
/// @nodoc
class _$CalendarAccountModelCopyWithImpl<$Res>
    implements $CalendarAccountModelCopyWith<$Res> {
  _$CalendarAccountModelCopyWithImpl(this._self, this._then);

  final CalendarAccountModel _self;
  final $Res Function(CalendarAccountModel) _then;

/// Create a copy of CalendarAccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? needsReconnect = null,}) {
  return _then(CalendarAccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,needsReconnect: null == needsReconnect ? _self.needsReconnect : needsReconnect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarAccountModel].
extension CalendarAccountModelPatterns on CalendarAccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarAccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarAccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarAccountModel value)  $default,){
final _that = this;
switch (_that) {
case _CalendarAccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarAccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarAccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'email')  String email, @JsonKey(name: 'needs_reconnect')  bool needsReconnect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarAccountModel() when $default != null:
return $default(_that.id,_that.email,_that.needsReconnect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'email')  String email, @JsonKey(name: 'needs_reconnect')  bool needsReconnect)  $default,) {final _that = this;
switch (_that) {
case _CalendarAccountModel():
return $default(_that.id,_that.email,_that.needsReconnect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'email')  String email, @JsonKey(name: 'needs_reconnect')  bool needsReconnect)?  $default,) {final _that = this;
switch (_that) {
case _CalendarAccountModel() when $default != null:
return $default(_that.id,_that.email,_that.needsReconnect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarAccountModel implements CalendarAccountModel {
  const _CalendarAccountModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'email') this.email = '', @JsonKey(name: 'needs_reconnect') this.needsReconnect = false});
  factory _CalendarAccountModel.fromJson(Map<String, dynamic> json) => _$CalendarAccountModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'email') final  String email;
@override@JsonKey(name: 'needs_reconnect') final  bool needsReconnect;

/// Create a copy of CalendarAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarAccountModelCopyWith<_CalendarAccountModel> get copyWith => __$CalendarAccountModelCopyWithImpl<_CalendarAccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarAccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarAccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.needsReconnect, needsReconnect) || other.needsReconnect == needsReconnect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,needsReconnect);
}

@override
String toString() {
    return 'CalendarAccountModel(id: $id, email: $email, needsReconnect: $needsReconnect)';
}


}

/// @nodoc
abstract mixin class _$CalendarAccountModelCopyWith<$Res> implements $CalendarAccountModelCopyWith<$Res> {
  factory _$CalendarAccountModelCopyWith(_CalendarAccountModel value, $Res Function(_CalendarAccountModel) _then) = __$CalendarAccountModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'email') String email,@JsonKey(name: 'needs_reconnect') bool needsReconnect
});




}
/// @nodoc
class __$CalendarAccountModelCopyWithImpl<$Res>
    implements _$CalendarAccountModelCopyWith<$Res> {
  __$CalendarAccountModelCopyWithImpl(this._self, this._then);

  final _CalendarAccountModel _self;
  final $Res Function(_CalendarAccountModel) _then;

/// Create a copy of CalendarAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? needsReconnect = null,}) {
  return _then(_CalendarAccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,needsReconnect: null == needsReconnect ? _self.needsReconnect : needsReconnect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CalendarStateModel {

@JsonKey(name: 'available') bool get available;@JsonKey(name: 'accounts') List<CalendarAccountModel> get accounts;
/// Create a copy of CalendarStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateModelCopyWith<CalendarStateModel> get copyWith => _$CalendarStateModelCopyWithImpl<CalendarStateModel>(this as CalendarStateModel, _$identity);

  /// Serializes this CalendarStateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalendarStateModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarStateModel&&(identical(other.available, _this.available) || other.available == _this.available)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalendarStateModel;
  return Object.hash(runtimeType,_this.available,const DeepCollectionEquality().hash(_this.accounts));
}

@override
String toString() {
  final _this = this as CalendarStateModel;
  return 'CalendarStateModel(available: ${_this.available}, accounts: ${_this.accounts})';
}


}

/// @nodoc
abstract mixin class $CalendarStateModelCopyWith<$Res>  {
  factory $CalendarStateModelCopyWith(CalendarStateModel value, $Res Function(CalendarStateModel) _then) = _$CalendarStateModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'available') bool available,@JsonKey(name: 'accounts') List<CalendarAccountModel> accounts
});




}
/// @nodoc
class _$CalendarStateModelCopyWithImpl<$Res>
    implements $CalendarStateModelCopyWith<$Res> {
  _$CalendarStateModelCopyWithImpl(this._self, this._then);

  final CalendarStateModel _self;
  final $Res Function(CalendarStateModel) _then;

/// Create a copy of CalendarStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? available = null,Object? accounts = null,}) {
  return _then(CalendarStateModel(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<CalendarAccountModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarStateModel].
extension CalendarStateModelPatterns on CalendarStateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarStateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarStateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarStateModel value)  $default,){
final _that = this;
switch (_that) {
case _CalendarStateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarStateModel value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarStateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'available')  bool available, @JsonKey(name: 'accounts')  List<CalendarAccountModel> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarStateModel() when $default != null:
return $default(_that.available,_that.accounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'available')  bool available, @JsonKey(name: 'accounts')  List<CalendarAccountModel> accounts)  $default,) {final _that = this;
switch (_that) {
case _CalendarStateModel():
return $default(_that.available,_that.accounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'available')  bool available, @JsonKey(name: 'accounts')  List<CalendarAccountModel> accounts)?  $default,) {final _that = this;
switch (_that) {
case _CalendarStateModel() when $default != null:
return $default(_that.available,_that.accounts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarStateModel implements CalendarStateModel {
  const _CalendarStateModel({@JsonKey(name: 'available') this.available = false, @JsonKey(name: 'accounts')  List<CalendarAccountModel> accounts = const <CalendarAccountModel>[]}): _accounts = accounts;
  factory _CalendarStateModel.fromJson(Map<String, dynamic> json) => _$CalendarStateModelFromJson(json);

@override@JsonKey(name: 'available') final  bool available;
 final  List<CalendarAccountModel> _accounts;
@override@JsonKey(name: 'accounts') List<CalendarAccountModel> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of CalendarStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarStateModelCopyWith<_CalendarStateModel> get copyWith => __$CalendarStateModelCopyWithImpl<_CalendarStateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarStateModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarStateModel&&(identical(other.available, available) || other.available == available)&&const DeepCollectionEquality().equals(other.accounts, _accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,available,const DeepCollectionEquality().hash(_accounts));
}

@override
String toString() {
    return 'CalendarStateModel(available: $available, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$CalendarStateModelCopyWith<$Res> implements $CalendarStateModelCopyWith<$Res> {
  factory _$CalendarStateModelCopyWith(_CalendarStateModel value, $Res Function(_CalendarStateModel) _then) = __$CalendarStateModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'available') bool available,@JsonKey(name: 'accounts') List<CalendarAccountModel> accounts
});




}
/// @nodoc
class __$CalendarStateModelCopyWithImpl<$Res>
    implements _$CalendarStateModelCopyWith<$Res> {
  __$CalendarStateModelCopyWithImpl(this._self, this._then);

  final _CalendarStateModel _self;
  final $Res Function(_CalendarStateModel) _then;

/// Create a copy of CalendarStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? available = null,Object? accounts = null,}) {
  return _then(_CalendarStateModel(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<CalendarAccountModel>,
  ));
}


}


/// @nodoc
mixin _$CalendarEventModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'title') String get title;@JsonKey(name: 'starts_at') DateTime? get startsAt;@JsonKey(name: 'ends_at') DateTime? get endsAt;@JsonKey(name: 'join_url') String get joinUrl;@JsonKey(name: 'platform') String get platform;
/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventModelCopyWith<CalendarEventModel> get copyWith => _$CalendarEventModelCopyWithImpl<CalendarEventModel>(this as CalendarEventModel, _$identity);

  /// Serializes this CalendarEventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalendarEventModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEventModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.joinUrl, _this.joinUrl) || other.joinUrl == _this.joinUrl)&&(identical(other.platform, _this.platform) || other.platform == _this.platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalendarEventModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.startsAt,_this.endsAt,_this.joinUrl,_this.platform);
}

@override
String toString() {
  final _this = this as CalendarEventModel;
  return 'CalendarEventModel(id: ${_this.id}, title: ${_this.title}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, joinUrl: ${_this.joinUrl}, platform: ${_this.platform})';
}


}

/// @nodoc
abstract mixin class $CalendarEventModelCopyWith<$Res>  {
  factory $CalendarEventModelCopyWith(CalendarEventModel value, $Res Function(CalendarEventModel) _then) = _$CalendarEventModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'title') String title,@JsonKey(name: 'starts_at') DateTime? startsAt,@JsonKey(name: 'ends_at') DateTime? endsAt,@JsonKey(name: 'join_url') String joinUrl,@JsonKey(name: 'platform') String platform
});




}
/// @nodoc
class _$CalendarEventModelCopyWithImpl<$Res>
    implements $CalendarEventModelCopyWith<$Res> {
  _$CalendarEventModelCopyWithImpl(this._self, this._then);

  final CalendarEventModel _self;
  final $Res Function(CalendarEventModel) _then;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? joinUrl = null,Object? platform = null,}) {
  return _then(CalendarEventModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinUrl: null == joinUrl ? _self.joinUrl : joinUrl // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarEventModel].
extension CalendarEventModelPatterns on CalendarEventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEventModel value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEventModel value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'starts_at')  DateTime? startsAt, @JsonKey(name: 'ends_at')  DateTime? endsAt, @JsonKey(name: 'join_url')  String joinUrl, @JsonKey(name: 'platform')  String platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEventModel() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.joinUrl,_that.platform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'starts_at')  DateTime? startsAt, @JsonKey(name: 'ends_at')  DateTime? endsAt, @JsonKey(name: 'join_url')  String joinUrl, @JsonKey(name: 'platform')  String platform)  $default,) {final _that = this;
switch (_that) {
case _CalendarEventModel():
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.joinUrl,_that.platform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'starts_at')  DateTime? startsAt, @JsonKey(name: 'ends_at')  DateTime? endsAt, @JsonKey(name: 'join_url')  String joinUrl, @JsonKey(name: 'platform')  String platform)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEventModel() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.joinUrl,_that.platform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarEventModel extends CalendarEventModel {
  const _CalendarEventModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'title') this.title = '', @JsonKey(name: 'starts_at') this.startsAt, @JsonKey(name: 'ends_at') this.endsAt, @JsonKey(name: 'join_url') this.joinUrl = '', @JsonKey(name: 'platform') this.platform = ''}): super._();
  factory _CalendarEventModel.fromJson(Map<String, dynamic> json) => _$CalendarEventModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'starts_at') final  DateTime? startsAt;
@override@JsonKey(name: 'ends_at') final  DateTime? endsAt;
@override@JsonKey(name: 'join_url') final  String joinUrl;
@override@JsonKey(name: 'platform') final  String platform;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEventModelCopyWith<_CalendarEventModel> get copyWith => __$CalendarEventModelCopyWithImpl<_CalendarEventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarEventModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.joinUrl, joinUrl) || other.joinUrl == joinUrl)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,startsAt,endsAt,joinUrl,platform);
}

@override
String toString() {
    return 'CalendarEventModel(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, joinUrl: $joinUrl, platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$CalendarEventModelCopyWith<$Res> implements $CalendarEventModelCopyWith<$Res> {
  factory _$CalendarEventModelCopyWith(_CalendarEventModel value, $Res Function(_CalendarEventModel) _then) = __$CalendarEventModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'title') String title,@JsonKey(name: 'starts_at') DateTime? startsAt,@JsonKey(name: 'ends_at') DateTime? endsAt,@JsonKey(name: 'join_url') String joinUrl,@JsonKey(name: 'platform') String platform
});




}
/// @nodoc
class __$CalendarEventModelCopyWithImpl<$Res>
    implements _$CalendarEventModelCopyWith<$Res> {
  __$CalendarEventModelCopyWithImpl(this._self, this._then);

  final _CalendarEventModel _self;
  final $Res Function(_CalendarEventModel) _then;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? joinUrl = null,Object? platform = null,}) {
  return _then(_CalendarEventModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinUrl: null == joinUrl ? _self.joinUrl : joinUrl // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CalendarEventListModel {

@JsonKey(name: 'items') List<CalendarEventModel> get items;
/// Create a copy of CalendarEventListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventListModelCopyWith<CalendarEventListModel> get copyWith => _$CalendarEventListModelCopyWithImpl<CalendarEventListModel>(this as CalendarEventListModel, _$identity);

  /// Serializes this CalendarEventListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CalendarEventListModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEventListModel&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CalendarEventListModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as CalendarEventListModel;
  return 'CalendarEventListModel(items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $CalendarEventListModelCopyWith<$Res>  {
  factory $CalendarEventListModelCopyWith(CalendarEventListModel value, $Res Function(CalendarEventListModel) _then) = _$CalendarEventListModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'items') List<CalendarEventModel> items
});




}
/// @nodoc
class _$CalendarEventListModelCopyWithImpl<$Res>
    implements $CalendarEventListModelCopyWith<$Res> {
  _$CalendarEventListModelCopyWithImpl(this._self, this._then);

  final CalendarEventListModel _self;
  final $Res Function(CalendarEventListModel) _then;

/// Create a copy of CalendarEventListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(CalendarEventListModel(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CalendarEventModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarEventListModel].
extension CalendarEventListModelPatterns on CalendarEventListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEventListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEventListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEventListModel value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEventListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEventListModel value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEventListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<CalendarEventModel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEventListModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<CalendarEventModel> items)  $default,) {final _that = this;
switch (_that) {
case _CalendarEventListModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'items')  List<CalendarEventModel> items)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEventListModel() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarEventListModel implements CalendarEventListModel {
  const _CalendarEventListModel({@JsonKey(name: 'items')  List<CalendarEventModel> items = const <CalendarEventModel>[]}): _items = items;
  factory _CalendarEventListModel.fromJson(Map<String, dynamic> json) => _$CalendarEventListModelFromJson(json);

 final  List<CalendarEventModel> _items;
@override@JsonKey(name: 'items') List<CalendarEventModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CalendarEventListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEventListModelCopyWith<_CalendarEventListModel> get copyWith => __$CalendarEventListModelCopyWithImpl<_CalendarEventListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarEventListModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEventListModel&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'CalendarEventListModel(items: $items)';
}


}

/// @nodoc
abstract mixin class _$CalendarEventListModelCopyWith<$Res> implements $CalendarEventListModelCopyWith<$Res> {
  factory _$CalendarEventListModelCopyWith(_CalendarEventListModel value, $Res Function(_CalendarEventListModel) _then) = __$CalendarEventListModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'items') List<CalendarEventModel> items
});




}
/// @nodoc
class __$CalendarEventListModelCopyWithImpl<$Res>
    implements _$CalendarEventListModelCopyWith<$Res> {
  __$CalendarEventListModelCopyWithImpl(this._self, this._then);

  final _CalendarEventListModel _self;
  final $Res Function(_CalendarEventListModel) _then;

/// Create a copy of CalendarEventListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_CalendarEventListModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CalendarEventModel>,
  ));
}


}

// dart format on
