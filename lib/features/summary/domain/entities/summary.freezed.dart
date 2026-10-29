// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SummarySection {

 SummarySectionKind get kind;/// Null for a known [kind]: the UI supplies the heading.
 String? get title; String? get paragraph; List<String> get bullets;
/// Create a copy of SummarySection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummarySectionCopyWith<SummarySection> get copyWith => _$SummarySectionCopyWithImpl<SummarySection>(this as SummarySection, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SummarySection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummarySection&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.paragraph, _this.paragraph) || other.paragraph == _this.paragraph)&&const DeepCollectionEquality().equals(other.bullets, _this.bullets));
}


@override
int get hashCode {
  final _this = this as SummarySection;
  return Object.hash(runtimeType,_this.kind,_this.title,_this.paragraph,const DeepCollectionEquality().hash(_this.bullets));
}

@override
String toString() {
  final _this = this as SummarySection;
  return 'SummarySection(kind: ${_this.kind}, title: ${_this.title}, paragraph: ${_this.paragraph}, bullets: ${_this.bullets})';
}


}

/// @nodoc
abstract mixin class $SummarySectionCopyWith<$Res>  {
  factory $SummarySectionCopyWith(SummarySection value, $Res Function(SummarySection) _then) = _$SummarySectionCopyWithImpl;
@useResult
$Res call({
 SummarySectionKind kind, String? title, String? paragraph, List<String> bullets
});




}
/// @nodoc
class _$SummarySectionCopyWithImpl<$Res>
    implements $SummarySectionCopyWith<$Res> {
  _$SummarySectionCopyWithImpl(this._self, this._then);

  final SummarySection _self;
  final $Res Function(SummarySection) _then;

/// Create a copy of SummarySection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? title = freezed,Object? paragraph = freezed,Object? bullets = null,}) {
  return _then(SummarySection(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SummarySectionKind,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,paragraph: freezed == paragraph ? _self.paragraph : paragraph // ignore: cast_nullable_to_non_nullable
as String?,bullets: null == bullets ? _self.bullets : bullets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SummarySection].
extension SummarySectionPatterns on SummarySection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummarySection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummarySection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummarySection value)  $default,){
final _that = this;
switch (_that) {
case _SummarySection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummarySection value)?  $default,){
final _that = this;
switch (_that) {
case _SummarySection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SummarySectionKind kind,  String? title,  String? paragraph,  List<String> bullets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummarySection() when $default != null:
return $default(_that.kind,_that.title,_that.paragraph,_that.bullets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SummarySectionKind kind,  String? title,  String? paragraph,  List<String> bullets)  $default,) {final _that = this;
switch (_that) {
case _SummarySection():
return $default(_that.kind,_that.title,_that.paragraph,_that.bullets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SummarySectionKind kind,  String? title,  String? paragraph,  List<String> bullets)?  $default,) {final _that = this;
switch (_that) {
case _SummarySection() when $default != null:
return $default(_that.kind,_that.title,_that.paragraph,_that.bullets);case _:
  return null;

}
}

}

/// @nodoc


class _SummarySection implements SummarySection {
  const _SummarySection({required this.kind, this.title, this.paragraph,  List<String> bullets = const <String>[]}): _bullets = bullets;
  

@override final  SummarySectionKind kind;
/// Null for a known [kind]: the UI supplies the heading.
@override final  String? title;
@override final  String? paragraph;
 final  List<String> _bullets;
@override@JsonKey() List<String> get bullets {
  if (_bullets is EqualUnmodifiableListView) return _bullets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bullets);
}


/// Create a copy of SummarySection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummarySectionCopyWith<_SummarySection> get copyWith => __$SummarySectionCopyWithImpl<_SummarySection>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummarySection&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.paragraph, paragraph) || other.paragraph == paragraph)&&const DeepCollectionEquality().equals(other.bullets, _bullets));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,title,paragraph,const DeepCollectionEquality().hash(_bullets));
}

@override
String toString() {
    return 'SummarySection(kind: $kind, title: $title, paragraph: $paragraph, bullets: $bullets)';
}


}

/// @nodoc
abstract mixin class _$SummarySectionCopyWith<$Res> implements $SummarySectionCopyWith<$Res> {
  factory _$SummarySectionCopyWith(_SummarySection value, $Res Function(_SummarySection) _then) = __$SummarySectionCopyWithImpl;
@override @useResult
$Res call({
 SummarySectionKind kind, String? title, String? paragraph, List<String> bullets
});




}
/// @nodoc
class __$SummarySectionCopyWithImpl<$Res>
    implements _$SummarySectionCopyWith<$Res> {
  __$SummarySectionCopyWithImpl(this._self, this._then);

  final _SummarySection _self;
  final $Res Function(_SummarySection) _then;

/// Create a copy of SummarySection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = freezed,Object? paragraph = freezed,Object? bullets = null,}) {
  return _then(_SummarySection(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SummarySectionKind,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,paragraph: freezed == paragraph ? _self.paragraph : paragraph // ignore: cast_nullable_to_non_nullable
as String?,bullets: null == bullets ? _self._bullets : bullets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$Summary {

/// Null: the default template.
 String? get templateId; String? get templateName; List<SummarySection> get sections; DateTime? get createdAt;
/// Create a copy of Summary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryCopyWith<Summary> get copyWith => _$SummaryCopyWithImpl<Summary>(this as Summary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Summary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Summary&&(identical(other.templateId, _this.templateId) || other.templateId == _this.templateId)&&(identical(other.templateName, _this.templateName) || other.templateName == _this.templateName)&&const DeepCollectionEquality().equals(other.sections, _this.sections)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as Summary;
  return Object.hash(runtimeType,_this.templateId,_this.templateName,const DeepCollectionEquality().hash(_this.sections),_this.createdAt);
}

@override
String toString() {
  final _this = this as Summary;
  return 'Summary(templateId: ${_this.templateId}, templateName: ${_this.templateName}, sections: ${_this.sections}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $SummaryCopyWith<$Res>  {
  factory $SummaryCopyWith(Summary value, $Res Function(Summary) _then) = _$SummaryCopyWithImpl;
@useResult
$Res call({
 String? templateId, String? templateName, List<SummarySection> sections, DateTime? createdAt
});




}
/// @nodoc
class _$SummaryCopyWithImpl<$Res>
    implements $SummaryCopyWith<$Res> {
  _$SummaryCopyWithImpl(this._self, this._then);

  final Summary _self;
  final $Res Function(Summary) _then;

/// Create a copy of Summary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? templateId = freezed,Object? templateName = freezed,Object? sections = null,Object? createdAt = freezed,}) {
  return _then(Summary(
templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,templateName: freezed == templateName ? _self.templateName : templateName // ignore: cast_nullable_to_non_nullable
as String?,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<SummarySection>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Summary].
extension SummaryPatterns on Summary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Summary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Summary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Summary value)  $default,){
final _that = this;
switch (_that) {
case _Summary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Summary value)?  $default,){
final _that = this;
switch (_that) {
case _Summary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? templateId,  String? templateName,  List<SummarySection> sections,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Summary() when $default != null:
return $default(_that.templateId,_that.templateName,_that.sections,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? templateId,  String? templateName,  List<SummarySection> sections,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Summary():
return $default(_that.templateId,_that.templateName,_that.sections,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? templateId,  String? templateName,  List<SummarySection> sections,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Summary() when $default != null:
return $default(_that.templateId,_that.templateName,_that.sections,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Summary implements Summary {
  const _Summary({this.templateId, this.templateName,  List<SummarySection> sections = const <SummarySection>[], this.createdAt}): _sections = sections;
  

/// Null: the default template.
@override final  String? templateId;
@override final  String? templateName;
 final  List<SummarySection> _sections;
@override@JsonKey() List<SummarySection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  DateTime? createdAt;

/// Create a copy of Summary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryCopyWith<_Summary> get copyWith => __$SummaryCopyWithImpl<_Summary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Summary&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.templateName, templateName) || other.templateName == templateName)&&const DeepCollectionEquality().equals(other.sections, _sections)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,templateId,templateName,const DeepCollectionEquality().hash(_sections),createdAt);
}

@override
String toString() {
    return 'Summary(templateId: $templateId, templateName: $templateName, sections: $sections, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SummaryCopyWith<$Res> implements $SummaryCopyWith<$Res> {
  factory _$SummaryCopyWith(_Summary value, $Res Function(_Summary) _then) = __$SummaryCopyWithImpl;
@override @useResult
$Res call({
 String? templateId, String? templateName, List<SummarySection> sections, DateTime? createdAt
});




}
/// @nodoc
class __$SummaryCopyWithImpl<$Res>
    implements _$SummaryCopyWith<$Res> {
  __$SummaryCopyWithImpl(this._self, this._then);

  final _Summary _self;
  final $Res Function(_Summary) _then;

/// Create a copy of Summary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? templateId = freezed,Object? templateName = freezed,Object? sections = null,Object? createdAt = freezed,}) {
  return _then(_Summary(
templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,templateName: freezed == templateName ? _self.templateName : templateName // ignore: cast_nullable_to_non_nullable
as String?,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<SummarySection>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
