// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_template_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SummaryTemplateModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown) SummaryTemplateOwnerModel get owner;@JsonKey(name: 'category_id') String? get categoryId;@JsonKey(name: 'name') String get name;@JsonKey(name: 'prompt') String get prompt;@JsonKey(name: 'position') int get position;@JsonKey(name: 'favorite') bool get favorite;
/// Create a copy of SummaryTemplateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryTemplateModelCopyWith<SummaryTemplateModel> get copyWith => _$SummaryTemplateModelCopyWithImpl<SummaryTemplateModel>(this as SummaryTemplateModel, _$identity);

  /// Serializes this SummaryTemplateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SummaryTemplateModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryTemplateModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.owner, _this.owner) || other.owner == _this.owner)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.favorite, _this.favorite) || other.favorite == _this.favorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SummaryTemplateModel;
  return Object.hash(runtimeType,_this.id,_this.owner,_this.categoryId,_this.name,_this.prompt,_this.position,_this.favorite);
}

@override
String toString() {
  final _this = this as SummaryTemplateModel;
  return 'SummaryTemplateModel(id: ${_this.id}, owner: ${_this.owner}, categoryId: ${_this.categoryId}, name: ${_this.name}, prompt: ${_this.prompt}, position: ${_this.position}, favorite: ${_this.favorite})';
}


}

/// @nodoc
abstract mixin class $SummaryTemplateModelCopyWith<$Res>  {
  factory $SummaryTemplateModelCopyWith(SummaryTemplateModel value, $Res Function(SummaryTemplateModel) _then) = _$SummaryTemplateModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown) SummaryTemplateOwnerModel owner,@JsonKey(name: 'category_id') String? categoryId,@JsonKey(name: 'name') String name,@JsonKey(name: 'prompt') String prompt,@JsonKey(name: 'position') int position,@JsonKey(name: 'favorite') bool favorite
});




}
/// @nodoc
class _$SummaryTemplateModelCopyWithImpl<$Res>
    implements $SummaryTemplateModelCopyWith<$Res> {
  _$SummaryTemplateModelCopyWithImpl(this._self, this._then);

  final SummaryTemplateModel _self;
  final $Res Function(SummaryTemplateModel) _then;

/// Create a copy of SummaryTemplateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? owner = null,Object? categoryId = freezed,Object? name = null,Object? prompt = null,Object? position = null,Object? favorite = null,}) {
  return _then(SummaryTemplateModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as SummaryTemplateOwnerModel,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SummaryTemplateModel].
extension SummaryTemplateModelPatterns on SummaryTemplateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryTemplateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryTemplateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryTemplateModel value)  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryTemplateModel value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown)  SummaryTemplateOwnerModel owner, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'name')  String name, @JsonKey(name: 'prompt')  String prompt, @JsonKey(name: 'position')  int position, @JsonKey(name: 'favorite')  bool favorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryTemplateModel() when $default != null:
return $default(_that.id,_that.owner,_that.categoryId,_that.name,_that.prompt,_that.position,_that.favorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown)  SummaryTemplateOwnerModel owner, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'name')  String name, @JsonKey(name: 'prompt')  String prompt, @JsonKey(name: 'position')  int position, @JsonKey(name: 'favorite')  bool favorite)  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplateModel():
return $default(_that.id,_that.owner,_that.categoryId,_that.name,_that.prompt,_that.position,_that.favorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown)  SummaryTemplateOwnerModel owner, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'name')  String name, @JsonKey(name: 'prompt')  String prompt, @JsonKey(name: 'position')  int position, @JsonKey(name: 'favorite')  bool favorite)?  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplateModel() when $default != null:
return $default(_that.id,_that.owner,_that.categoryId,_that.name,_that.prompt,_that.position,_that.favorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SummaryTemplateModel extends SummaryTemplateModel {
  const _SummaryTemplateModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown) this.owner = SummaryTemplateOwnerModel.unknown, @JsonKey(name: 'category_id') this.categoryId, @JsonKey(name: 'name') this.name = '', @JsonKey(name: 'prompt') this.prompt = '', @JsonKey(name: 'position') this.position = 0, @JsonKey(name: 'favorite') this.favorite = false}): super._();
  factory _SummaryTemplateModel.fromJson(Map<String, dynamic> json) => _$SummaryTemplateModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown) final  SummaryTemplateOwnerModel owner;
@override@JsonKey(name: 'category_id') final  String? categoryId;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'prompt') final  String prompt;
@override@JsonKey(name: 'position') final  int position;
@override@JsonKey(name: 'favorite') final  bool favorite;

/// Create a copy of SummaryTemplateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryTemplateModelCopyWith<_SummaryTemplateModel> get copyWith => __$SummaryTemplateModelCopyWithImpl<_SummaryTemplateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryTemplateModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryTemplateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.position, position) || other.position == position)&&(identical(other.favorite, favorite) || other.favorite == favorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,owner,categoryId,name,prompt,position,favorite);
}

@override
String toString() {
    return 'SummaryTemplateModel(id: $id, owner: $owner, categoryId: $categoryId, name: $name, prompt: $prompt, position: $position, favorite: $favorite)';
}


}

/// @nodoc
abstract mixin class _$SummaryTemplateModelCopyWith<$Res> implements $SummaryTemplateModelCopyWith<$Res> {
  factory _$SummaryTemplateModelCopyWith(_SummaryTemplateModel value, $Res Function(_SummaryTemplateModel) _then) = __$SummaryTemplateModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'owner', unknownEnumValue: SummaryTemplateOwnerModel.unknown) SummaryTemplateOwnerModel owner,@JsonKey(name: 'category_id') String? categoryId,@JsonKey(name: 'name') String name,@JsonKey(name: 'prompt') String prompt,@JsonKey(name: 'position') int position,@JsonKey(name: 'favorite') bool favorite
});




}
/// @nodoc
class __$SummaryTemplateModelCopyWithImpl<$Res>
    implements _$SummaryTemplateModelCopyWith<$Res> {
  __$SummaryTemplateModelCopyWithImpl(this._self, this._then);

  final _SummaryTemplateModel _self;
  final $Res Function(_SummaryTemplateModel) _then;

/// Create a copy of SummaryTemplateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? owner = null,Object? categoryId = freezed,Object? name = null,Object? prompt = null,Object? position = null,Object? favorite = null,}) {
  return _then(_SummaryTemplateModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as SummaryTemplateOwnerModel,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SummaryTemplateCategoryModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'name') String get name;@JsonKey(name: 'position') int get position;
/// Create a copy of SummaryTemplateCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryTemplateCategoryModelCopyWith<SummaryTemplateCategoryModel> get copyWith => _$SummaryTemplateCategoryModelCopyWithImpl<SummaryTemplateCategoryModel>(this as SummaryTemplateCategoryModel, _$identity);

  /// Serializes this SummaryTemplateCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SummaryTemplateCategoryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryTemplateCategoryModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.position, _this.position) || other.position == _this.position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SummaryTemplateCategoryModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.position);
}

@override
String toString() {
  final _this = this as SummaryTemplateCategoryModel;
  return 'SummaryTemplateCategoryModel(id: ${_this.id}, name: ${_this.name}, position: ${_this.position})';
}


}

/// @nodoc
abstract mixin class $SummaryTemplateCategoryModelCopyWith<$Res>  {
  factory $SummaryTemplateCategoryModelCopyWith(SummaryTemplateCategoryModel value, $Res Function(SummaryTemplateCategoryModel) _then) = _$SummaryTemplateCategoryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'position') int position
});




}
/// @nodoc
class _$SummaryTemplateCategoryModelCopyWithImpl<$Res>
    implements $SummaryTemplateCategoryModelCopyWith<$Res> {
  _$SummaryTemplateCategoryModelCopyWithImpl(this._self, this._then);

  final SummaryTemplateCategoryModel _self;
  final $Res Function(SummaryTemplateCategoryModel) _then;

/// Create a copy of SummaryTemplateCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? position = null,}) {
  return _then(SummaryTemplateCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SummaryTemplateCategoryModel].
extension SummaryTemplateCategoryModelPatterns on SummaryTemplateCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryTemplateCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryTemplateCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryTemplateCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplateCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryTemplateCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplateCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'position')  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryTemplateCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'position')  int position)  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplateCategoryModel():
return $default(_that.id,_that.name,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'position')  int position)?  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplateCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SummaryTemplateCategoryModel extends SummaryTemplateCategoryModel {
  const _SummaryTemplateCategoryModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'name') this.name = '', @JsonKey(name: 'position') this.position = 0}): super._();
  factory _SummaryTemplateCategoryModel.fromJson(Map<String, dynamic> json) => _$SummaryTemplateCategoryModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'position') final  int position;

/// Create a copy of SummaryTemplateCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryTemplateCategoryModelCopyWith<_SummaryTemplateCategoryModel> get copyWith => __$SummaryTemplateCategoryModelCopyWithImpl<_SummaryTemplateCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryTemplateCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryTemplateCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,position);
}

@override
String toString() {
    return 'SummaryTemplateCategoryModel(id: $id, name: $name, position: $position)';
}


}

/// @nodoc
abstract mixin class _$SummaryTemplateCategoryModelCopyWith<$Res> implements $SummaryTemplateCategoryModelCopyWith<$Res> {
  factory _$SummaryTemplateCategoryModelCopyWith(_SummaryTemplateCategoryModel value, $Res Function(_SummaryTemplateCategoryModel) _then) = __$SummaryTemplateCategoryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String name,@JsonKey(name: 'position') int position
});




}
/// @nodoc
class __$SummaryTemplateCategoryModelCopyWithImpl<$Res>
    implements _$SummaryTemplateCategoryModelCopyWith<$Res> {
  __$SummaryTemplateCategoryModelCopyWithImpl(this._self, this._then);

  final _SummaryTemplateCategoryModel _self;
  final $Res Function(_SummaryTemplateCategoryModel) _then;

/// Create a copy of SummaryTemplateCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? position = null,}) {
  return _then(_SummaryTemplateCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
