// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'glossary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Glossary {

 String get id; String get name; int get termCount;
/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryCopyWith<Glossary> get copyWith => _$GlossaryCopyWithImpl<Glossary>(this as Glossary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Glossary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Glossary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.termCount, _this.termCount) || other.termCount == _this.termCount));
}


@override
int get hashCode {
  final _this = this as Glossary;
  return Object.hash(runtimeType,_this.id,_this.name,_this.termCount);
}

@override
String toString() {
  final _this = this as Glossary;
  return 'Glossary(id: ${_this.id}, name: ${_this.name}, termCount: ${_this.termCount})';
}


}

/// @nodoc
abstract mixin class $GlossaryCopyWith<$Res>  {
  factory $GlossaryCopyWith(Glossary value, $Res Function(Glossary) _then) = _$GlossaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, int termCount
});




}
/// @nodoc
class _$GlossaryCopyWithImpl<$Res>
    implements $GlossaryCopyWith<$Res> {
  _$GlossaryCopyWithImpl(this._self, this._then);

  final Glossary _self;
  final $Res Function(Glossary) _then;

/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? termCount = null,}) {
  return _then(Glossary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,termCount: null == termCount ? _self.termCount : termCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Glossary].
extension GlossaryPatterns on Glossary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Glossary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Glossary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Glossary value)  $default,){
final _that = this;
switch (_that) {
case _Glossary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Glossary value)?  $default,){
final _that = this;
switch (_that) {
case _Glossary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int termCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Glossary() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int termCount)  $default,) {final _that = this;
switch (_that) {
case _Glossary():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int termCount)?  $default,) {final _that = this;
switch (_that) {
case _Glossary() when $default != null:
return $default(_that.id,_that.name,_that.termCount);case _:
  return null;

}
}

}

/// @nodoc


class _Glossary implements Glossary {
  const _Glossary({required this.id, required this.name, this.termCount = 0});
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  int termCount;

/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryCopyWith<_Glossary> get copyWith => __$GlossaryCopyWithImpl<_Glossary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Glossary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.termCount, termCount) || other.termCount == termCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,termCount);
}

@override
String toString() {
    return 'Glossary(id: $id, name: $name, termCount: $termCount)';
}


}

/// @nodoc
abstract mixin class _$GlossaryCopyWith<$Res> implements $GlossaryCopyWith<$Res> {
  factory _$GlossaryCopyWith(_Glossary value, $Res Function(_Glossary) _then) = __$GlossaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int termCount
});




}
/// @nodoc
class __$GlossaryCopyWithImpl<$Res>
    implements _$GlossaryCopyWith<$Res> {
  __$GlossaryCopyWithImpl(this._self, this._then);

  final _Glossary _self;
  final $Res Function(_Glossary) _then;

/// Create a copy of Glossary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? termCount = null,}) {
  return _then(_Glossary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,termCount: null == termCount ? _self.termCount : termCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
