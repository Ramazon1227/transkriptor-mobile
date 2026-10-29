// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentiment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SentimentShare {

 double get positive; double get neutral; double get negative; double get score;
/// Create a copy of SentimentShare
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentShareCopyWith<SentimentShare> get copyWith => _$SentimentShareCopyWithImpl<SentimentShare>(this as SentimentShare, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SentimentShare;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentShare&&(identical(other.positive, _this.positive) || other.positive == _this.positive)&&(identical(other.neutral, _this.neutral) || other.neutral == _this.neutral)&&(identical(other.negative, _this.negative) || other.negative == _this.negative)&&(identical(other.score, _this.score) || other.score == _this.score));
}


@override
int get hashCode {
  final _this = this as SentimentShare;
  return Object.hash(runtimeType,_this.positive,_this.neutral,_this.negative,_this.score);
}

@override
String toString() {
  final _this = this as SentimentShare;
  return 'SentimentShare(positive: ${_this.positive}, neutral: ${_this.neutral}, negative: ${_this.negative}, score: ${_this.score})';
}


}

/// @nodoc
abstract mixin class $SentimentShareCopyWith<$Res>  {
  factory $SentimentShareCopyWith(SentimentShare value, $Res Function(SentimentShare) _then) = _$SentimentShareCopyWithImpl;
@useResult
$Res call({
 double positive, double neutral, double negative, double score
});




}
/// @nodoc
class _$SentimentShareCopyWithImpl<$Res>
    implements $SentimentShareCopyWith<$Res> {
  _$SentimentShareCopyWithImpl(this._self, this._then);

  final SentimentShare _self;
  final $Res Function(SentimentShare) _then;

/// Create a copy of SentimentShare
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? positive = null,Object? neutral = null,Object? negative = null,Object? score = null,}) {
  return _then(SentimentShare(
positive: null == positive ? _self.positive : positive // ignore: cast_nullable_to_non_nullable
as double,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as double,negative: null == negative ? _self.negative : negative // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SentimentShare].
extension SentimentSharePatterns on SentimentShare {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentimentShare value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentimentShare() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentimentShare value)  $default,){
final _that = this;
switch (_that) {
case _SentimentShare():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentimentShare value)?  $default,){
final _that = this;
switch (_that) {
case _SentimentShare() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double positive,  double neutral,  double negative,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentimentShare() when $default != null:
return $default(_that.positive,_that.neutral,_that.negative,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double positive,  double neutral,  double negative,  double score)  $default,) {final _that = this;
switch (_that) {
case _SentimentShare():
return $default(_that.positive,_that.neutral,_that.negative,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double positive,  double neutral,  double negative,  double score)?  $default,) {final _that = this;
switch (_that) {
case _SentimentShare() when $default != null:
return $default(_that.positive,_that.neutral,_that.negative,_that.score);case _:
  return null;

}
}

}

/// @nodoc


class _SentimentShare extends SentimentShare {
  const _SentimentShare({this.positive = 0, this.neutral = 0, this.negative = 0, this.score = 0}): super._();
  

@override@JsonKey() final  double positive;
@override@JsonKey() final  double neutral;
@override@JsonKey() final  double negative;
@override@JsonKey() final  double score;

/// Create a copy of SentimentShare
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentShareCopyWith<_SentimentShare> get copyWith => __$SentimentShareCopyWithImpl<_SentimentShare>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentShare&&(identical(other.positive, positive) || other.positive == positive)&&(identical(other.neutral, neutral) || other.neutral == neutral)&&(identical(other.negative, negative) || other.negative == negative)&&(identical(other.score, score) || other.score == score));
}


@override
int get hashCode {
    return Object.hash(runtimeType,positive,neutral,negative,score);
}

@override
String toString() {
    return 'SentimentShare(positive: $positive, neutral: $neutral, negative: $negative, score: $score)';
}


}

/// @nodoc
abstract mixin class _$SentimentShareCopyWith<$Res> implements $SentimentShareCopyWith<$Res> {
  factory _$SentimentShareCopyWith(_SentimentShare value, $Res Function(_SentimentShare) _then) = __$SentimentShareCopyWithImpl;
@override @useResult
$Res call({
 double positive, double neutral, double negative, double score
});




}
/// @nodoc
class __$SentimentShareCopyWithImpl<$Res>
    implements _$SentimentShareCopyWith<$Res> {
  __$SentimentShareCopyWithImpl(this._self, this._then);

  final _SentimentShare _self;
  final $Res Function(_SentimentShare) _then;

/// Create a copy of SentimentShare
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? positive = null,Object? neutral = null,Object? negative = null,Object? score = null,}) {
  return _then(_SentimentShare(
positive: null == positive ? _self.positive : positive // ignore: cast_nullable_to_non_nullable
as double,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as double,negative: null == negative ? _self.negative : negative // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$SpeakerSentiment {

 String? get speakerId; String get label; Duration get talk; SentimentShare get share;
/// Create a copy of SpeakerSentiment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerSentimentCopyWith<SpeakerSentiment> get copyWith => _$SpeakerSentimentCopyWithImpl<SpeakerSentiment>(this as SpeakerSentiment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SpeakerSentiment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakerSentiment&&(identical(other.speakerId, _this.speakerId) || other.speakerId == _this.speakerId)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.talk, _this.talk) || other.talk == _this.talk)&&(identical(other.share, _this.share) || other.share == _this.share));
}


@override
int get hashCode {
  final _this = this as SpeakerSentiment;
  return Object.hash(runtimeType,_this.speakerId,_this.label,_this.talk,_this.share);
}

@override
String toString() {
  final _this = this as SpeakerSentiment;
  return 'SpeakerSentiment(speakerId: ${_this.speakerId}, label: ${_this.label}, talk: ${_this.talk}, share: ${_this.share})';
}


}

/// @nodoc
abstract mixin class $SpeakerSentimentCopyWith<$Res>  {
  factory $SpeakerSentimentCopyWith(SpeakerSentiment value, $Res Function(SpeakerSentiment) _then) = _$SpeakerSentimentCopyWithImpl;
@useResult
$Res call({
 String? speakerId, String label, Duration talk, SentimentShare share
});


$SentimentShareCopyWith<$Res> get share;

}
/// @nodoc
class _$SpeakerSentimentCopyWithImpl<$Res>
    implements $SpeakerSentimentCopyWith<$Res> {
  _$SpeakerSentimentCopyWithImpl(this._self, this._then);

  final SpeakerSentiment _self;
  final $Res Function(SpeakerSentiment) _then;

/// Create a copy of SpeakerSentiment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speakerId = freezed,Object? label = null,Object? talk = null,Object? share = null,}) {
  return _then(SpeakerSentiment(
speakerId: freezed == speakerId ? _self.speakerId : speakerId // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,talk: null == talk ? _self.talk : talk // ignore: cast_nullable_to_non_nullable
as Duration,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as SentimentShare,
  ));
}
/// Create a copy of SpeakerSentiment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentShareCopyWith<$Res> get share {
  
  return $SentimentShareCopyWith<$Res>(_self.share, (value) {
    return _then(_self.copyWith(share: value));
  });
}
}


/// Adds pattern-matching-related methods to [SpeakerSentiment].
extension SpeakerSentimentPatterns on SpeakerSentiment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakerSentiment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakerSentiment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakerSentiment value)  $default,){
final _that = this;
switch (_that) {
case _SpeakerSentiment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakerSentiment value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakerSentiment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? speakerId,  String label,  Duration talk,  SentimentShare share)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakerSentiment() when $default != null:
return $default(_that.speakerId,_that.label,_that.talk,_that.share);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? speakerId,  String label,  Duration talk,  SentimentShare share)  $default,) {final _that = this;
switch (_that) {
case _SpeakerSentiment():
return $default(_that.speakerId,_that.label,_that.talk,_that.share);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? speakerId,  String label,  Duration talk,  SentimentShare share)?  $default,) {final _that = this;
switch (_that) {
case _SpeakerSentiment() when $default != null:
return $default(_that.speakerId,_that.label,_that.talk,_that.share);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakerSentiment implements SpeakerSentiment {
  const _SpeakerSentiment({this.speakerId, this.label = '', this.talk = Duration.zero, this.share = const SentimentShare()});
  

@override final  String? speakerId;
@override@JsonKey() final  String label;
@override@JsonKey() final  Duration talk;
@override@JsonKey() final  SentimentShare share;

/// Create a copy of SpeakerSentiment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerSentimentCopyWith<_SpeakerSentiment> get copyWith => __$SpeakerSentimentCopyWithImpl<_SpeakerSentiment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakerSentiment&&(identical(other.speakerId, speakerId) || other.speakerId == speakerId)&&(identical(other.label, label) || other.label == label)&&(identical(other.talk, talk) || other.talk == talk)&&(identical(other.share, share) || other.share == share));
}


@override
int get hashCode {
    return Object.hash(runtimeType,speakerId,label,talk,share);
}

@override
String toString() {
    return 'SpeakerSentiment(speakerId: $speakerId, label: $label, talk: $talk, share: $share)';
}


}

/// @nodoc
abstract mixin class _$SpeakerSentimentCopyWith<$Res> implements $SpeakerSentimentCopyWith<$Res> {
  factory _$SpeakerSentimentCopyWith(_SpeakerSentiment value, $Res Function(_SpeakerSentiment) _then) = __$SpeakerSentimentCopyWithImpl;
@override @useResult
$Res call({
 String? speakerId, String label, Duration talk, SentimentShare share
});


@override $SentimentShareCopyWith<$Res> get share;

}
/// @nodoc
class __$SpeakerSentimentCopyWithImpl<$Res>
    implements _$SpeakerSentimentCopyWith<$Res> {
  __$SpeakerSentimentCopyWithImpl(this._self, this._then);

  final _SpeakerSentiment _self;
  final $Res Function(_SpeakerSentiment) _then;

/// Create a copy of SpeakerSentiment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speakerId = freezed,Object? label = null,Object? talk = null,Object? share = null,}) {
  return _then(_SpeakerSentiment(
speakerId: freezed == speakerId ? _self.speakerId : speakerId // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,talk: null == talk ? _self.talk : talk // ignore: cast_nullable_to_non_nullable
as Duration,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as SentimentShare,
  ));
}

/// Create a copy of SpeakerSentiment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentShareCopyWith<$Res> get share {
  
  return $SentimentShareCopyWith<$Res>(_self.share, (value) {
    return _then(_self.copyWith(share: value));
  });
}
}

/// @nodoc
mixin _$SentimentAnalysis {

 SentimentStatus get status;/// A 1–2 sentence Uzbek note from the model; empty until `DONE`.
 String get note;/// A fixed Uzbek sentence from the server when the run `FAILED`.
 String? get error; int get attempt; String get model;/// The transcript text changed after the analysis: offer a re-run.
 bool get outdated;/// Segments created after the analysis (a split): not counted.
 int get unlabeled; SentimentShare get overall; List<SpeakerSentiment> get speakers;/// Segment id → label, in the server's order. Empty unless `DONE`.
 Map<String, SentimentLabel> get labels; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentAnalysisCopyWith<SentimentAnalysis> get copyWith => _$SentimentAnalysisCopyWithImpl<SentimentAnalysis>(this as SentimentAnalysis, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SentimentAnalysis;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentAnalysis&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.attempt, _this.attempt) || other.attempt == _this.attempt)&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.outdated, _this.outdated) || other.outdated == _this.outdated)&&(identical(other.unlabeled, _this.unlabeled) || other.unlabeled == _this.unlabeled)&&(identical(other.overall, _this.overall) || other.overall == _this.overall)&&const DeepCollectionEquality().equals(other.speakers, _this.speakers)&&const DeepCollectionEquality().equals(other.labels, _this.labels)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as SentimentAnalysis;
  return Object.hash(runtimeType,_this.status,_this.note,_this.error,_this.attempt,_this.model,_this.outdated,_this.unlabeled,_this.overall,const DeepCollectionEquality().hash(_this.speakers),const DeepCollectionEquality().hash(_this.labels),_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as SentimentAnalysis;
  return 'SentimentAnalysis(status: ${_this.status}, note: ${_this.note}, error: ${_this.error}, attempt: ${_this.attempt}, model: ${_this.model}, outdated: ${_this.outdated}, unlabeled: ${_this.unlabeled}, overall: ${_this.overall}, speakers: ${_this.speakers}, labels: ${_this.labels}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $SentimentAnalysisCopyWith<$Res>  {
  factory $SentimentAnalysisCopyWith(SentimentAnalysis value, $Res Function(SentimentAnalysis) _then) = _$SentimentAnalysisCopyWithImpl;
@useResult
$Res call({
 SentimentStatus status, String note, String? error, int attempt, String model, bool outdated, int unlabeled, SentimentShare overall, List<SpeakerSentiment> speakers, Map<String, SentimentLabel> labels, DateTime? createdAt, DateTime? updatedAt
});


$SentimentShareCopyWith<$Res> get overall;

}
/// @nodoc
class _$SentimentAnalysisCopyWithImpl<$Res>
    implements $SentimentAnalysisCopyWith<$Res> {
  _$SentimentAnalysisCopyWithImpl(this._self, this._then);

  final SentimentAnalysis _self;
  final $Res Function(SentimentAnalysis) _then;

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? note = null,Object? error = freezed,Object? attempt = null,Object? model = null,Object? outdated = null,Object? unlabeled = null,Object? overall = null,Object? speakers = null,Object? labels = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(SentimentAnalysis(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SentimentStatus,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,outdated: null == outdated ? _self.outdated : outdated // ignore: cast_nullable_to_non_nullable
as bool,unlabeled: null == unlabeled ? _self.unlabeled : unlabeled // ignore: cast_nullable_to_non_nullable
as int,overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as SentimentShare,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<SpeakerSentiment>,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as Map<String, SentimentLabel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentShareCopyWith<$Res> get overall {
  
  return $SentimentShareCopyWith<$Res>(_self.overall, (value) {
    return _then(_self.copyWith(overall: value));
  });
}
}


/// Adds pattern-matching-related methods to [SentimentAnalysis].
extension SentimentAnalysisPatterns on SentimentAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentimentAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentimentAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentimentAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _SentimentAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentimentAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _SentimentAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SentimentStatus status,  String note,  String? error,  int attempt,  String model,  bool outdated,  int unlabeled,  SentimentShare overall,  List<SpeakerSentiment> speakers,  Map<String, SentimentLabel> labels,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentimentAnalysis() when $default != null:
return $default(_that.status,_that.note,_that.error,_that.attempt,_that.model,_that.outdated,_that.unlabeled,_that.overall,_that.speakers,_that.labels,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SentimentStatus status,  String note,  String? error,  int attempt,  String model,  bool outdated,  int unlabeled,  SentimentShare overall,  List<SpeakerSentiment> speakers,  Map<String, SentimentLabel> labels,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SentimentAnalysis():
return $default(_that.status,_that.note,_that.error,_that.attempt,_that.model,_that.outdated,_that.unlabeled,_that.overall,_that.speakers,_that.labels,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SentimentStatus status,  String note,  String? error,  int attempt,  String model,  bool outdated,  int unlabeled,  SentimentShare overall,  List<SpeakerSentiment> speakers,  Map<String, SentimentLabel> labels,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SentimentAnalysis() when $default != null:
return $default(_that.status,_that.note,_that.error,_that.attempt,_that.model,_that.outdated,_that.unlabeled,_that.overall,_that.speakers,_that.labels,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SentimentAnalysis extends SentimentAnalysis {
  const _SentimentAnalysis({required this.status, this.note = '', this.error, this.attempt = 0, this.model = '', this.outdated = false, this.unlabeled = 0, this.overall = const SentimentShare(),  List<SpeakerSentiment> speakers = const <SpeakerSentiment>[],  Map<String, SentimentLabel> labels = const <String, SentimentLabel>{}, this.createdAt, this.updatedAt}): _speakers = speakers,_labels = labels,super._();
  

@override final  SentimentStatus status;
/// A 1–2 sentence Uzbek note from the model; empty until `DONE`.
@override@JsonKey() final  String note;
/// A fixed Uzbek sentence from the server when the run `FAILED`.
@override final  String? error;
@override@JsonKey() final  int attempt;
@override@JsonKey() final  String model;
/// The transcript text changed after the analysis: offer a re-run.
@override@JsonKey() final  bool outdated;
/// Segments created after the analysis (a split): not counted.
@override@JsonKey() final  int unlabeled;
@override@JsonKey() final  SentimentShare overall;
 final  List<SpeakerSentiment> _speakers;
@override@JsonKey() List<SpeakerSentiment> get speakers {
  if (_speakers is EqualUnmodifiableListView) return _speakers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_speakers);
}

/// Segment id → label, in the server's order. Empty unless `DONE`.
 final  Map<String, SentimentLabel> _labels;
/// Segment id → label, in the server's order. Empty unless `DONE`.
@override@JsonKey() Map<String, SentimentLabel> get labels {
  if (_labels is EqualUnmodifiableMapView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_labels);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentAnalysisCopyWith<_SentimentAnalysis> get copyWith => __$SentimentAnalysisCopyWithImpl<_SentimentAnalysis>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentAnalysis&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.error, error) || other.error == error)&&(identical(other.attempt, attempt) || other.attempt == attempt)&&(identical(other.model, model) || other.model == model)&&(identical(other.outdated, outdated) || other.outdated == outdated)&&(identical(other.unlabeled, unlabeled) || other.unlabeled == unlabeled)&&(identical(other.overall, overall) || other.overall == overall)&&const DeepCollectionEquality().equals(other.speakers, _speakers)&&const DeepCollectionEquality().equals(other.labels, _labels)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,note,error,attempt,model,outdated,unlabeled,overall,const DeepCollectionEquality().hash(_speakers),const DeepCollectionEquality().hash(_labels),createdAt,updatedAt);
}

@override
String toString() {
    return 'SentimentAnalysis(status: $status, note: $note, error: $error, attempt: $attempt, model: $model, outdated: $outdated, unlabeled: $unlabeled, overall: $overall, speakers: $speakers, labels: $labels, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SentimentAnalysisCopyWith<$Res> implements $SentimentAnalysisCopyWith<$Res> {
  factory _$SentimentAnalysisCopyWith(_SentimentAnalysis value, $Res Function(_SentimentAnalysis) _then) = __$SentimentAnalysisCopyWithImpl;
@override @useResult
$Res call({
 SentimentStatus status, String note, String? error, int attempt, String model, bool outdated, int unlabeled, SentimentShare overall, List<SpeakerSentiment> speakers, Map<String, SentimentLabel> labels, DateTime? createdAt, DateTime? updatedAt
});


@override $SentimentShareCopyWith<$Res> get overall;

}
/// @nodoc
class __$SentimentAnalysisCopyWithImpl<$Res>
    implements _$SentimentAnalysisCopyWith<$Res> {
  __$SentimentAnalysisCopyWithImpl(this._self, this._then);

  final _SentimentAnalysis _self;
  final $Res Function(_SentimentAnalysis) _then;

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? note = null,Object? error = freezed,Object? attempt = null,Object? model = null,Object? outdated = null,Object? unlabeled = null,Object? overall = null,Object? speakers = null,Object? labels = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SentimentAnalysis(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SentimentStatus,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,outdated: null == outdated ? _self.outdated : outdated // ignore: cast_nullable_to_non_nullable
as bool,unlabeled: null == unlabeled ? _self.unlabeled : unlabeled // ignore: cast_nullable_to_non_nullable
as int,overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as SentimentShare,speakers: null == speakers ? _self._speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<SpeakerSentiment>,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as Map<String, SentimentLabel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentShareCopyWith<$Res> get overall {
  
  return $SentimentShareCopyWith<$Res>(_self.overall, (value) {
    return _then(_self.copyWith(overall: value));
  });
}
}

// dart format on
