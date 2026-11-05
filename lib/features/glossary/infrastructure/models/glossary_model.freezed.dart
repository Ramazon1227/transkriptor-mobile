// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'glossary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GlossaryModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'name') String get name;@JsonKey(name: 'term_count') int get termCount;
/// Create a copy of GlossaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryModelCopyWith<GlossaryModel> get copyWith => _$GlossaryModelCopyWithImpl<GlossaryModel>(this as GlossaryModel, _$identity);

  /// Serializes this GlossaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GlossaryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlossaryModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.termCount, _this.termCount) || other.termCount == _this.termCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GlossaryModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.termCount);
}

@override
String toString() {
  final _this = this as GlossaryModel;
  return 'GlossaryModel(id: ${_this.id}, name: ${_this.name}, termCount: ${_this.termCount})';
}


}

/// @nodoc
abstract mixin class $GlossaryModelCopyWith<$Res>  {
  factory $GlossaryModelCopyWith(GlossaryModel value, $Res Function(GlossaryModel) _then) = _$GlossaryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'term_count') int termCount
});




}
/// @nodoc
class _$GlossaryModelCopyWithImpl<$Res>
    implements $GlossaryModelCopyWith<$Res> {
  _$GlossaryModelCopyWithImpl(this._self, this._then);

  final GlossaryModel _self;
  final $Res Function(GlossaryModel) _then;

/// Create a copy of GlossaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? termCount = null,}) {
  return _then(GlossaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,termCount: null == termCount ? _self.termCount : termCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GlossaryModel].
extension GlossaryModelPatterns on GlossaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlossaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlossaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlossaryModel value)  $default,){
final _that = this;
switch (_that) {
case _GlossaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlossaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _GlossaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'term_count')  int termCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlossaryModel() when $default != null:
return $default(_that.id,_that.name,_that.termCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'term_count')  int termCount)  $default,) {final _that = this;
switch (_that) {
case _GlossaryModel():
return $default(_that.id,_that.name,_that.termCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'term_count')  int termCount)?  $default,) {final _that = this;
switch (_that) {
case _GlossaryModel() when $default != null:
return $default(_that.id,_that.name,_that.termCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GlossaryModel extends GlossaryModel {
  const _GlossaryModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'name') this.name = '', @JsonKey(name: 'term_count') this.termCount = 0}): super._();
  factory _GlossaryModel.fromJson(Map<String, dynamic> json) => _$GlossaryModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'term_count') final  int termCount;

/// Create a copy of GlossaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryModelCopyWith<_GlossaryModel> get copyWith => __$GlossaryModelCopyWithImpl<_GlossaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GlossaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlossaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.termCount, termCount) || other.termCount == termCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,termCount);
}

@override
String toString() {
    return 'GlossaryModel(id: $id, name: $name, termCount: $termCount)';
}


}

/// @nodoc
abstract mixin class _$GlossaryModelCopyWith<$Res> implements $GlossaryModelCopyWith<$Res> {
  factory _$GlossaryModelCopyWith(_GlossaryModel value, $Res Function(_GlossaryModel) _then) = __$GlossaryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'term_count') int termCount
});




}
/// @nodoc
class __$GlossaryModelCopyWithImpl<$Res>
    implements _$GlossaryModelCopyWith<$Res> {
  __$GlossaryModelCopyWithImpl(this._self, this._then);

  final _GlossaryModel _self;
  final $Res Function(_GlossaryModel) _then;

/// Create a copy of GlossaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? termCount = null,}) {
  return _then(_GlossaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,termCount: null == termCount ? _self.termCount : termCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
