// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportOptions {

 bool get timecodes; bool get speakers;/// oʻ/gʻ and the tutuq as a plain `'` — many people search and type
/// with it. The stored text keeps U+02BB / U+02BC.
 bool get plainApostrophe;
/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportOptionsCopyWith<ExportOptions> get copyWith => _$ExportOptionsCopyWithImpl<ExportOptions>(this as ExportOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExportOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportOptions&&(identical(other.timecodes, _this.timecodes) || other.timecodes == _this.timecodes)&&(identical(other.speakers, _this.speakers) || other.speakers == _this.speakers)&&(identical(other.plainApostrophe, _this.plainApostrophe) || other.plainApostrophe == _this.plainApostrophe));
}


@override
int get hashCode {
  final _this = this as ExportOptions;
  return Object.hash(runtimeType,_this.timecodes,_this.speakers,_this.plainApostrophe);
}

@override
String toString() {
  final _this = this as ExportOptions;
  return 'ExportOptions(timecodes: ${_this.timecodes}, speakers: ${_this.speakers}, plainApostrophe: ${_this.plainApostrophe})';
}


}

/// @nodoc
abstract mixin class $ExportOptionsCopyWith<$Res>  {
  factory $ExportOptionsCopyWith(ExportOptions value, $Res Function(ExportOptions) _then) = _$ExportOptionsCopyWithImpl;
@useResult
$Res call({
 bool timecodes, bool speakers, bool plainApostrophe
});




}
/// @nodoc
class _$ExportOptionsCopyWithImpl<$Res>
    implements $ExportOptionsCopyWith<$Res> {
  _$ExportOptionsCopyWithImpl(this._self, this._then);

  final ExportOptions _self;
  final $Res Function(ExportOptions) _then;

/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timecodes = null,Object? speakers = null,Object? plainApostrophe = null,}) {
  return _then(ExportOptions(
timecodes: null == timecodes ? _self.timecodes : timecodes // ignore: cast_nullable_to_non_nullable
as bool,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as bool,plainApostrophe: null == plainApostrophe ? _self.plainApostrophe : plainApostrophe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportOptions].
extension ExportOptionsPatterns on ExportOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExportOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExportOptions value)  $default,){
final _that = this;
switch (_that) {
case _ExportOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExportOptions value)?  $default,){
final _that = this;
switch (_that) {
case _ExportOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool timecodes,  bool speakers,  bool plainApostrophe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportOptions() when $default != null:
return $default(_that.timecodes,_that.speakers,_that.plainApostrophe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool timecodes,  bool speakers,  bool plainApostrophe)  $default,) {final _that = this;
switch (_that) {
case _ExportOptions():
return $default(_that.timecodes,_that.speakers,_that.plainApostrophe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool timecodes,  bool speakers,  bool plainApostrophe)?  $default,) {final _that = this;
switch (_that) {
case _ExportOptions() when $default != null:
return $default(_that.timecodes,_that.speakers,_that.plainApostrophe);case _:
  return null;

}
}

}

/// @nodoc


class _ExportOptions implements ExportOptions {
  const _ExportOptions({this.timecodes = true, this.speakers = true, this.plainApostrophe = false});
  

@override@JsonKey() final  bool timecodes;
@override@JsonKey() final  bool speakers;
/// oʻ/gʻ and the tutuq as a plain `'` — many people search and type
/// with it. The stored text keeps U+02BB / U+02BC.
@override@JsonKey() final  bool plainApostrophe;

/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportOptionsCopyWith<_ExportOptions> get copyWith => __$ExportOptionsCopyWithImpl<_ExportOptions>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportOptions&&(identical(other.timecodes, timecodes) || other.timecodes == timecodes)&&(identical(other.speakers, speakers) || other.speakers == speakers)&&(identical(other.plainApostrophe, plainApostrophe) || other.plainApostrophe == plainApostrophe));
}


@override
int get hashCode {
    return Object.hash(runtimeType,timecodes,speakers,plainApostrophe);
}

@override
String toString() {
    return 'ExportOptions(timecodes: $timecodes, speakers: $speakers, plainApostrophe: $plainApostrophe)';
}


}

/// @nodoc
abstract mixin class _$ExportOptionsCopyWith<$Res> implements $ExportOptionsCopyWith<$Res> {
  factory _$ExportOptionsCopyWith(_ExportOptions value, $Res Function(_ExportOptions) _then) = __$ExportOptionsCopyWithImpl;
@override @useResult
$Res call({
 bool timecodes, bool speakers, bool plainApostrophe
});




}
/// @nodoc
class __$ExportOptionsCopyWithImpl<$Res>
    implements _$ExportOptionsCopyWith<$Res> {
  __$ExportOptionsCopyWithImpl(this._self, this._then);

  final _ExportOptions _self;
  final $Res Function(_ExportOptions) _then;

/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timecodes = null,Object? speakers = null,Object? plainApostrophe = null,}) {
  return _then(_ExportOptions(
timecodes: null == timecodes ? _self.timecodes : timecodes // ignore: cast_nullable_to_non_nullable
as bool,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as bool,plainApostrophe: null == plainApostrophe ? _self.plainApostrophe : plainApostrophe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
