// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SummaryTemplate {

 String get id; String get name; SummaryTemplateOwner get owner; String? get categoryId;/// Free-text instructions for the model.
 String get prompt; int get position;/// Starred by the caller (per user).
 bool get favorite;
/// Create a copy of SummaryTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryTemplateCopyWith<SummaryTemplate> get copyWith => _$SummaryTemplateCopyWithImpl<SummaryTemplate>(this as SummaryTemplate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SummaryTemplate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryTemplate&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.owner, _this.owner) || other.owner == _this.owner)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.favorite, _this.favorite) || other.favorite == _this.favorite));
}


@override
int get hashCode {
  final _this = this as SummaryTemplate;
  return Object.hash(runtimeType,_this.id,_this.name,_this.owner,_this.categoryId,_this.prompt,_this.position,_this.favorite);
}

@override
String toString() {
  final _this = this as SummaryTemplate;
  return 'SummaryTemplate(id: ${_this.id}, name: ${_this.name}, owner: ${_this.owner}, categoryId: ${_this.categoryId}, prompt: ${_this.prompt}, position: ${_this.position}, favorite: ${_this.favorite})';
}


}

/// @nodoc
abstract mixin class $SummaryTemplateCopyWith<$Res>  {
  factory $SummaryTemplateCopyWith(SummaryTemplate value, $Res Function(SummaryTemplate) _then) = _$SummaryTemplateCopyWithImpl;
@useResult
$Res call({
 String id, String name, SummaryTemplateOwner owner, String? categoryId, String prompt, int position, bool favorite
});




}
/// @nodoc
class _$SummaryTemplateCopyWithImpl<$Res>
    implements $SummaryTemplateCopyWith<$Res> {
  _$SummaryTemplateCopyWithImpl(this._self, this._then);

  final SummaryTemplate _self;
  final $Res Function(SummaryTemplate) _then;

/// Create a copy of SummaryTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? owner = null,Object? categoryId = freezed,Object? prompt = null,Object? position = null,Object? favorite = null,}) {
  return _then(SummaryTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as SummaryTemplateOwner,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SummaryTemplate].
extension SummaryTemplatePatterns on SummaryTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryTemplate value)  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SummaryTemplateOwner owner,  String? categoryId,  String prompt,  int position,  bool favorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryTemplate() when $default != null:
return $default(_that.id,_that.name,_that.owner,_that.categoryId,_that.prompt,_that.position,_that.favorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SummaryTemplateOwner owner,  String? categoryId,  String prompt,  int position,  bool favorite)  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplate():
return $default(_that.id,_that.name,_that.owner,_that.categoryId,_that.prompt,_that.position,_that.favorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SummaryTemplateOwner owner,  String? categoryId,  String prompt,  int position,  bool favorite)?  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplate() when $default != null:
return $default(_that.id,_that.name,_that.owner,_that.categoryId,_that.prompt,_that.position,_that.favorite);case _:
  return null;

}
}

}

/// @nodoc


class _SummaryTemplate implements SummaryTemplate {
  const _SummaryTemplate({required this.id, required this.name, this.owner = SummaryTemplateOwner.unknown, this.categoryId, this.prompt = '', this.position = 0, this.favorite = false});
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  SummaryTemplateOwner owner;
@override final  String? categoryId;
/// Free-text instructions for the model.
@override@JsonKey() final  String prompt;
@override@JsonKey() final  int position;
/// Starred by the caller (per user).
@override@JsonKey() final  bool favorite;

/// Create a copy of SummaryTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryTemplateCopyWith<_SummaryTemplate> get copyWith => __$SummaryTemplateCopyWithImpl<_SummaryTemplate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.position, position) || other.position == position)&&(identical(other.favorite, favorite) || other.favorite == favorite));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,owner,categoryId,prompt,position,favorite);
}

@override
String toString() {
    return 'SummaryTemplate(id: $id, name: $name, owner: $owner, categoryId: $categoryId, prompt: $prompt, position: $position, favorite: $favorite)';
}


}

/// @nodoc
abstract mixin class _$SummaryTemplateCopyWith<$Res> implements $SummaryTemplateCopyWith<$Res> {
  factory _$SummaryTemplateCopyWith(_SummaryTemplate value, $Res Function(_SummaryTemplate) _then) = __$SummaryTemplateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SummaryTemplateOwner owner, String? categoryId, String prompt, int position, bool favorite
});




}
/// @nodoc
class __$SummaryTemplateCopyWithImpl<$Res>
    implements _$SummaryTemplateCopyWith<$Res> {
  __$SummaryTemplateCopyWithImpl(this._self, this._then);

  final _SummaryTemplate _self;
  final $Res Function(_SummaryTemplate) _then;

/// Create a copy of SummaryTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? owner = null,Object? categoryId = freezed,Object? prompt = null,Object? position = null,Object? favorite = null,}) {
  return _then(_SummaryTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as SummaryTemplateOwner,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SummaryTemplateCategory {

 String get id; String get name; int get position;
/// Create a copy of SummaryTemplateCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryTemplateCategoryCopyWith<SummaryTemplateCategory> get copyWith => _$SummaryTemplateCategoryCopyWithImpl<SummaryTemplateCategory>(this as SummaryTemplateCategory, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SummaryTemplateCategory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryTemplateCategory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.position, _this.position) || other.position == _this.position));
}


@override
int get hashCode {
  final _this = this as SummaryTemplateCategory;
  return Object.hash(runtimeType,_this.id,_this.name,_this.position);
}

@override
String toString() {
  final _this = this as SummaryTemplateCategory;
  return 'SummaryTemplateCategory(id: ${_this.id}, name: ${_this.name}, position: ${_this.position})';
}


}

/// @nodoc
abstract mixin class $SummaryTemplateCategoryCopyWith<$Res>  {
  factory $SummaryTemplateCategoryCopyWith(SummaryTemplateCategory value, $Res Function(SummaryTemplateCategory) _then) = _$SummaryTemplateCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, int position
});




}
/// @nodoc
class _$SummaryTemplateCategoryCopyWithImpl<$Res>
    implements $SummaryTemplateCategoryCopyWith<$Res> {
  _$SummaryTemplateCategoryCopyWithImpl(this._self, this._then);

  final SummaryTemplateCategory _self;
  final $Res Function(SummaryTemplateCategory) _then;

/// Create a copy of SummaryTemplateCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? position = null,}) {
  return _then(SummaryTemplateCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SummaryTemplateCategory].
extension SummaryTemplateCategoryPatterns on SummaryTemplateCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryTemplateCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryTemplateCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryTemplateCategory value)  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplateCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryTemplateCategory value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplateCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryTemplateCategory() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int position)  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplateCategory():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int position)?  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplateCategory() when $default != null:
return $default(_that.id,_that.name,_that.position);case _:
  return null;

}
}

}

/// @nodoc


class _SummaryTemplateCategory implements SummaryTemplateCategory {
  const _SummaryTemplateCategory({required this.id, required this.name, this.position = 0});
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  int position;

/// Create a copy of SummaryTemplateCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryTemplateCategoryCopyWith<_SummaryTemplateCategory> get copyWith => __$SummaryTemplateCategoryCopyWithImpl<_SummaryTemplateCategory>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryTemplateCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,position);
}

@override
String toString() {
    return 'SummaryTemplateCategory(id: $id, name: $name, position: $position)';
}


}

/// @nodoc
abstract mixin class _$SummaryTemplateCategoryCopyWith<$Res> implements $SummaryTemplateCategoryCopyWith<$Res> {
  factory _$SummaryTemplateCategoryCopyWith(_SummaryTemplateCategory value, $Res Function(_SummaryTemplateCategory) _then) = __$SummaryTemplateCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int position
});




}
/// @nodoc
class __$SummaryTemplateCategoryCopyWithImpl<$Res>
    implements _$SummaryTemplateCategoryCopyWith<$Res> {
  __$SummaryTemplateCategoryCopyWithImpl(this._self, this._then);

  final _SummaryTemplateCategory _self;
  final $Res Function(_SummaryTemplateCategory) _then;

/// Create a copy of SummaryTemplateCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? position = null,}) {
  return _then(_SummaryTemplateCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SummaryTemplateLibrary {

 List<SummaryTemplateCategory> get categories; List<SummaryTemplate> get templates;
/// Create a copy of SummaryTemplateLibrary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryTemplateLibraryCopyWith<SummaryTemplateLibrary> get copyWith => _$SummaryTemplateLibraryCopyWithImpl<SummaryTemplateLibrary>(this as SummaryTemplateLibrary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SummaryTemplateLibrary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryTemplateLibrary&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.templates, _this.templates));
}


@override
int get hashCode {
  final _this = this as SummaryTemplateLibrary;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.templates));
}

@override
String toString() {
  final _this = this as SummaryTemplateLibrary;
  return 'SummaryTemplateLibrary(categories: ${_this.categories}, templates: ${_this.templates})';
}


}

/// @nodoc
abstract mixin class $SummaryTemplateLibraryCopyWith<$Res>  {
  factory $SummaryTemplateLibraryCopyWith(SummaryTemplateLibrary value, $Res Function(SummaryTemplateLibrary) _then) = _$SummaryTemplateLibraryCopyWithImpl;
@useResult
$Res call({
 List<SummaryTemplateCategory> categories, List<SummaryTemplate> templates
});




}
/// @nodoc
class _$SummaryTemplateLibraryCopyWithImpl<$Res>
    implements $SummaryTemplateLibraryCopyWith<$Res> {
  _$SummaryTemplateLibraryCopyWithImpl(this._self, this._then);

  final SummaryTemplateLibrary _self;
  final $Res Function(SummaryTemplateLibrary) _then;

/// Create a copy of SummaryTemplateLibrary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? templates = null,}) {
  return _then(SummaryTemplateLibrary(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<SummaryTemplateCategory>,templates: null == templates ? _self.templates : templates // ignore: cast_nullable_to_non_nullable
as List<SummaryTemplate>,
  ));
}

}


/// Adds pattern-matching-related methods to [SummaryTemplateLibrary].
extension SummaryTemplateLibraryPatterns on SummaryTemplateLibrary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryTemplateLibrary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryTemplateLibrary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryTemplateLibrary value)  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplateLibrary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryTemplateLibrary value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryTemplateLibrary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SummaryTemplateCategory> categories,  List<SummaryTemplate> templates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryTemplateLibrary() when $default != null:
return $default(_that.categories,_that.templates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SummaryTemplateCategory> categories,  List<SummaryTemplate> templates)  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplateLibrary():
return $default(_that.categories,_that.templates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SummaryTemplateCategory> categories,  List<SummaryTemplate> templates)?  $default,) {final _that = this;
switch (_that) {
case _SummaryTemplateLibrary() when $default != null:
return $default(_that.categories,_that.templates);case _:
  return null;

}
}

}

/// @nodoc


class _SummaryTemplateLibrary extends SummaryTemplateLibrary {
  const _SummaryTemplateLibrary({ List<SummaryTemplateCategory> categories = const <SummaryTemplateCategory>[],  List<SummaryTemplate> templates = const <SummaryTemplate>[]}): _categories = categories,_templates = templates,super._();
  

 final  List<SummaryTemplateCategory> _categories;
@override@JsonKey() List<SummaryTemplateCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<SummaryTemplate> _templates;
@override@JsonKey() List<SummaryTemplate> get templates {
  if (_templates is EqualUnmodifiableListView) return _templates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_templates);
}


/// Create a copy of SummaryTemplateLibrary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryTemplateLibraryCopyWith<_SummaryTemplateLibrary> get copyWith => __$SummaryTemplateLibraryCopyWithImpl<_SummaryTemplateLibrary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryTemplateLibrary&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.templates, _templates));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_templates));
}

@override
String toString() {
    return 'SummaryTemplateLibrary(categories: $categories, templates: $templates)';
}


}

/// @nodoc
abstract mixin class _$SummaryTemplateLibraryCopyWith<$Res> implements $SummaryTemplateLibraryCopyWith<$Res> {
  factory _$SummaryTemplateLibraryCopyWith(_SummaryTemplateLibrary value, $Res Function(_SummaryTemplateLibrary) _then) = __$SummaryTemplateLibraryCopyWithImpl;
@override @useResult
$Res call({
 List<SummaryTemplateCategory> categories, List<SummaryTemplate> templates
});




}
/// @nodoc
class __$SummaryTemplateLibraryCopyWithImpl<$Res>
    implements _$SummaryTemplateLibraryCopyWith<$Res> {
  __$SummaryTemplateLibraryCopyWithImpl(this._self, this._then);

  final _SummaryTemplateLibrary _self;
  final $Res Function(_SummaryTemplateLibrary) _then;

/// Create a copy of SummaryTemplateLibrary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? templates = null,}) {
  return _then(_SummaryTemplateLibrary(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<SummaryTemplateCategory>,templates: null == templates ? _self._templates : templates // ignore: cast_nullable_to_non_nullable
as List<SummaryTemplate>,
  ));
}


}

// dart format on
