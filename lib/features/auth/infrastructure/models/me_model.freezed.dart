// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'me_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'email') String get email;@JsonKey(name: 'full_name') String get fullName;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserModel;
  return Object.hash(runtimeType,_this.id,_this.email,_this.fullName);
}

@override
String toString() {
  final _this = this as UserModel;
  return 'UserModel(id: ${_this.id}, email: ${_this.email}, fullName: ${_this.fullName})';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'email') String email,@JsonKey(name: 'full_name') String fullName
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? fullName = null,}) {
  return _then(UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'email')  String email, @JsonKey(name: 'full_name')  String fullName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.fullName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'email')  String email, @JsonKey(name: 'full_name')  String fullName)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.fullName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'email')  String email, @JsonKey(name: 'full_name')  String fullName)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.fullName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel extends UserModel {
  const _UserModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'email') this.email = '', @JsonKey(name: 'full_name') this.fullName = ''}): super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'email') final  String email;
@override@JsonKey(name: 'full_name') final  String fullName;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,fullName);
}

@override
String toString() {
    return 'UserModel(id: $id, email: $email, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'email') String email,@JsonKey(name: 'full_name') String fullName
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? fullName = null,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WorkspaceModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'name') String get name;@JsonKey(name: 'is_personal') bool get isPersonal;@JsonKey(name: 'balance_seconds') int get balanceSeconds;
/// Create a copy of WorkspaceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkspaceModelCopyWith<WorkspaceModel> get copyWith => _$WorkspaceModelCopyWithImpl<WorkspaceModel>(this as WorkspaceModel, _$identity);

  /// Serializes this WorkspaceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkspaceModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkspaceModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.isPersonal, _this.isPersonal) || other.isPersonal == _this.isPersonal)&&(identical(other.balanceSeconds, _this.balanceSeconds) || other.balanceSeconds == _this.balanceSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkspaceModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.isPersonal,_this.balanceSeconds);
}

@override
String toString() {
  final _this = this as WorkspaceModel;
  return 'WorkspaceModel(id: ${_this.id}, name: ${_this.name}, isPersonal: ${_this.isPersonal}, balanceSeconds: ${_this.balanceSeconds})';
}


}

/// @nodoc
abstract mixin class $WorkspaceModelCopyWith<$Res>  {
  factory $WorkspaceModelCopyWith(WorkspaceModel value, $Res Function(WorkspaceModel) _then) = _$WorkspaceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'is_personal') bool isPersonal,@JsonKey(name: 'balance_seconds') int balanceSeconds
});




}
/// @nodoc
class _$WorkspaceModelCopyWithImpl<$Res>
    implements $WorkspaceModelCopyWith<$Res> {
  _$WorkspaceModelCopyWithImpl(this._self, this._then);

  final WorkspaceModel _self;
  final $Res Function(WorkspaceModel) _then;

/// Create a copy of WorkspaceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isPersonal = null,Object? balanceSeconds = null,}) {
  return _then(WorkspaceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPersonal: null == isPersonal ? _self.isPersonal : isPersonal // ignore: cast_nullable_to_non_nullable
as bool,balanceSeconds: null == balanceSeconds ? _self.balanceSeconds : balanceSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkspaceModel].
extension WorkspaceModelPatterns on WorkspaceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkspaceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkspaceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkspaceModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkspaceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkspaceModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkspaceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'is_personal')  bool isPersonal, @JsonKey(name: 'balance_seconds')  int balanceSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkspaceModel() when $default != null:
return $default(_that.id,_that.name,_that.isPersonal,_that.balanceSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'is_personal')  bool isPersonal, @JsonKey(name: 'balance_seconds')  int balanceSeconds)  $default,) {final _that = this;
switch (_that) {
case _WorkspaceModel():
return $default(_that.id,_that.name,_that.isPersonal,_that.balanceSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'is_personal')  bool isPersonal, @JsonKey(name: 'balance_seconds')  int balanceSeconds)?  $default,) {final _that = this;
switch (_that) {
case _WorkspaceModel() when $default != null:
return $default(_that.id,_that.name,_that.isPersonal,_that.balanceSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkspaceModel extends WorkspaceModel {
  const _WorkspaceModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'name') this.name = '', @JsonKey(name: 'is_personal') this.isPersonal = false, @JsonKey(name: 'balance_seconds') this.balanceSeconds = 0}): super._();
  factory _WorkspaceModel.fromJson(Map<String, dynamic> json) => _$WorkspaceModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'is_personal') final  bool isPersonal;
@override@JsonKey(name: 'balance_seconds') final  int balanceSeconds;

/// Create a copy of WorkspaceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkspaceModelCopyWith<_WorkspaceModel> get copyWith => __$WorkspaceModelCopyWithImpl<_WorkspaceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkspaceModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkspaceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPersonal, isPersonal) || other.isPersonal == isPersonal)&&(identical(other.balanceSeconds, balanceSeconds) || other.balanceSeconds == balanceSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,isPersonal,balanceSeconds);
}

@override
String toString() {
    return 'WorkspaceModel(id: $id, name: $name, isPersonal: $isPersonal, balanceSeconds: $balanceSeconds)';
}


}

/// @nodoc
abstract mixin class _$WorkspaceModelCopyWith<$Res> implements $WorkspaceModelCopyWith<$Res> {
  factory _$WorkspaceModelCopyWith(_WorkspaceModel value, $Res Function(_WorkspaceModel) _then) = __$WorkspaceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'is_personal') bool isPersonal,@JsonKey(name: 'balance_seconds') int balanceSeconds
});




}
/// @nodoc
class __$WorkspaceModelCopyWithImpl<$Res>
    implements _$WorkspaceModelCopyWith<$Res> {
  __$WorkspaceModelCopyWithImpl(this._self, this._then);

  final _WorkspaceModel _self;
  final $Res Function(_WorkspaceModel) _then;

/// Create a copy of WorkspaceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isPersonal = null,Object? balanceSeconds = null,}) {
  return _then(_WorkspaceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPersonal: null == isPersonal ? _self.isPersonal : isPersonal // ignore: cast_nullable_to_non_nullable
as bool,balanceSeconds: null == balanceSeconds ? _self.balanceSeconds : balanceSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MeModel {

@JsonKey(name: 'user') UserModel get user;@JsonKey(name: 'workspaces') List<WorkspaceModel> get workspaces;
/// Create a copy of MeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeModelCopyWith<MeModel> get copyWith => _$MeModelCopyWithImpl<MeModel>(this as MeModel, _$identity);

  /// Serializes this MeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeModel&&(identical(other.user, _this.user) || other.user == _this.user)&&const DeepCollectionEquality().equals(other.workspaces, _this.workspaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeModel;
  return Object.hash(runtimeType,_this.user,const DeepCollectionEquality().hash(_this.workspaces));
}

@override
String toString() {
  final _this = this as MeModel;
  return 'MeModel(user: ${_this.user}, workspaces: ${_this.workspaces})';
}


}

/// @nodoc
abstract mixin class $MeModelCopyWith<$Res>  {
  factory $MeModelCopyWith(MeModel value, $Res Function(MeModel) _then) = _$MeModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user') UserModel user,@JsonKey(name: 'workspaces') List<WorkspaceModel> workspaces
});


$UserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$MeModelCopyWithImpl<$Res>
    implements $MeModelCopyWith<$Res> {
  _$MeModelCopyWithImpl(this._self, this._then);

  final MeModel _self;
  final $Res Function(MeModel) _then;

/// Create a copy of MeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? workspaces = null,}) {
  return _then(MeModel(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,workspaces: null == workspaces ? _self.workspaces : workspaces // ignore: cast_nullable_to_non_nullable
as List<WorkspaceModel>,
  ));
}
/// Create a copy of MeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeModel].
extension MeModelPatterns on MeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeModel value)  $default,){
final _that = this;
switch (_that) {
case _MeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeModel value)?  $default,){
final _that = this;
switch (_that) {
case _MeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user')  UserModel user, @JsonKey(name: 'workspaces')  List<WorkspaceModel> workspaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeModel() when $default != null:
return $default(_that.user,_that.workspaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user')  UserModel user, @JsonKey(name: 'workspaces')  List<WorkspaceModel> workspaces)  $default,) {final _that = this;
switch (_that) {
case _MeModel():
return $default(_that.user,_that.workspaces);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user')  UserModel user, @JsonKey(name: 'workspaces')  List<WorkspaceModel> workspaces)?  $default,) {final _that = this;
switch (_that) {
case _MeModel() when $default != null:
return $default(_that.user,_that.workspaces);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeModel extends MeModel {
  const _MeModel({@JsonKey(name: 'user') this.user = const UserModel(), @JsonKey(name: 'workspaces')  List<WorkspaceModel> workspaces = const <WorkspaceModel>[]}): _workspaces = workspaces,super._();
  factory _MeModel.fromJson(Map<String, dynamic> json) => _$MeModelFromJson(json);

@override@JsonKey(name: 'user') final  UserModel user;
 final  List<WorkspaceModel> _workspaces;
@override@JsonKey(name: 'workspaces') List<WorkspaceModel> get workspaces {
  if (_workspaces is EqualUnmodifiableListView) return _workspaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workspaces);
}


/// Create a copy of MeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeModelCopyWith<_MeModel> get copyWith => __$MeModelCopyWithImpl<_MeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeModel&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.workspaces, _workspaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,user,const DeepCollectionEquality().hash(_workspaces));
}

@override
String toString() {
    return 'MeModel(user: $user, workspaces: $workspaces)';
}


}

/// @nodoc
abstract mixin class _$MeModelCopyWith<$Res> implements $MeModelCopyWith<$Res> {
  factory _$MeModelCopyWith(_MeModel value, $Res Function(_MeModel) _then) = __$MeModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user') UserModel user,@JsonKey(name: 'workspaces') List<WorkspaceModel> workspaces
});


@override $UserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$MeModelCopyWithImpl<$Res>
    implements _$MeModelCopyWith<$Res> {
  __$MeModelCopyWithImpl(this._self, this._then);

  final _MeModel _self;
  final $Res Function(_MeModel) _then;

/// Create a copy of MeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? workspaces = null,}) {
  return _then(_MeModel(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,workspaces: null == workspaces ? _self._workspaces : workspaces // ignore: cast_nullable_to_non_nullable
as List<WorkspaceModel>,
  ));
}

/// Create a copy of MeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
