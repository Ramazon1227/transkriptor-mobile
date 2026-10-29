// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteBlock {

 NoteBlockKind get kind; String get text;/// 1–3 for a heading, 0 otherwise.
 int get level;/// «•» or «3.» on a list item's first line; empty on its other lines.
 String get marker;/// List nesting, 0 outside a list.
 int get depth;/// Inside a blockquote.
 bool get quoted;
/// Create a copy of NoteBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteBlockCopyWith<NoteBlock> get copyWith => _$NoteBlockCopyWithImpl<NoteBlock>(this as NoteBlock, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NoteBlock;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteBlock&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.marker, _this.marker) || other.marker == _this.marker)&&(identical(other.depth, _this.depth) || other.depth == _this.depth)&&(identical(other.quoted, _this.quoted) || other.quoted == _this.quoted));
}


@override
int get hashCode {
  final _this = this as NoteBlock;
  return Object.hash(runtimeType,_this.kind,_this.text,_this.level,_this.marker,_this.depth,_this.quoted);
}

@override
String toString() {
  final _this = this as NoteBlock;
  return 'NoteBlock(kind: ${_this.kind}, text: ${_this.text}, level: ${_this.level}, marker: ${_this.marker}, depth: ${_this.depth}, quoted: ${_this.quoted})';
}


}

/// @nodoc
abstract mixin class $NoteBlockCopyWith<$Res>  {
  factory $NoteBlockCopyWith(NoteBlock value, $Res Function(NoteBlock) _then) = _$NoteBlockCopyWithImpl;
@useResult
$Res call({
 NoteBlockKind kind, String text, int level, String marker, int depth, bool quoted
});




}
/// @nodoc
class _$NoteBlockCopyWithImpl<$Res>
    implements $NoteBlockCopyWith<$Res> {
  _$NoteBlockCopyWithImpl(this._self, this._then);

  final NoteBlock _self;
  final $Res Function(NoteBlock) _then;

/// Create a copy of NoteBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? text = null,Object? level = null,Object? marker = null,Object? depth = null,Object? quoted = null,}) {
  return _then(NoteBlock(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NoteBlockKind,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,marker: null == marker ? _self.marker : marker // ignore: cast_nullable_to_non_nullable
as String,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,quoted: null == quoted ? _self.quoted : quoted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteBlock].
extension NoteBlockPatterns on NoteBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteBlock value)  $default,){
final _that = this;
switch (_that) {
case _NoteBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteBlock value)?  $default,){
final _that = this;
switch (_that) {
case _NoteBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NoteBlockKind kind,  String text,  int level,  String marker,  int depth,  bool quoted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteBlock() when $default != null:
return $default(_that.kind,_that.text,_that.level,_that.marker,_that.depth,_that.quoted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NoteBlockKind kind,  String text,  int level,  String marker,  int depth,  bool quoted)  $default,) {final _that = this;
switch (_that) {
case _NoteBlock():
return $default(_that.kind,_that.text,_that.level,_that.marker,_that.depth,_that.quoted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NoteBlockKind kind,  String text,  int level,  String marker,  int depth,  bool quoted)?  $default,) {final _that = this;
switch (_that) {
case _NoteBlock() when $default != null:
return $default(_that.kind,_that.text,_that.level,_that.marker,_that.depth,_that.quoted);case _:
  return null;

}
}

}

/// @nodoc


class _NoteBlock implements NoteBlock {
  const _NoteBlock({required this.kind, this.text = '', this.level = 0, this.marker = '', this.depth = 0, this.quoted = false});
  

@override final  NoteBlockKind kind;
@override@JsonKey() final  String text;
/// 1–3 for a heading, 0 otherwise.
@override@JsonKey() final  int level;
/// «•» or «3.» on a list item's first line; empty on its other lines.
@override@JsonKey() final  String marker;
/// List nesting, 0 outside a list.
@override@JsonKey() final  int depth;
/// Inside a blockquote.
@override@JsonKey() final  bool quoted;

/// Create a copy of NoteBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteBlockCopyWith<_NoteBlock> get copyWith => __$NoteBlockCopyWithImpl<_NoteBlock>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteBlock&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.text, text) || other.text == text)&&(identical(other.level, level) || other.level == level)&&(identical(other.marker, marker) || other.marker == marker)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.quoted, quoted) || other.quoted == quoted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,text,level,marker,depth,quoted);
}

@override
String toString() {
    return 'NoteBlock(kind: $kind, text: $text, level: $level, marker: $marker, depth: $depth, quoted: $quoted)';
}


}

/// @nodoc
abstract mixin class _$NoteBlockCopyWith<$Res> implements $NoteBlockCopyWith<$Res> {
  factory _$NoteBlockCopyWith(_NoteBlock value, $Res Function(_NoteBlock) _then) = __$NoteBlockCopyWithImpl;
@override @useResult
$Res call({
 NoteBlockKind kind, String text, int level, String marker, int depth, bool quoted
});




}
/// @nodoc
class __$NoteBlockCopyWithImpl<$Res>
    implements _$NoteBlockCopyWith<$Res> {
  __$NoteBlockCopyWithImpl(this._self, this._then);

  final _NoteBlock _self;
  final $Res Function(_NoteBlock) _then;

/// Create a copy of NoteBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? text = null,Object? level = null,Object? marker = null,Object? depth = null,Object? quoted = null,}) {
  return _then(_NoteBlock(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NoteBlockKind,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,marker: null == marker ? _self.marker : marker // ignore: cast_nullable_to_non_nullable
as String,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,quoted: null == quoted ? _self.quoted : quoted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
