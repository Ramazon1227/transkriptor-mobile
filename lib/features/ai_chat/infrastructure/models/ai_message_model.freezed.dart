// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiMessageModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown) AiRoleModel get role;@JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown) AiStatusModel get status;@JsonKey(name: 'content') String get content;@JsonKey(name: 'error') String? get error;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of AiMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiMessageModelCopyWith<AiMessageModel> get copyWith => _$AiMessageModelCopyWithImpl<AiMessageModel>(this as AiMessageModel, _$identity);

  /// Serializes this AiMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AiMessageModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiMessageModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AiMessageModel;
  return Object.hash(runtimeType,_this.id,_this.role,_this.status,_this.content,_this.error,_this.createdAt);
}

@override
String toString() {
  final _this = this as AiMessageModel;
  return 'AiMessageModel(id: ${_this.id}, role: ${_this.role}, status: ${_this.status}, content: ${_this.content}, error: ${_this.error}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $AiMessageModelCopyWith<$Res>  {
  factory $AiMessageModelCopyWith(AiMessageModel value, $Res Function(AiMessageModel) _then) = _$AiMessageModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown) AiRoleModel role,@JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown) AiStatusModel status,@JsonKey(name: 'content') String content,@JsonKey(name: 'error') String? error,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$AiMessageModelCopyWithImpl<$Res>
    implements $AiMessageModelCopyWith<$Res> {
  _$AiMessageModelCopyWithImpl(this._self, this._then);

  final AiMessageModel _self;
  final $Res Function(AiMessageModel) _then;

/// Create a copy of AiMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? status = null,Object? content = null,Object? error = freezed,Object? createdAt = freezed,}) {
  return _then(AiMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AiRoleModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiStatusModel,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiMessageModel].
extension AiMessageModelPatterns on AiMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _AiMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _AiMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown)  AiRoleModel role, @JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown)  AiStatusModel status, @JsonKey(name: 'content')  String content, @JsonKey(name: 'error')  String? error, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiMessageModel() when $default != null:
return $default(_that.id,_that.role,_that.status,_that.content,_that.error,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown)  AiRoleModel role, @JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown)  AiStatusModel status, @JsonKey(name: 'content')  String content, @JsonKey(name: 'error')  String? error, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AiMessageModel():
return $default(_that.id,_that.role,_that.status,_that.content,_that.error,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown)  AiRoleModel role, @JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown)  AiStatusModel status, @JsonKey(name: 'content')  String content, @JsonKey(name: 'error')  String? error, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AiMessageModel() when $default != null:
return $default(_that.id,_that.role,_that.status,_that.content,_that.error,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiMessageModel extends AiMessageModel {
  const _AiMessageModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown) this.role = AiRoleModel.unknown, @JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown) this.status = AiStatusModel.unknown, @JsonKey(name: 'content') this.content = '', @JsonKey(name: 'error') this.error, @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _AiMessageModel.fromJson(Map<String, dynamic> json) => _$AiMessageModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown) final  AiRoleModel role;
@override@JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown) final  AiStatusModel status;
@override@JsonKey(name: 'content') final  String content;
@override@JsonKey(name: 'error') final  String? error;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of AiMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiMessageModelCopyWith<_AiMessageModel> get copyWith => __$AiMessageModelCopyWithImpl<_AiMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.content, content) || other.content == content)&&(identical(other.error, error) || other.error == error)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,role,status,content,error,createdAt);
}

@override
String toString() {
    return 'AiMessageModel(id: $id, role: $role, status: $status, content: $content, error: $error, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AiMessageModelCopyWith<$Res> implements $AiMessageModelCopyWith<$Res> {
  factory _$AiMessageModelCopyWith(_AiMessageModel value, $Res Function(_AiMessageModel) _then) = __$AiMessageModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown) AiRoleModel role,@JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown) AiStatusModel status,@JsonKey(name: 'content') String content,@JsonKey(name: 'error') String? error,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$AiMessageModelCopyWithImpl<$Res>
    implements _$AiMessageModelCopyWith<$Res> {
  __$AiMessageModelCopyWithImpl(this._self, this._then);

  final _AiMessageModel _self;
  final $Res Function(_AiMessageModel) _then;

/// Create a copy of AiMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? status = null,Object? content = null,Object? error = freezed,Object? createdAt = freezed,}) {
  return _then(_AiMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AiRoleModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiStatusModel,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
