// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentiment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SentimentShareModel {

@JsonKey(name: 'positive') double get positive;@JsonKey(name: 'neutral') double get neutral;@JsonKey(name: 'negative') double get negative;@JsonKey(name: 'score') double get score;
/// Create a copy of SentimentShareModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentShareModelCopyWith<SentimentShareModel> get copyWith => _$SentimentShareModelCopyWithImpl<SentimentShareModel>(this as SentimentShareModel, _$identity);

  /// Serializes this SentimentShareModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SentimentShareModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentShareModel&&(identical(other.positive, _this.positive) || other.positive == _this.positive)&&(identical(other.neutral, _this.neutral) || other.neutral == _this.neutral)&&(identical(other.negative, _this.negative) || other.negative == _this.negative)&&(identical(other.score, _this.score) || other.score == _this.score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SentimentShareModel;
  return Object.hash(runtimeType,_this.positive,_this.neutral,_this.negative,_this.score);
}

@override
String toString() {
  final _this = this as SentimentShareModel;
  return 'SentimentShareModel(positive: ${_this.positive}, neutral: ${_this.neutral}, negative: ${_this.negative}, score: ${_this.score})';
}


}

/// @nodoc
abstract mixin class $SentimentShareModelCopyWith<$Res>  {
  factory $SentimentShareModelCopyWith(SentimentShareModel value, $Res Function(SentimentShareModel) _then) = _$SentimentShareModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'positive') double positive,@JsonKey(name: 'neutral') double neutral,@JsonKey(name: 'negative') double negative,@JsonKey(name: 'score') double score
});




}
/// @nodoc
class _$SentimentShareModelCopyWithImpl<$Res>
    implements $SentimentShareModelCopyWith<$Res> {
  _$SentimentShareModelCopyWithImpl(this._self, this._then);

  final SentimentShareModel _self;
  final $Res Function(SentimentShareModel) _then;

/// Create a copy of SentimentShareModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? positive = null,Object? neutral = null,Object? negative = null,Object? score = null,}) {
  return _then(SentimentShareModel(
positive: null == positive ? _self.positive : positive // ignore: cast_nullable_to_non_nullable
as double,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as double,negative: null == negative ? _self.negative : negative // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SentimentShareModel].
extension SentimentShareModelPatterns on SentimentShareModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentimentShareModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentimentShareModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentimentShareModel value)  $default,){
final _that = this;
switch (_that) {
case _SentimentShareModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentimentShareModel value)?  $default,){
final _that = this;
switch (_that) {
case _SentimentShareModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'positive')  double positive, @JsonKey(name: 'neutral')  double neutral, @JsonKey(name: 'negative')  double negative, @JsonKey(name: 'score')  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentimentShareModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'positive')  double positive, @JsonKey(name: 'neutral')  double neutral, @JsonKey(name: 'negative')  double negative, @JsonKey(name: 'score')  double score)  $default,) {final _that = this;
switch (_that) {
case _SentimentShareModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'positive')  double positive, @JsonKey(name: 'neutral')  double neutral, @JsonKey(name: 'negative')  double negative, @JsonKey(name: 'score')  double score)?  $default,) {final _that = this;
switch (_that) {
case _SentimentShareModel() when $default != null:
return $default(_that.positive,_that.neutral,_that.negative,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SentimentShareModel extends SentimentShareModel {
  const _SentimentShareModel({@JsonKey(name: 'positive') this.positive = 0, @JsonKey(name: 'neutral') this.neutral = 0, @JsonKey(name: 'negative') this.negative = 0, @JsonKey(name: 'score') this.score = 0}): super._();
  factory _SentimentShareModel.fromJson(Map<String, dynamic> json) => _$SentimentShareModelFromJson(json);

@override@JsonKey(name: 'positive') final  double positive;
@override@JsonKey(name: 'neutral') final  double neutral;
@override@JsonKey(name: 'negative') final  double negative;
@override@JsonKey(name: 'score') final  double score;

/// Create a copy of SentimentShareModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentShareModelCopyWith<_SentimentShareModel> get copyWith => __$SentimentShareModelCopyWithImpl<_SentimentShareModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SentimentShareModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentShareModel&&(identical(other.positive, positive) || other.positive == positive)&&(identical(other.neutral, neutral) || other.neutral == neutral)&&(identical(other.negative, negative) || other.negative == negative)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,positive,neutral,negative,score);
}

@override
String toString() {
    return 'SentimentShareModel(positive: $positive, neutral: $neutral, negative: $negative, score: $score)';
}


}

/// @nodoc
abstract mixin class _$SentimentShareModelCopyWith<$Res> implements $SentimentShareModelCopyWith<$Res> {
  factory _$SentimentShareModelCopyWith(_SentimentShareModel value, $Res Function(_SentimentShareModel) _then) = __$SentimentShareModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'positive') double positive,@JsonKey(name: 'neutral') double neutral,@JsonKey(name: 'negative') double negative,@JsonKey(name: 'score') double score
});




}
/// @nodoc
class __$SentimentShareModelCopyWithImpl<$Res>
    implements _$SentimentShareModelCopyWith<$Res> {
  __$SentimentShareModelCopyWithImpl(this._self, this._then);

  final _SentimentShareModel _self;
  final $Res Function(_SentimentShareModel) _then;

/// Create a copy of SentimentShareModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? positive = null,Object? neutral = null,Object? negative = null,Object? score = null,}) {
  return _then(_SentimentShareModel(
positive: null == positive ? _self.positive : positive // ignore: cast_nullable_to_non_nullable
as double,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as double,negative: null == negative ? _self.negative : negative // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SpeakerSentimentModel {

@JsonKey(name: 'speaker_id') String? get speakerId;@JsonKey(name: 'label') String get label;@JsonKey(name: 'talk_ms') int get talkMs;@JsonKey(name: 'positive') double get positive;@JsonKey(name: 'neutral') double get neutral;@JsonKey(name: 'negative') double get negative;@JsonKey(name: 'score') double get score;
/// Create a copy of SpeakerSentimentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerSentimentModelCopyWith<SpeakerSentimentModel> get copyWith => _$SpeakerSentimentModelCopyWithImpl<SpeakerSentimentModel>(this as SpeakerSentimentModel, _$identity);

  /// Serializes this SpeakerSentimentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpeakerSentimentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakerSentimentModel&&(identical(other.speakerId, _this.speakerId) || other.speakerId == _this.speakerId)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.talkMs, _this.talkMs) || other.talkMs == _this.talkMs)&&(identical(other.positive, _this.positive) || other.positive == _this.positive)&&(identical(other.neutral, _this.neutral) || other.neutral == _this.neutral)&&(identical(other.negative, _this.negative) || other.negative == _this.negative)&&(identical(other.score, _this.score) || other.score == _this.score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpeakerSentimentModel;
  return Object.hash(runtimeType,_this.speakerId,_this.label,_this.talkMs,_this.positive,_this.neutral,_this.negative,_this.score);
}

@override
String toString() {
  final _this = this as SpeakerSentimentModel;
  return 'SpeakerSentimentModel(speakerId: ${_this.speakerId}, label: ${_this.label}, talkMs: ${_this.talkMs}, positive: ${_this.positive}, neutral: ${_this.neutral}, negative: ${_this.negative}, score: ${_this.score})';
}


}

/// @nodoc
abstract mixin class $SpeakerSentimentModelCopyWith<$Res>  {
  factory $SpeakerSentimentModelCopyWith(SpeakerSentimentModel value, $Res Function(SpeakerSentimentModel) _then) = _$SpeakerSentimentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'speaker_id') String? speakerId,@JsonKey(name: 'label') String label,@JsonKey(name: 'talk_ms') int talkMs,@JsonKey(name: 'positive') double positive,@JsonKey(name: 'neutral') double neutral,@JsonKey(name: 'negative') double negative,@JsonKey(name: 'score') double score
});




}
/// @nodoc
class _$SpeakerSentimentModelCopyWithImpl<$Res>
    implements $SpeakerSentimentModelCopyWith<$Res> {
  _$SpeakerSentimentModelCopyWithImpl(this._self, this._then);

  final SpeakerSentimentModel _self;
  final $Res Function(SpeakerSentimentModel) _then;

/// Create a copy of SpeakerSentimentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speakerId = freezed,Object? label = null,Object? talkMs = null,Object? positive = null,Object? neutral = null,Object? negative = null,Object? score = null,}) {
  return _then(SpeakerSentimentModel(
speakerId: freezed == speakerId ? _self.speakerId : speakerId // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,talkMs: null == talkMs ? _self.talkMs : talkMs // ignore: cast_nullable_to_non_nullable
as int,positive: null == positive ? _self.positive : positive // ignore: cast_nullable_to_non_nullable
as double,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as double,negative: null == negative ? _self.negative : negative // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakerSentimentModel].
extension SpeakerSentimentModelPatterns on SpeakerSentimentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakerSentimentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakerSentimentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakerSentimentModel value)  $default,){
final _that = this;
switch (_that) {
case _SpeakerSentimentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakerSentimentModel value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakerSentimentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'speaker_id')  String? speakerId, @JsonKey(name: 'label')  String label, @JsonKey(name: 'talk_ms')  int talkMs, @JsonKey(name: 'positive')  double positive, @JsonKey(name: 'neutral')  double neutral, @JsonKey(name: 'negative')  double negative, @JsonKey(name: 'score')  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakerSentimentModel() when $default != null:
return $default(_that.speakerId,_that.label,_that.talkMs,_that.positive,_that.neutral,_that.negative,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'speaker_id')  String? speakerId, @JsonKey(name: 'label')  String label, @JsonKey(name: 'talk_ms')  int talkMs, @JsonKey(name: 'positive')  double positive, @JsonKey(name: 'neutral')  double neutral, @JsonKey(name: 'negative')  double negative, @JsonKey(name: 'score')  double score)  $default,) {final _that = this;
switch (_that) {
case _SpeakerSentimentModel():
return $default(_that.speakerId,_that.label,_that.talkMs,_that.positive,_that.neutral,_that.negative,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'speaker_id')  String? speakerId, @JsonKey(name: 'label')  String label, @JsonKey(name: 'talk_ms')  int talkMs, @JsonKey(name: 'positive')  double positive, @JsonKey(name: 'neutral')  double neutral, @JsonKey(name: 'negative')  double negative, @JsonKey(name: 'score')  double score)?  $default,) {final _that = this;
switch (_that) {
case _SpeakerSentimentModel() when $default != null:
return $default(_that.speakerId,_that.label,_that.talkMs,_that.positive,_that.neutral,_that.negative,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpeakerSentimentModel extends SpeakerSentimentModel {
  const _SpeakerSentimentModel({@JsonKey(name: 'speaker_id') this.speakerId, @JsonKey(name: 'label') this.label = '', @JsonKey(name: 'talk_ms') this.talkMs = 0, @JsonKey(name: 'positive') this.positive = 0, @JsonKey(name: 'neutral') this.neutral = 0, @JsonKey(name: 'negative') this.negative = 0, @JsonKey(name: 'score') this.score = 0}): super._();
  factory _SpeakerSentimentModel.fromJson(Map<String, dynamic> json) => _$SpeakerSentimentModelFromJson(json);

@override@JsonKey(name: 'speaker_id') final  String? speakerId;
@override@JsonKey(name: 'label') final  String label;
@override@JsonKey(name: 'talk_ms') final  int talkMs;
@override@JsonKey(name: 'positive') final  double positive;
@override@JsonKey(name: 'neutral') final  double neutral;
@override@JsonKey(name: 'negative') final  double negative;
@override@JsonKey(name: 'score') final  double score;

/// Create a copy of SpeakerSentimentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerSentimentModelCopyWith<_SpeakerSentimentModel> get copyWith => __$SpeakerSentimentModelCopyWithImpl<_SpeakerSentimentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeakerSentimentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakerSentimentModel&&(identical(other.speakerId, speakerId) || other.speakerId == speakerId)&&(identical(other.label, label) || other.label == label)&&(identical(other.talkMs, talkMs) || other.talkMs == talkMs)&&(identical(other.positive, positive) || other.positive == positive)&&(identical(other.neutral, neutral) || other.neutral == neutral)&&(identical(other.negative, negative) || other.negative == negative)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,speakerId,label,talkMs,positive,neutral,negative,score);
}

@override
String toString() {
    return 'SpeakerSentimentModel(speakerId: $speakerId, label: $label, talkMs: $talkMs, positive: $positive, neutral: $neutral, negative: $negative, score: $score)';
}


}

/// @nodoc
abstract mixin class _$SpeakerSentimentModelCopyWith<$Res> implements $SpeakerSentimentModelCopyWith<$Res> {
  factory _$SpeakerSentimentModelCopyWith(_SpeakerSentimentModel value, $Res Function(_SpeakerSentimentModel) _then) = __$SpeakerSentimentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'speaker_id') String? speakerId,@JsonKey(name: 'label') String label,@JsonKey(name: 'talk_ms') int talkMs,@JsonKey(name: 'positive') double positive,@JsonKey(name: 'neutral') double neutral,@JsonKey(name: 'negative') double negative,@JsonKey(name: 'score') double score
});




}
/// @nodoc
class __$SpeakerSentimentModelCopyWithImpl<$Res>
    implements _$SpeakerSentimentModelCopyWith<$Res> {
  __$SpeakerSentimentModelCopyWithImpl(this._self, this._then);

  final _SpeakerSentimentModel _self;
  final $Res Function(_SpeakerSentimentModel) _then;

/// Create a copy of SpeakerSentimentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speakerId = freezed,Object? label = null,Object? talkMs = null,Object? positive = null,Object? neutral = null,Object? negative = null,Object? score = null,}) {
  return _then(_SpeakerSentimentModel(
speakerId: freezed == speakerId ? _self.speakerId : speakerId // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,talkMs: null == talkMs ? _self.talkMs : talkMs // ignore: cast_nullable_to_non_nullable
as int,positive: null == positive ? _self.positive : positive // ignore: cast_nullable_to_non_nullable
as double,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as double,negative: null == negative ? _self.negative : negative // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SegmentSentimentModel {

@JsonKey(name: 'segment_id') String get segmentId;@JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown) SentimentLabelModel get label;
/// Create a copy of SegmentSentimentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentSentimentModelCopyWith<SegmentSentimentModel> get copyWith => _$SegmentSentimentModelCopyWithImpl<SegmentSentimentModel>(this as SegmentSentimentModel, _$identity);

  /// Serializes this SegmentSentimentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SegmentSentimentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentSentimentModel&&(identical(other.segmentId, _this.segmentId) || other.segmentId == _this.segmentId)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SegmentSentimentModel;
  return Object.hash(runtimeType,_this.segmentId,_this.label);
}

@override
String toString() {
  final _this = this as SegmentSentimentModel;
  return 'SegmentSentimentModel(segmentId: ${_this.segmentId}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $SegmentSentimentModelCopyWith<$Res>  {
  factory $SegmentSentimentModelCopyWith(SegmentSentimentModel value, $Res Function(SegmentSentimentModel) _then) = _$SegmentSentimentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'segment_id') String segmentId,@JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown) SentimentLabelModel label
});




}
/// @nodoc
class _$SegmentSentimentModelCopyWithImpl<$Res>
    implements $SegmentSentimentModelCopyWith<$Res> {
  _$SegmentSentimentModelCopyWithImpl(this._self, this._then);

  final SegmentSentimentModel _self;
  final $Res Function(SegmentSentimentModel) _then;

/// Create a copy of SegmentSentimentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segmentId = null,Object? label = null,}) {
  return _then(SegmentSentimentModel(
segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as SentimentLabelModel,
  ));
}

}


/// Adds pattern-matching-related methods to [SegmentSentimentModel].
extension SegmentSentimentModelPatterns on SegmentSentimentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentSentimentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentSentimentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentSentimentModel value)  $default,){
final _that = this;
switch (_that) {
case _SegmentSentimentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentSentimentModel value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentSentimentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'segment_id')  String segmentId, @JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown)  SentimentLabelModel label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentSentimentModel() when $default != null:
return $default(_that.segmentId,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'segment_id')  String segmentId, @JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown)  SentimentLabelModel label)  $default,) {final _that = this;
switch (_that) {
case _SegmentSentimentModel():
return $default(_that.segmentId,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'segment_id')  String segmentId, @JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown)  SentimentLabelModel label)?  $default,) {final _that = this;
switch (_that) {
case _SegmentSentimentModel() when $default != null:
return $default(_that.segmentId,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SegmentSentimentModel implements SegmentSentimentModel {
  const _SegmentSentimentModel({@JsonKey(name: 'segment_id') this.segmentId = '', @JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown) this.label = SentimentLabelModel.unknown});
  factory _SegmentSentimentModel.fromJson(Map<String, dynamic> json) => _$SegmentSentimentModelFromJson(json);

@override@JsonKey(name: 'segment_id') final  String segmentId;
@override@JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown) final  SentimentLabelModel label;

/// Create a copy of SegmentSentimentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentSentimentModelCopyWith<_SegmentSentimentModel> get copyWith => __$SegmentSentimentModelCopyWithImpl<_SegmentSentimentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SegmentSentimentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentSentimentModel&&(identical(other.segmentId, segmentId) || other.segmentId == segmentId)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,segmentId,label);
}

@override
String toString() {
    return 'SegmentSentimentModel(segmentId: $segmentId, label: $label)';
}


}

/// @nodoc
abstract mixin class _$SegmentSentimentModelCopyWith<$Res> implements $SegmentSentimentModelCopyWith<$Res> {
  factory _$SegmentSentimentModelCopyWith(_SegmentSentimentModel value, $Res Function(_SegmentSentimentModel) _then) = __$SegmentSentimentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'segment_id') String segmentId,@JsonKey(name: 'label', unknownEnumValue: SentimentLabelModel.unknown) SentimentLabelModel label
});




}
/// @nodoc
class __$SegmentSentimentModelCopyWithImpl<$Res>
    implements _$SegmentSentimentModelCopyWith<$Res> {
  __$SegmentSentimentModelCopyWithImpl(this._self, this._then);

  final _SegmentSentimentModel _self;
  final $Res Function(_SegmentSentimentModel) _then;

/// Create a copy of SegmentSentimentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segmentId = null,Object? label = null,}) {
  return _then(_SegmentSentimentModel(
segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as SentimentLabelModel,
  ));
}


}


/// @nodoc
mixin _$SentimentModel {

@JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown) SentimentStatusModel get status;@JsonKey(name: 'note') String get note;@JsonKey(name: 'error') String? get error;@JsonKey(name: 'attempt') int get attempt;@JsonKey(name: 'model') String get model;@JsonKey(name: 'outdated') bool get outdated;@JsonKey(name: 'unlabeled') int get unlabeled;@JsonKey(name: 'overall') SentimentShareModel? get overall;@JsonKey(name: 'speakers') List<SpeakerSentimentModel> get speakers;@JsonKey(name: 'segments') List<SegmentSentimentModel> get segments;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of SentimentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentModelCopyWith<SentimentModel> get copyWith => _$SentimentModelCopyWithImpl<SentimentModel>(this as SentimentModel, _$identity);

  /// Serializes this SentimentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SentimentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentModel&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.attempt, _this.attempt) || other.attempt == _this.attempt)&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.outdated, _this.outdated) || other.outdated == _this.outdated)&&(identical(other.unlabeled, _this.unlabeled) || other.unlabeled == _this.unlabeled)&&(identical(other.overall, _this.overall) || other.overall == _this.overall)&&const DeepCollectionEquality().equals(other.speakers, _this.speakers)&&const DeepCollectionEquality().equals(other.segments, _this.segments)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SentimentModel;
  return Object.hash(runtimeType,_this.status,_this.note,_this.error,_this.attempt,_this.model,_this.outdated,_this.unlabeled,_this.overall,const DeepCollectionEquality().hash(_this.speakers),const DeepCollectionEquality().hash(_this.segments),_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as SentimentModel;
  return 'SentimentModel(status: ${_this.status}, note: ${_this.note}, error: ${_this.error}, attempt: ${_this.attempt}, model: ${_this.model}, outdated: ${_this.outdated}, unlabeled: ${_this.unlabeled}, overall: ${_this.overall}, speakers: ${_this.speakers}, segments: ${_this.segments}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $SentimentModelCopyWith<$Res>  {
  factory $SentimentModelCopyWith(SentimentModel value, $Res Function(SentimentModel) _then) = _$SentimentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown) SentimentStatusModel status,@JsonKey(name: 'note') String note,@JsonKey(name: 'error') String? error,@JsonKey(name: 'attempt') int attempt,@JsonKey(name: 'model') String model,@JsonKey(name: 'outdated') bool outdated,@JsonKey(name: 'unlabeled') int unlabeled,@JsonKey(name: 'overall') SentimentShareModel? overall,@JsonKey(name: 'speakers') List<SpeakerSentimentModel> speakers,@JsonKey(name: 'segments') List<SegmentSentimentModel> segments,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


$SentimentShareModelCopyWith<$Res>? get overall;

}
/// @nodoc
class _$SentimentModelCopyWithImpl<$Res>
    implements $SentimentModelCopyWith<$Res> {
  _$SentimentModelCopyWithImpl(this._self, this._then);

  final SentimentModel _self;
  final $Res Function(SentimentModel) _then;

/// Create a copy of SentimentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? note = null,Object? error = freezed,Object? attempt = null,Object? model = null,Object? outdated = null,Object? unlabeled = null,Object? overall = freezed,Object? speakers = null,Object? segments = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(SentimentModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SentimentStatusModel,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,outdated: null == outdated ? _self.outdated : outdated // ignore: cast_nullable_to_non_nullable
as bool,unlabeled: null == unlabeled ? _self.unlabeled : unlabeled // ignore: cast_nullable_to_non_nullable
as int,overall: freezed == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as SentimentShareModel?,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<SpeakerSentimentModel>,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<SegmentSentimentModel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SentimentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentShareModelCopyWith<$Res>? get overall {
    if (_self.overall == null) {
    return null;
  }

  return $SentimentShareModelCopyWith<$Res>(_self.overall!, (value) {
    return _then(_self.copyWith(overall: value));
  });
}
}


/// Adds pattern-matching-related methods to [SentimentModel].
extension SentimentModelPatterns on SentimentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentimentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentimentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentimentModel value)  $default,){
final _that = this;
switch (_that) {
case _SentimentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentimentModel value)?  $default,){
final _that = this;
switch (_that) {
case _SentimentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown)  SentimentStatusModel status, @JsonKey(name: 'note')  String note, @JsonKey(name: 'error')  String? error, @JsonKey(name: 'attempt')  int attempt, @JsonKey(name: 'model')  String model, @JsonKey(name: 'outdated')  bool outdated, @JsonKey(name: 'unlabeled')  int unlabeled, @JsonKey(name: 'overall')  SentimentShareModel? overall, @JsonKey(name: 'speakers')  List<SpeakerSentimentModel> speakers, @JsonKey(name: 'segments')  List<SegmentSentimentModel> segments, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentimentModel() when $default != null:
return $default(_that.status,_that.note,_that.error,_that.attempt,_that.model,_that.outdated,_that.unlabeled,_that.overall,_that.speakers,_that.segments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown)  SentimentStatusModel status, @JsonKey(name: 'note')  String note, @JsonKey(name: 'error')  String? error, @JsonKey(name: 'attempt')  int attempt, @JsonKey(name: 'model')  String model, @JsonKey(name: 'outdated')  bool outdated, @JsonKey(name: 'unlabeled')  int unlabeled, @JsonKey(name: 'overall')  SentimentShareModel? overall, @JsonKey(name: 'speakers')  List<SpeakerSentimentModel> speakers, @JsonKey(name: 'segments')  List<SegmentSentimentModel> segments, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SentimentModel():
return $default(_that.status,_that.note,_that.error,_that.attempt,_that.model,_that.outdated,_that.unlabeled,_that.overall,_that.speakers,_that.segments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown)  SentimentStatusModel status, @JsonKey(name: 'note')  String note, @JsonKey(name: 'error')  String? error, @JsonKey(name: 'attempt')  int attempt, @JsonKey(name: 'model')  String model, @JsonKey(name: 'outdated')  bool outdated, @JsonKey(name: 'unlabeled')  int unlabeled, @JsonKey(name: 'overall')  SentimentShareModel? overall, @JsonKey(name: 'speakers')  List<SpeakerSentimentModel> speakers, @JsonKey(name: 'segments')  List<SegmentSentimentModel> segments, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SentimentModel() when $default != null:
return $default(_that.status,_that.note,_that.error,_that.attempt,_that.model,_that.outdated,_that.unlabeled,_that.overall,_that.speakers,_that.segments,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SentimentModel extends SentimentModel {
  const _SentimentModel({@JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown) this.status = SentimentStatusModel.unknown, @JsonKey(name: 'note') this.note = '', @JsonKey(name: 'error') this.error, @JsonKey(name: 'attempt') this.attempt = 0, @JsonKey(name: 'model') this.model = '', @JsonKey(name: 'outdated') this.outdated = false, @JsonKey(name: 'unlabeled') this.unlabeled = 0, @JsonKey(name: 'overall') this.overall, @JsonKey(name: 'speakers')  List<SpeakerSentimentModel> speakers = const <SpeakerSentimentModel>[], @JsonKey(name: 'segments')  List<SegmentSentimentModel> segments = const <SegmentSentimentModel>[], @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): _speakers = speakers,_segments = segments,super._();
  factory _SentimentModel.fromJson(Map<String, dynamic> json) => _$SentimentModelFromJson(json);

@override@JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown) final  SentimentStatusModel status;
@override@JsonKey(name: 'note') final  String note;
@override@JsonKey(name: 'error') final  String? error;
@override@JsonKey(name: 'attempt') final  int attempt;
@override@JsonKey(name: 'model') final  String model;
@override@JsonKey(name: 'outdated') final  bool outdated;
@override@JsonKey(name: 'unlabeled') final  int unlabeled;
@override@JsonKey(name: 'overall') final  SentimentShareModel? overall;
 final  List<SpeakerSentimentModel> _speakers;
@override@JsonKey(name: 'speakers') List<SpeakerSentimentModel> get speakers {
  if (_speakers is EqualUnmodifiableListView) return _speakers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_speakers);
}

 final  List<SegmentSentimentModel> _segments;
@override@JsonKey(name: 'segments') List<SegmentSentimentModel> get segments {
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_segments);
}

@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of SentimentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentModelCopyWith<_SentimentModel> get copyWith => __$SentimentModelCopyWithImpl<_SentimentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SentimentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentModel&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.error, error) || other.error == error)&&(identical(other.attempt, attempt) || other.attempt == attempt)&&(identical(other.model, model) || other.model == model)&&(identical(other.outdated, outdated) || other.outdated == outdated)&&(identical(other.unlabeled, unlabeled) || other.unlabeled == unlabeled)&&(identical(other.overall, overall) || other.overall == overall)&&const DeepCollectionEquality().equals(other.speakers, _speakers)&&const DeepCollectionEquality().equals(other.segments, _segments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,note,error,attempt,model,outdated,unlabeled,overall,const DeepCollectionEquality().hash(_speakers),const DeepCollectionEquality().hash(_segments),createdAt,updatedAt);
}

@override
String toString() {
    return 'SentimentModel(status: $status, note: $note, error: $error, attempt: $attempt, model: $model, outdated: $outdated, unlabeled: $unlabeled, overall: $overall, speakers: $speakers, segments: $segments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SentimentModelCopyWith<$Res> implements $SentimentModelCopyWith<$Res> {
  factory _$SentimentModelCopyWith(_SentimentModel value, $Res Function(_SentimentModel) _then) = __$SentimentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'status', unknownEnumValue: SentimentStatusModel.unknown) SentimentStatusModel status,@JsonKey(name: 'note') String note,@JsonKey(name: 'error') String? error,@JsonKey(name: 'attempt') int attempt,@JsonKey(name: 'model') String model,@JsonKey(name: 'outdated') bool outdated,@JsonKey(name: 'unlabeled') int unlabeled,@JsonKey(name: 'overall') SentimentShareModel? overall,@JsonKey(name: 'speakers') List<SpeakerSentimentModel> speakers,@JsonKey(name: 'segments') List<SegmentSentimentModel> segments,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


@override $SentimentShareModelCopyWith<$Res>? get overall;

}
/// @nodoc
class __$SentimentModelCopyWithImpl<$Res>
    implements _$SentimentModelCopyWith<$Res> {
  __$SentimentModelCopyWithImpl(this._self, this._then);

  final _SentimentModel _self;
  final $Res Function(_SentimentModel) _then;

/// Create a copy of SentimentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? note = null,Object? error = freezed,Object? attempt = null,Object? model = null,Object? outdated = null,Object? unlabeled = null,Object? overall = freezed,Object? speakers = null,Object? segments = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SentimentModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SentimentStatusModel,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,outdated: null == outdated ? _self.outdated : outdated // ignore: cast_nullable_to_non_nullable
as bool,unlabeled: null == unlabeled ? _self.unlabeled : unlabeled // ignore: cast_nullable_to_non_nullable
as int,overall: freezed == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as SentimentShareModel?,speakers: null == speakers ? _self._speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<SpeakerSentimentModel>,segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<SegmentSentimentModel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SentimentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentShareModelCopyWith<$Res>? get overall {
    if (_self.overall == null) {
    return null;
  }

  return $SentimentShareModelCopyWith<$Res>(_self.overall!, (value) {
    return _then(_self.copyWith(overall: value));
  });
}
}

// dart format on
