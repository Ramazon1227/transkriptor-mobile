// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FolderModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'name') String get name;@JsonKey(name: 'file_count') int get fileCount;
/// Create a copy of FolderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderModelCopyWith<FolderModel> get copyWith => _$FolderModelCopyWithImpl<FolderModel>(this as FolderModel, _$identity);

  /// Serializes this FolderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FolderModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FolderModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.fileCount, _this.fileCount) || other.fileCount == _this.fileCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FolderModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.fileCount);
}

@override
String toString() {
  final _this = this as FolderModel;
  return 'FolderModel(id: ${_this.id}, name: ${_this.name}, fileCount: ${_this.fileCount})';
}


}

/// @nodoc
abstract mixin class $FolderModelCopyWith<$Res>  {
  factory $FolderModelCopyWith(FolderModel value, $Res Function(FolderModel) _then) = _$FolderModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'file_count') int fileCount
});




}
/// @nodoc
class _$FolderModelCopyWithImpl<$Res>
    implements $FolderModelCopyWith<$Res> {
  _$FolderModelCopyWithImpl(this._self, this._then);

  final FolderModel _self;
  final $Res Function(FolderModel) _then;

/// Create a copy of FolderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? fileCount = null,}) {
  return _then(FolderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fileCount: null == fileCount ? _self.fileCount : fileCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FolderModel].
extension FolderModelPatterns on FolderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FolderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FolderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FolderModel value)  $default,){
final _that = this;
switch (_that) {
case _FolderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FolderModel value)?  $default,){
final _that = this;
switch (_that) {
case _FolderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'file_count')  int fileCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FolderModel() when $default != null:
return $default(_that.id,_that.name,_that.fileCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'file_count')  int fileCount)  $default,) {final _that = this;
switch (_that) {
case _FolderModel():
return $default(_that.id,_that.name,_that.fileCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'file_count')  int fileCount)?  $default,) {final _that = this;
switch (_that) {
case _FolderModel() when $default != null:
return $default(_that.id,_that.name,_that.fileCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FolderModel extends FolderModel {
  const _FolderModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'name') this.name = '', @JsonKey(name: 'file_count') this.fileCount = 0}): super._();
  factory _FolderModel.fromJson(Map<String, dynamic> json) => _$FolderModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'file_count') final  int fileCount;

/// Create a copy of FolderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderModelCopyWith<_FolderModel> get copyWith => __$FolderModelCopyWithImpl<_FolderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FolderModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FolderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.fileCount, fileCount) || other.fileCount == fileCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,fileCount);
}

@override
String toString() {
    return 'FolderModel(id: $id, name: $name, fileCount: $fileCount)';
}


}

/// @nodoc
abstract mixin class _$FolderModelCopyWith<$Res> implements $FolderModelCopyWith<$Res> {
  factory _$FolderModelCopyWith(_FolderModel value, $Res Function(_FolderModel) _then) = __$FolderModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'file_count') int fileCount
});




}
/// @nodoc
class __$FolderModelCopyWithImpl<$Res>
    implements _$FolderModelCopyWith<$Res> {
  __$FolderModelCopyWithImpl(this._self, this._then);

  final _FolderModel _self;
  final $Res Function(_FolderModel) _then;

/// Create a copy of FolderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? fileCount = null,}) {
  return _then(_FolderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fileCount: null == fileCount ? _self.fileCount : fileCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
