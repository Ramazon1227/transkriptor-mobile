// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_created_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaCreatedModel {

@JsonKey(name: 'id') String get id;/// Absolute: the API's own signed route, or an S3 pre-signed URL.
@JsonKey(name: 'upload_url') String get uploadUrl;
/// Create a copy of MediaCreatedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaCreatedModelCopyWith<MediaCreatedModel> get copyWith => _$MediaCreatedModelCopyWithImpl<MediaCreatedModel>(this as MediaCreatedModel, _$identity);

  /// Serializes this MediaCreatedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MediaCreatedModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaCreatedModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.uploadUrl, _this.uploadUrl) || other.uploadUrl == _this.uploadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MediaCreatedModel;
  return Object.hash(runtimeType,_this.id,_this.uploadUrl);
}

@override
String toString() {
  final _this = this as MediaCreatedModel;
  return 'MediaCreatedModel(id: ${_this.id}, uploadUrl: ${_this.uploadUrl})';
}


}

/// @nodoc
abstract mixin class $MediaCreatedModelCopyWith<$Res>  {
  factory $MediaCreatedModelCopyWith(MediaCreatedModel value, $Res Function(MediaCreatedModel) _then) = _$MediaCreatedModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'upload_url') String uploadUrl
});




}
/// @nodoc
class _$MediaCreatedModelCopyWithImpl<$Res>
    implements $MediaCreatedModelCopyWith<$Res> {
  _$MediaCreatedModelCopyWithImpl(this._self, this._then);

  final MediaCreatedModel _self;
  final $Res Function(MediaCreatedModel) _then;

/// Create a copy of MediaCreatedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? uploadUrl = null,}) {
  return _then(MediaCreatedModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uploadUrl: null == uploadUrl ? _self.uploadUrl : uploadUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaCreatedModel].
extension MediaCreatedModelPatterns on MediaCreatedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaCreatedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaCreatedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaCreatedModel value)  $default,){
final _that = this;
switch (_that) {
case _MediaCreatedModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaCreatedModel value)?  $default,){
final _that = this;
switch (_that) {
case _MediaCreatedModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'upload_url')  String uploadUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaCreatedModel() when $default != null:
return $default(_that.id,_that.uploadUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'upload_url')  String uploadUrl)  $default,) {final _that = this;
switch (_that) {
case _MediaCreatedModel():
return $default(_that.id,_that.uploadUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'upload_url')  String uploadUrl)?  $default,) {final _that = this;
switch (_that) {
case _MediaCreatedModel() when $default != null:
return $default(_that.id,_that.uploadUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaCreatedModel implements MediaCreatedModel {
  const _MediaCreatedModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'upload_url') this.uploadUrl = ''});
  factory _MediaCreatedModel.fromJson(Map<String, dynamic> json) => _$MediaCreatedModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
/// Absolute: the API's own signed route, or an S3 pre-signed URL.
@override@JsonKey(name: 'upload_url') final  String uploadUrl;

/// Create a copy of MediaCreatedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaCreatedModelCopyWith<_MediaCreatedModel> get copyWith => __$MediaCreatedModelCopyWithImpl<_MediaCreatedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaCreatedModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaCreatedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.uploadUrl, uploadUrl) || other.uploadUrl == uploadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,uploadUrl);
}

@override
String toString() {
    return 'MediaCreatedModel(id: $id, uploadUrl: $uploadUrl)';
}


}

/// @nodoc
abstract mixin class _$MediaCreatedModelCopyWith<$Res> implements $MediaCreatedModelCopyWith<$Res> {
  factory _$MediaCreatedModelCopyWith(_MediaCreatedModel value, $Res Function(_MediaCreatedModel) _then) = __$MediaCreatedModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'upload_url') String uploadUrl
});




}
/// @nodoc
class __$MediaCreatedModelCopyWithImpl<$Res>
    implements _$MediaCreatedModelCopyWith<$Res> {
  __$MediaCreatedModelCopyWithImpl(this._self, this._then);

  final _MediaCreatedModel _self;
  final $Res Function(_MediaCreatedModel) _then;

/// Create a copy of MediaCreatedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uploadUrl = null,}) {
  return _then(_MediaCreatedModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uploadUrl: null == uploadUrl ? _self.uploadUrl : uploadUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
