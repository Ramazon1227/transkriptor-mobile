// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeakerHint {

 String get label; int get startMs; int get endMs;
/// Create a copy of SpeakerHint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerHintCopyWith<SpeakerHint> get copyWith => _$SpeakerHintCopyWithImpl<SpeakerHint>(this as SpeakerHint, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SpeakerHint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakerHint&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.startMs, _this.startMs) || other.startMs == _this.startMs)&&(identical(other.endMs, _this.endMs) || other.endMs == _this.endMs));
}


@override
int get hashCode {
  final _this = this as SpeakerHint;
  return Object.hash(runtimeType,_this.label,_this.startMs,_this.endMs);
}

@override
String toString() {
  final _this = this as SpeakerHint;
  return 'SpeakerHint(label: ${_this.label}, startMs: ${_this.startMs}, endMs: ${_this.endMs})';
}


}

/// @nodoc
abstract mixin class $SpeakerHintCopyWith<$Res>  {
  factory $SpeakerHintCopyWith(SpeakerHint value, $Res Function(SpeakerHint) _then) = _$SpeakerHintCopyWithImpl;
@useResult
$Res call({
 String label, int startMs, int endMs
});




}
/// @nodoc
class _$SpeakerHintCopyWithImpl<$Res>
    implements $SpeakerHintCopyWith<$Res> {
  _$SpeakerHintCopyWithImpl(this._self, this._then);

  final SpeakerHint _self;
  final $Res Function(SpeakerHint) _then;

/// Create a copy of SpeakerHint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? startMs = null,Object? endMs = null,}) {
  return _then(SpeakerHint(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,startMs: null == startMs ? _self.startMs : startMs // ignore: cast_nullable_to_non_nullable
as int,endMs: null == endMs ? _self.endMs : endMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakerHint].
extension SpeakerHintPatterns on SpeakerHint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakerHint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakerHint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakerHint value)  $default,){
final _that = this;
switch (_that) {
case _SpeakerHint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakerHint value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakerHint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int startMs,  int endMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakerHint() when $default != null:
return $default(_that.label,_that.startMs,_that.endMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int startMs,  int endMs)  $default,) {final _that = this;
switch (_that) {
case _SpeakerHint():
return $default(_that.label,_that.startMs,_that.endMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int startMs,  int endMs)?  $default,) {final _that = this;
switch (_that) {
case _SpeakerHint() when $default != null:
return $default(_that.label,_that.startMs,_that.endMs);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakerHint implements SpeakerHint {
  const _SpeakerHint({required this.label, required this.startMs, required this.endMs});
  

@override final  String label;
@override final  int startMs;
@override final  int endMs;

/// Create a copy of SpeakerHint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerHintCopyWith<_SpeakerHint> get copyWith => __$SpeakerHintCopyWithImpl<_SpeakerHint>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakerHint&&(identical(other.label, label) || other.label == label)&&(identical(other.startMs, startMs) || other.startMs == startMs)&&(identical(other.endMs, endMs) || other.endMs == endMs));
}


@override
int get hashCode {
    return Object.hash(runtimeType,label,startMs,endMs);
}

@override
String toString() {
    return 'SpeakerHint(label: $label, startMs: $startMs, endMs: $endMs)';
}


}

/// @nodoc
abstract mixin class _$SpeakerHintCopyWith<$Res> implements $SpeakerHintCopyWith<$Res> {
  factory _$SpeakerHintCopyWith(_SpeakerHint value, $Res Function(_SpeakerHint) _then) = __$SpeakerHintCopyWithImpl;
@override @useResult
$Res call({
 String label, int startMs, int endMs
});




}
/// @nodoc
class __$SpeakerHintCopyWithImpl<$Res>
    implements _$SpeakerHintCopyWith<$Res> {
  __$SpeakerHintCopyWithImpl(this._self, this._then);

  final _SpeakerHint _self;
  final $Res Function(_SpeakerHint) _then;

/// Create a copy of SpeakerHint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? startMs = null,Object? endMs = null,}) {
  return _then(_SpeakerHint(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,startMs: null == startMs ? _self.startMs : startMs // ignore: cast_nullable_to_non_nullable
as int,endMs: null == endMs ? _self.endMs : endMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$JobOptions {

/// A live «Atamalar» list of the job's workspace.
 String? get glossaryId;/// Terms for this file only, already cleaned (`AdvancedRules`).
 List<String> get terms;/// This file's speaker hints, sorted by start.
 List<SpeakerHint> get speakerHints;
/// Create a copy of JobOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobOptionsCopyWith<JobOptions> get copyWith => _$JobOptionsCopyWithImpl<JobOptions>(this as JobOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JobOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobOptions&&(identical(other.glossaryId, _this.glossaryId) || other.glossaryId == _this.glossaryId)&&const DeepCollectionEquality().equals(other.terms, _this.terms)&&const DeepCollectionEquality().equals(other.speakerHints, _this.speakerHints));
}


@override
int get hashCode {
  final _this = this as JobOptions;
  return Object.hash(runtimeType,_this.glossaryId,const DeepCollectionEquality().hash(_this.terms),const DeepCollectionEquality().hash(_this.speakerHints));
}

@override
String toString() {
  final _this = this as JobOptions;
  return 'JobOptions(glossaryId: ${_this.glossaryId}, terms: ${_this.terms}, speakerHints: ${_this.speakerHints})';
}


}

/// @nodoc
abstract mixin class $JobOptionsCopyWith<$Res>  {
  factory $JobOptionsCopyWith(JobOptions value, $Res Function(JobOptions) _then) = _$JobOptionsCopyWithImpl;
@useResult
$Res call({
 String? glossaryId, List<String> terms, List<SpeakerHint> speakerHints
});




}
/// @nodoc
class _$JobOptionsCopyWithImpl<$Res>
    implements $JobOptionsCopyWith<$Res> {
  _$JobOptionsCopyWithImpl(this._self, this._then);

  final JobOptions _self;
  final $Res Function(JobOptions) _then;

/// Create a copy of JobOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? glossaryId = freezed,Object? terms = null,Object? speakerHints = null,}) {
  return _then(JobOptions(
glossaryId: freezed == glossaryId ? _self.glossaryId : glossaryId // ignore: cast_nullable_to_non_nullable
as String?,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as List<String>,speakerHints: null == speakerHints ? _self.speakerHints : speakerHints // ignore: cast_nullable_to_non_nullable
as List<SpeakerHint>,
  ));
}

}


/// Adds pattern-matching-related methods to [JobOptions].
extension JobOptionsPatterns on JobOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobOptions value)  $default,){
final _that = this;
switch (_that) {
case _JobOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobOptions value)?  $default,){
final _that = this;
switch (_that) {
case _JobOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? glossaryId,  List<String> terms,  List<SpeakerHint> speakerHints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobOptions() when $default != null:
return $default(_that.glossaryId,_that.terms,_that.speakerHints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? glossaryId,  List<String> terms,  List<SpeakerHint> speakerHints)  $default,) {final _that = this;
switch (_that) {
case _JobOptions():
return $default(_that.glossaryId,_that.terms,_that.speakerHints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? glossaryId,  List<String> terms,  List<SpeakerHint> speakerHints)?  $default,) {final _that = this;
switch (_that) {
case _JobOptions() when $default != null:
return $default(_that.glossaryId,_that.terms,_that.speakerHints);case _:
  return null;

}
}

}

/// @nodoc


class _JobOptions extends JobOptions {
  const _JobOptions({this.glossaryId,  List<String> terms = const <String>[],  List<SpeakerHint> speakerHints = const <SpeakerHint>[]}): _terms = terms,_speakerHints = speakerHints,super._();
  

/// A live «Atamalar» list of the job's workspace.
@override final  String? glossaryId;
/// Terms for this file only, already cleaned (`AdvancedRules`).
 final  List<String> _terms;
/// Terms for this file only, already cleaned (`AdvancedRules`).
@override@JsonKey() List<String> get terms {
  if (_terms is EqualUnmodifiableListView) return _terms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_terms);
}

/// This file's speaker hints, sorted by start.
 final  List<SpeakerHint> _speakerHints;
/// This file's speaker hints, sorted by start.
@override@JsonKey() List<SpeakerHint> get speakerHints {
  if (_speakerHints is EqualUnmodifiableListView) return _speakerHints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_speakerHints);
}


/// Create a copy of JobOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobOptionsCopyWith<_JobOptions> get copyWith => __$JobOptionsCopyWithImpl<_JobOptions>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobOptions&&(identical(other.glossaryId, glossaryId) || other.glossaryId == glossaryId)&&const DeepCollectionEquality().equals(other.terms, _terms)&&const DeepCollectionEquality().equals(other.speakerHints, _speakerHints));
}


@override
int get hashCode {
    return Object.hash(runtimeType,glossaryId,const DeepCollectionEquality().hash(_terms),const DeepCollectionEquality().hash(_speakerHints));
}

@override
String toString() {
    return 'JobOptions(glossaryId: $glossaryId, terms: $terms, speakerHints: $speakerHints)';
}


}

/// @nodoc
abstract mixin class _$JobOptionsCopyWith<$Res> implements $JobOptionsCopyWith<$Res> {
  factory _$JobOptionsCopyWith(_JobOptions value, $Res Function(_JobOptions) _then) = __$JobOptionsCopyWithImpl;
@override @useResult
$Res call({
 String? glossaryId, List<String> terms, List<SpeakerHint> speakerHints
});




}
/// @nodoc
class __$JobOptionsCopyWithImpl<$Res>
    implements _$JobOptionsCopyWith<$Res> {
  __$JobOptionsCopyWithImpl(this._self, this._then);

  final _JobOptions _self;
  final $Res Function(_JobOptions) _then;

/// Create a copy of JobOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? glossaryId = freezed,Object? terms = null,Object? speakerHints = null,}) {
  return _then(_JobOptions(
glossaryId: freezed == glossaryId ? _self.glossaryId : glossaryId // ignore: cast_nullable_to_non_nullable
as String?,terms: null == terms ? _self._terms : terms // ignore: cast_nullable_to_non_nullable
as List<String>,speakerHints: null == speakerHints ? _self._speakerHints : speakerHints // ignore: cast_nullable_to_non_nullable
as List<SpeakerHint>,
  ));
}


}

// dart format on
