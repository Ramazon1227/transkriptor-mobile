// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Job {

 String get id; JobStatus get status; String get mediaId;/// 0–100, as the backend reports it.
 int get progress;/// A clean sentence for the person; the raw error stays on the server.
 String? get errorMessage; String? get transcriptId;/// The speaker count chosen at upload; null lets the server decide.
 int? get numSpeakers;/// Estimated seconds left while running; null when the server has no
/// estimate.
 int? get etaSeconds;/// The usual time has passed and the job is still running.
 bool get slow;/// The «Atamalar» list chosen at upload (A-1); null when none, or when
/// it was deleted since.
 String? get glossaryId;/// Terms written for this file only (A-1).
 List<String> get terms;/// How many replacements the chosen list made in the result.
 int get termsApplied;/// The speaker hints marked before transcription (A-3).
 List<SpeakerHint> get speakerHints;
/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCopyWith<Job> get copyWith => _$JobCopyWithImpl<Job>(this as Job, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Job;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Job&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.transcriptId, _this.transcriptId) || other.transcriptId == _this.transcriptId)&&(identical(other.numSpeakers, _this.numSpeakers) || other.numSpeakers == _this.numSpeakers)&&(identical(other.etaSeconds, _this.etaSeconds) || other.etaSeconds == _this.etaSeconds)&&(identical(other.slow, _this.slow) || other.slow == _this.slow)&&(identical(other.glossaryId, _this.glossaryId) || other.glossaryId == _this.glossaryId)&&const DeepCollectionEquality().equals(other.terms, _this.terms)&&(identical(other.termsApplied, _this.termsApplied) || other.termsApplied == _this.termsApplied)&&const DeepCollectionEquality().equals(other.speakerHints, _this.speakerHints));
}


@override
int get hashCode {
  final _this = this as Job;
  return Object.hash(runtimeType,_this.id,_this.status,_this.mediaId,_this.progress,_this.errorMessage,_this.transcriptId,_this.numSpeakers,_this.etaSeconds,_this.slow,_this.glossaryId,const DeepCollectionEquality().hash(_this.terms),_this.termsApplied,const DeepCollectionEquality().hash(_this.speakerHints));
}

@override
String toString() {
  final _this = this as Job;
  return 'Job(id: ${_this.id}, status: ${_this.status}, mediaId: ${_this.mediaId}, progress: ${_this.progress}, errorMessage: ${_this.errorMessage}, transcriptId: ${_this.transcriptId}, numSpeakers: ${_this.numSpeakers}, etaSeconds: ${_this.etaSeconds}, slow: ${_this.slow}, glossaryId: ${_this.glossaryId}, terms: ${_this.terms}, termsApplied: ${_this.termsApplied}, speakerHints: ${_this.speakerHints})';
}


}

/// @nodoc
abstract mixin class $JobCopyWith<$Res>  {
  factory $JobCopyWith(Job value, $Res Function(Job) _then) = _$JobCopyWithImpl;
@useResult
$Res call({
 String id, JobStatus status, String mediaId, int progress, String? errorMessage, String? transcriptId, int? numSpeakers, int? etaSeconds, bool slow, String? glossaryId, List<String> terms, int termsApplied, List<SpeakerHint> speakerHints
});




}
/// @nodoc
class _$JobCopyWithImpl<$Res>
    implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._self, this._then);

  final Job _self;
  final $Res Function(Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? mediaId = null,Object? progress = null,Object? errorMessage = freezed,Object? transcriptId = freezed,Object? numSpeakers = freezed,Object? etaSeconds = freezed,Object? slow = null,Object? glossaryId = freezed,Object? terms = null,Object? termsApplied = null,Object? speakerHints = null,}) {
  return _then(Job(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,numSpeakers: freezed == numSpeakers ? _self.numSpeakers : numSpeakers // ignore: cast_nullable_to_non_nullable
as int?,etaSeconds: freezed == etaSeconds ? _self.etaSeconds : etaSeconds // ignore: cast_nullable_to_non_nullable
as int?,slow: null == slow ? _self.slow : slow // ignore: cast_nullable_to_non_nullable
as bool,glossaryId: freezed == glossaryId ? _self.glossaryId : glossaryId // ignore: cast_nullable_to_non_nullable
as String?,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as List<String>,termsApplied: null == termsApplied ? _self.termsApplied : termsApplied // ignore: cast_nullable_to_non_nullable
as int,speakerHints: null == speakerHints ? _self.speakerHints : speakerHints // ignore: cast_nullable_to_non_nullable
as List<SpeakerHint>,
  ));
}

}


/// Adds pattern-matching-related methods to [Job].
extension JobPatterns on Job {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Job value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Job() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Job value)  $default,){
final _that = this;
switch (_that) {
case _Job():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Job value)?  $default,){
final _that = this;
switch (_that) {
case _Job() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  JobStatus status,  String mediaId,  int progress,  String? errorMessage,  String? transcriptId,  int? numSpeakers,  int? etaSeconds,  bool slow,  String? glossaryId,  List<String> terms,  int termsApplied,  List<SpeakerHint> speakerHints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.id,_that.status,_that.mediaId,_that.progress,_that.errorMessage,_that.transcriptId,_that.numSpeakers,_that.etaSeconds,_that.slow,_that.glossaryId,_that.terms,_that.termsApplied,_that.speakerHints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  JobStatus status,  String mediaId,  int progress,  String? errorMessage,  String? transcriptId,  int? numSpeakers,  int? etaSeconds,  bool slow,  String? glossaryId,  List<String> terms,  int termsApplied,  List<SpeakerHint> speakerHints)  $default,) {final _that = this;
switch (_that) {
case _Job():
return $default(_that.id,_that.status,_that.mediaId,_that.progress,_that.errorMessage,_that.transcriptId,_that.numSpeakers,_that.etaSeconds,_that.slow,_that.glossaryId,_that.terms,_that.termsApplied,_that.speakerHints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  JobStatus status,  String mediaId,  int progress,  String? errorMessage,  String? transcriptId,  int? numSpeakers,  int? etaSeconds,  bool slow,  String? glossaryId,  List<String> terms,  int termsApplied,  List<SpeakerHint> speakerHints)?  $default,) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.id,_that.status,_that.mediaId,_that.progress,_that.errorMessage,_that.transcriptId,_that.numSpeakers,_that.etaSeconds,_that.slow,_that.glossaryId,_that.terms,_that.termsApplied,_that.speakerHints);case _:
  return null;

}
}

}

/// @nodoc


class _Job extends Job {
  const _Job({required this.id, required this.status, this.mediaId = '', this.progress = 0, this.errorMessage, this.transcriptId, this.numSpeakers, this.etaSeconds, this.slow = false, this.glossaryId,  List<String> terms = const <String>[], this.termsApplied = 0,  List<SpeakerHint> speakerHints = const <SpeakerHint>[]}): _terms = terms,_speakerHints = speakerHints,super._();
  

@override final  String id;
@override final  JobStatus status;
@override@JsonKey() final  String mediaId;
/// 0–100, as the backend reports it.
@override@JsonKey() final  int progress;
/// A clean sentence for the person; the raw error stays on the server.
@override final  String? errorMessage;
@override final  String? transcriptId;
/// The speaker count chosen at upload; null lets the server decide.
@override final  int? numSpeakers;
/// Estimated seconds left while running; null when the server has no
/// estimate.
@override final  int? etaSeconds;
/// The usual time has passed and the job is still running.
@override@JsonKey() final  bool slow;
/// The «Atamalar» list chosen at upload (A-1); null when none, or when
/// it was deleted since.
@override final  String? glossaryId;
/// Terms written for this file only (A-1).
 final  List<String> _terms;
/// Terms written for this file only (A-1).
@override@JsonKey() List<String> get terms {
  if (_terms is EqualUnmodifiableListView) return _terms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_terms);
}

/// How many replacements the chosen list made in the result.
@override@JsonKey() final  int termsApplied;
/// The speaker hints marked before transcription (A-3).
 final  List<SpeakerHint> _speakerHints;
/// The speaker hints marked before transcription (A-3).
@override@JsonKey() List<SpeakerHint> get speakerHints {
  if (_speakerHints is EqualUnmodifiableListView) return _speakerHints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_speakerHints);
}


/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCopyWith<_Job> get copyWith => __$JobCopyWithImpl<_Job>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Job&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.transcriptId, transcriptId) || other.transcriptId == transcriptId)&&(identical(other.numSpeakers, numSpeakers) || other.numSpeakers == numSpeakers)&&(identical(other.etaSeconds, etaSeconds) || other.etaSeconds == etaSeconds)&&(identical(other.slow, slow) || other.slow == slow)&&(identical(other.glossaryId, glossaryId) || other.glossaryId == glossaryId)&&const DeepCollectionEquality().equals(other.terms, _terms)&&(identical(other.termsApplied, termsApplied) || other.termsApplied == termsApplied)&&const DeepCollectionEquality().equals(other.speakerHints, _speakerHints));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status,mediaId,progress,errorMessage,transcriptId,numSpeakers,etaSeconds,slow,glossaryId,const DeepCollectionEquality().hash(_terms),termsApplied,const DeepCollectionEquality().hash(_speakerHints));
}

@override
String toString() {
    return 'Job(id: $id, status: $status, mediaId: $mediaId, progress: $progress, errorMessage: $errorMessage, transcriptId: $transcriptId, numSpeakers: $numSpeakers, etaSeconds: $etaSeconds, slow: $slow, glossaryId: $glossaryId, terms: $terms, termsApplied: $termsApplied, speakerHints: $speakerHints)';
}


}

/// @nodoc
abstract mixin class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) _then) = __$JobCopyWithImpl;
@override @useResult
$Res call({
 String id, JobStatus status, String mediaId, int progress, String? errorMessage, String? transcriptId, int? numSpeakers, int? etaSeconds, bool slow, String? glossaryId, List<String> terms, int termsApplied, List<SpeakerHint> speakerHints
});




}
/// @nodoc
class __$JobCopyWithImpl<$Res>
    implements _$JobCopyWith<$Res> {
  __$JobCopyWithImpl(this._self, this._then);

  final _Job _self;
  final $Res Function(_Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? mediaId = null,Object? progress = null,Object? errorMessage = freezed,Object? transcriptId = freezed,Object? numSpeakers = freezed,Object? etaSeconds = freezed,Object? slow = null,Object? glossaryId = freezed,Object? terms = null,Object? termsApplied = null,Object? speakerHints = null,}) {
  return _then(_Job(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,numSpeakers: freezed == numSpeakers ? _self.numSpeakers : numSpeakers // ignore: cast_nullable_to_non_nullable
as int?,etaSeconds: freezed == etaSeconds ? _self.etaSeconds : etaSeconds // ignore: cast_nullable_to_non_nullable
as int?,slow: null == slow ? _self.slow : slow // ignore: cast_nullable_to_non_nullable
as bool,glossaryId: freezed == glossaryId ? _self.glossaryId : glossaryId // ignore: cast_nullable_to_non_nullable
as String?,terms: null == terms ? _self._terms : terms // ignore: cast_nullable_to_non_nullable
as List<String>,termsApplied: null == termsApplied ? _self.termsApplied : termsApplied // ignore: cast_nullable_to_non_nullable
as int,speakerHints: null == speakerHints ? _self._speakerHints : speakerHints // ignore: cast_nullable_to_non_nullable
as List<SpeakerHint>,
  ));
}


}

// dart format on
