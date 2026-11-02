// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'held_file_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeldFileModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'name') String get name;@JsonKey(name: 'size_bytes') int get sizeBytes;@JsonKey(name: 'state') String get state;@JsonKey(name: 'expires_at') String? get expiresAt;@JsonKey(name: 'deletable') bool get deletable;
/// Create a copy of HeldFileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeldFileModelCopyWith<HeldFileModel> get copyWith => _$HeldFileModelCopyWithImpl<HeldFileModel>(this as HeldFileModel, _$identity);

  /// Serializes this HeldFileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HeldFileModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeldFileModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.deletable, _this.deletable) || other.deletable == _this.deletable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HeldFileModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.sizeBytes,_this.state,_this.expiresAt,_this.deletable);
}

@override
String toString() {
  final _this = this as HeldFileModel;
  return 'HeldFileModel(id: ${_this.id}, name: ${_this.name}, sizeBytes: ${_this.sizeBytes}, state: ${_this.state}, expiresAt: ${_this.expiresAt}, deletable: ${_this.deletable})';
}


}

/// @nodoc
abstract mixin class $HeldFileModelCopyWith<$Res>  {
  factory $HeldFileModelCopyWith(HeldFileModel value, $Res Function(HeldFileModel) _then) = _$HeldFileModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'size_bytes') int sizeBytes,@JsonKey(name: 'state') String state,@JsonKey(name: 'expires_at') String? expiresAt,@JsonKey(name: 'deletable') bool deletable
});




}
/// @nodoc
class _$HeldFileModelCopyWithImpl<$Res>
    implements $HeldFileModelCopyWith<$Res> {
  _$HeldFileModelCopyWithImpl(this._self, this._then);

  final HeldFileModel _self;
  final $Res Function(HeldFileModel) _then;

/// Create a copy of HeldFileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sizeBytes = null,Object? state = null,Object? expiresAt = freezed,Object? deletable = null,}) {
  return _then(HeldFileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,deletable: null == deletable ? _self.deletable : deletable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HeldFileModel].
extension HeldFileModelPatterns on HeldFileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeldFileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeldFileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeldFileModel value)  $default,){
final _that = this;
switch (_that) {
case _HeldFileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeldFileModel value)?  $default,){
final _that = this;
switch (_that) {
case _HeldFileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'state')  String state, @JsonKey(name: 'expires_at')  String? expiresAt, @JsonKey(name: 'deletable')  bool deletable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeldFileModel() when $default != null:
return $default(_that.id,_that.name,_that.sizeBytes,_that.state,_that.expiresAt,_that.deletable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'state')  String state, @JsonKey(name: 'expires_at')  String? expiresAt, @JsonKey(name: 'deletable')  bool deletable)  $default,) {final _that = this;
switch (_that) {
case _HeldFileModel():
return $default(_that.id,_that.name,_that.sizeBytes,_that.state,_that.expiresAt,_that.deletable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'size_bytes')  int sizeBytes, @JsonKey(name: 'state')  String state, @JsonKey(name: 'expires_at')  String? expiresAt, @JsonKey(name: 'deletable')  bool deletable)?  $default,) {final _that = this;
switch (_that) {
case _HeldFileModel() when $default != null:
return $default(_that.id,_that.name,_that.sizeBytes,_that.state,_that.expiresAt,_that.deletable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeldFileModel extends HeldFileModel {
  const _HeldFileModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'name') this.name = '', @JsonKey(name: 'size_bytes') this.sizeBytes = 0, @JsonKey(name: 'state') this.state = '', @JsonKey(name: 'expires_at') this.expiresAt, @JsonKey(name: 'deletable') this.deletable = false}): super._();
  factory _HeldFileModel.fromJson(Map<String, dynamic> json) => _$HeldFileModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'size_bytes') final  int sizeBytes;
@override@JsonKey(name: 'state') final  String state;
@override@JsonKey(name: 'expires_at') final  String? expiresAt;
@override@JsonKey(name: 'deletable') final  bool deletable;

/// Create a copy of HeldFileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeldFileModelCopyWith<_HeldFileModel> get copyWith => __$HeldFileModelCopyWithImpl<_HeldFileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeldFileModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeldFileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.state, state) || other.state == state)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deletable, deletable) || other.deletable == deletable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,sizeBytes,state,expiresAt,deletable);
}

@override
String toString() {
    return 'HeldFileModel(id: $id, name: $name, sizeBytes: $sizeBytes, state: $state, expiresAt: $expiresAt, deletable: $deletable)';
}


}

/// @nodoc
abstract mixin class _$HeldFileModelCopyWith<$Res> implements $HeldFileModelCopyWith<$Res> {
  factory _$HeldFileModelCopyWith(_HeldFileModel value, $Res Function(_HeldFileModel) _then) = __$HeldFileModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'size_bytes') int sizeBytes,@JsonKey(name: 'state') String state,@JsonKey(name: 'expires_at') String? expiresAt,@JsonKey(name: 'deletable') bool deletable
});




}
/// @nodoc
class __$HeldFileModelCopyWithImpl<$Res>
    implements _$HeldFileModelCopyWith<$Res> {
  __$HeldFileModelCopyWithImpl(this._self, this._then);

  final _HeldFileModel _self;
  final $Res Function(_HeldFileModel) _then;

/// Create a copy of HeldFileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sizeBytes = null,Object? state = null,Object? expiresAt = freezed,Object? deletable = null,}) {
  return _then(_HeldFileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,deletable: null == deletable ? _self.deletable : deletable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
