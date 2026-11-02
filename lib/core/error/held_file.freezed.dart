// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'held_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HeldFile {

 String get id; String get name; HeldFileState get state; int get sizeBytes;/// The server deletes it by itself at this time.
 DateTime? get expiresAt;/// False for someone else's unfinished upload and a running recording.
 bool get deletable;
/// Create a copy of HeldFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeldFileCopyWith<HeldFile> get copyWith => _$HeldFileCopyWithImpl<HeldFile>(this as HeldFile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HeldFile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeldFile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.deletable, _this.deletable) || other.deletable == _this.deletable));
}


@override
int get hashCode {
  final _this = this as HeldFile;
  return Object.hash(runtimeType,_this.id,_this.name,_this.state,_this.sizeBytes,_this.expiresAt,_this.deletable);
}

@override
String toString() {
  final _this = this as HeldFile;
  return 'HeldFile(id: ${_this.id}, name: ${_this.name}, state: ${_this.state}, sizeBytes: ${_this.sizeBytes}, expiresAt: ${_this.expiresAt}, deletable: ${_this.deletable})';
}


}

/// @nodoc
abstract mixin class $HeldFileCopyWith<$Res>  {
  factory $HeldFileCopyWith(HeldFile value, $Res Function(HeldFile) _then) = _$HeldFileCopyWithImpl;
@useResult
$Res call({
 String id, String name, HeldFileState state, int sizeBytes, DateTime? expiresAt, bool deletable
});




}
/// @nodoc
class _$HeldFileCopyWithImpl<$Res>
    implements $HeldFileCopyWith<$Res> {
  _$HeldFileCopyWithImpl(this._self, this._then);

  final HeldFile _self;
  final $Res Function(HeldFile) _then;

/// Create a copy of HeldFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? state = null,Object? sizeBytes = null,Object? expiresAt = freezed,Object? deletable = null,}) {
  return _then(HeldFile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as HeldFileState,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletable: null == deletable ? _self.deletable : deletable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HeldFile].
extension HeldFilePatterns on HeldFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeldFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeldFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeldFile value)  $default,){
final _that = this;
switch (_that) {
case _HeldFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeldFile value)?  $default,){
final _that = this;
switch (_that) {
case _HeldFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  HeldFileState state,  int sizeBytes,  DateTime? expiresAt,  bool deletable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeldFile() when $default != null:
return $default(_that.id,_that.name,_that.state,_that.sizeBytes,_that.expiresAt,_that.deletable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  HeldFileState state,  int sizeBytes,  DateTime? expiresAt,  bool deletable)  $default,) {final _that = this;
switch (_that) {
case _HeldFile():
return $default(_that.id,_that.name,_that.state,_that.sizeBytes,_that.expiresAt,_that.deletable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  HeldFileState state,  int sizeBytes,  DateTime? expiresAt,  bool deletable)?  $default,) {final _that = this;
switch (_that) {
case _HeldFile() when $default != null:
return $default(_that.id,_that.name,_that.state,_that.sizeBytes,_that.expiresAt,_that.deletable);case _:
  return null;

}
}

}

/// @nodoc


class _HeldFile implements HeldFile {
  const _HeldFile({required this.id, required this.name, required this.state, required this.sizeBytes, this.expiresAt, this.deletable = false});
  

@override final  String id;
@override final  String name;
@override final  HeldFileState state;
@override final  int sizeBytes;
/// The server deletes it by itself at this time.
@override final  DateTime? expiresAt;
/// False for someone else's unfinished upload and a running recording.
@override@JsonKey() final  bool deletable;

/// Create a copy of HeldFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeldFileCopyWith<_HeldFile> get copyWith => __$HeldFileCopyWithImpl<_HeldFile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeldFile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.state, state) || other.state == state)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deletable, deletable) || other.deletable == deletable));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,state,sizeBytes,expiresAt,deletable);
}

@override
String toString() {
    return 'HeldFile(id: $id, name: $name, state: $state, sizeBytes: $sizeBytes, expiresAt: $expiresAt, deletable: $deletable)';
}


}

/// @nodoc
abstract mixin class _$HeldFileCopyWith<$Res> implements $HeldFileCopyWith<$Res> {
  factory _$HeldFileCopyWith(_HeldFile value, $Res Function(_HeldFile) _then) = __$HeldFileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, HeldFileState state, int sizeBytes, DateTime? expiresAt, bool deletable
});




}
/// @nodoc
class __$HeldFileCopyWithImpl<$Res>
    implements _$HeldFileCopyWith<$Res> {
  __$HeldFileCopyWithImpl(this._self, this._then);

  final _HeldFile _self;
  final $Res Function(_HeldFile) _then;

/// Create a copy of HeldFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? state = null,Object? sizeBytes = null,Object? expiresAt = freezed,Object? deletable = null,}) {
  return _then(_HeldFile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as HeldFileState,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletable: null == deletable ? _self.deletable : deletable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
