// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcript_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpeakerModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'label') String get label;@JsonKey(name: 'ordinal') int get ordinal;
/// Create a copy of SpeakerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<SpeakerModel> get copyWith => _$SpeakerModelCopyWithImpl<SpeakerModel>(this as SpeakerModel, _$identity);

  /// Serializes this SpeakerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpeakerModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakerModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.ordinal, _this.ordinal) || other.ordinal == _this.ordinal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpeakerModel;
  return Object.hash(runtimeType,_this.id,_this.label,_this.ordinal);
}

@override
String toString() {
  final _this = this as SpeakerModel;
  return 'SpeakerModel(id: ${_this.id}, label: ${_this.label}, ordinal: ${_this.ordinal})';
}


}

/// @nodoc
abstract mixin class $SpeakerModelCopyWith<$Res>  {
  factory $SpeakerModelCopyWith(SpeakerModel value, $Res Function(SpeakerModel) _then) = _$SpeakerModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'label') String label,@JsonKey(name: 'ordinal') int ordinal
});




}
/// @nodoc
class _$SpeakerModelCopyWithImpl<$Res>
    implements $SpeakerModelCopyWith<$Res> {
  _$SpeakerModelCopyWithImpl(this._self, this._then);

  final SpeakerModel _self;
  final $Res Function(SpeakerModel) _then;

/// Create a copy of SpeakerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? ordinal = null,}) {
  return _then(SpeakerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,ordinal: null == ordinal ? _self.ordinal : ordinal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakerModel].
extension SpeakerModelPatterns on SpeakerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakerModel value)  $default,){
final _that = this;
switch (_that) {
case _SpeakerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakerModel value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'label')  String label, @JsonKey(name: 'ordinal')  int ordinal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakerModel() when $default != null:
return $default(_that.id,_that.label,_that.ordinal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'label')  String label, @JsonKey(name: 'ordinal')  int ordinal)  $default,) {final _that = this;
switch (_that) {
case _SpeakerModel():
return $default(_that.id,_that.label,_that.ordinal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'label')  String label, @JsonKey(name: 'ordinal')  int ordinal)?  $default,) {final _that = this;
switch (_that) {
case _SpeakerModel() when $default != null:
return $default(_that.id,_that.label,_that.ordinal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpeakerModel extends SpeakerModel {
  const _SpeakerModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'label') this.label = '', @JsonKey(name: 'ordinal') this.ordinal = 0}): super._();
  factory _SpeakerModel.fromJson(Map<String, dynamic> json) => _$SpeakerModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'label') final  String label;
@override@JsonKey(name: 'ordinal') final  int ordinal;

/// Create a copy of SpeakerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerModelCopyWith<_SpeakerModel> get copyWith => __$SpeakerModelCopyWithImpl<_SpeakerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeakerModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.ordinal, ordinal) || other.ordinal == ordinal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label,ordinal);
}

@override
String toString() {
    return 'SpeakerModel(id: $id, label: $label, ordinal: $ordinal)';
}


}

/// @nodoc
abstract mixin class _$SpeakerModelCopyWith<$Res> implements $SpeakerModelCopyWith<$Res> {
  factory _$SpeakerModelCopyWith(_SpeakerModel value, $Res Function(_SpeakerModel) _then) = __$SpeakerModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'label') String label,@JsonKey(name: 'ordinal') int ordinal
});




}
/// @nodoc
class __$SpeakerModelCopyWithImpl<$Res>
    implements _$SpeakerModelCopyWith<$Res> {
  __$SpeakerModelCopyWithImpl(this._self, this._then);

  final _SpeakerModel _self;
  final $Res Function(_SpeakerModel) _then;

/// Create a copy of SpeakerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? ordinal = null,}) {
  return _then(_SpeakerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,ordinal: null == ordinal ? _self.ordinal : ordinal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SegmentModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'start_ms') int get startMs;@JsonKey(name: 'end_ms') int get endMs;@JsonKey(name: 'text') String get text;@JsonKey(name: 'speaker_id') String? get speakerId;@JsonKey(name: 'edited') bool get edited;
/// Create a copy of SegmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentModelCopyWith<SegmentModel> get copyWith => _$SegmentModelCopyWithImpl<SegmentModel>(this as SegmentModel, _$identity);

  /// Serializes this SegmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SegmentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.startMs, _this.startMs) || other.startMs == _this.startMs)&&(identical(other.endMs, _this.endMs) || other.endMs == _this.endMs)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.speakerId, _this.speakerId) || other.speakerId == _this.speakerId)&&(identical(other.edited, _this.edited) || other.edited == _this.edited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SegmentModel;
  return Object.hash(runtimeType,_this.id,_this.startMs,_this.endMs,_this.text,_this.speakerId,_this.edited);
}

@override
String toString() {
  final _this = this as SegmentModel;
  return 'SegmentModel(id: ${_this.id}, startMs: ${_this.startMs}, endMs: ${_this.endMs}, text: ${_this.text}, speakerId: ${_this.speakerId}, edited: ${_this.edited})';
}


}

/// @nodoc
abstract mixin class $SegmentModelCopyWith<$Res>  {
  factory $SegmentModelCopyWith(SegmentModel value, $Res Function(SegmentModel) _then) = _$SegmentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'start_ms') int startMs,@JsonKey(name: 'end_ms') int endMs,@JsonKey(name: 'text') String text,@JsonKey(name: 'speaker_id') String? speakerId,@JsonKey(name: 'edited') bool edited
});




}
/// @nodoc
class _$SegmentModelCopyWithImpl<$Res>
    implements $SegmentModelCopyWith<$Res> {
  _$SegmentModelCopyWithImpl(this._self, this._then);

  final SegmentModel _self;
  final $Res Function(SegmentModel) _then;

/// Create a copy of SegmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startMs = null,Object? endMs = null,Object? text = null,Object? speakerId = freezed,Object? edited = null,}) {
  return _then(SegmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startMs: null == startMs ? _self.startMs : startMs // ignore: cast_nullable_to_non_nullable
as int,endMs: null == endMs ? _self.endMs : endMs // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,speakerId: freezed == speakerId ? _self.speakerId : speakerId // ignore: cast_nullable_to_non_nullable
as String?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SegmentModel].
extension SegmentModelPatterns on SegmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentModel value)  $default,){
final _that = this;
switch (_that) {
case _SegmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'start_ms')  int startMs, @JsonKey(name: 'end_ms')  int endMs, @JsonKey(name: 'text')  String text, @JsonKey(name: 'speaker_id')  String? speakerId, @JsonKey(name: 'edited')  bool edited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentModel() when $default != null:
return $default(_that.id,_that.startMs,_that.endMs,_that.text,_that.speakerId,_that.edited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'start_ms')  int startMs, @JsonKey(name: 'end_ms')  int endMs, @JsonKey(name: 'text')  String text, @JsonKey(name: 'speaker_id')  String? speakerId, @JsonKey(name: 'edited')  bool edited)  $default,) {final _that = this;
switch (_that) {
case _SegmentModel():
return $default(_that.id,_that.startMs,_that.endMs,_that.text,_that.speakerId,_that.edited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'start_ms')  int startMs, @JsonKey(name: 'end_ms')  int endMs, @JsonKey(name: 'text')  String text, @JsonKey(name: 'speaker_id')  String? speakerId, @JsonKey(name: 'edited')  bool edited)?  $default,) {final _that = this;
switch (_that) {
case _SegmentModel() when $default != null:
return $default(_that.id,_that.startMs,_that.endMs,_that.text,_that.speakerId,_that.edited);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SegmentModel extends SegmentModel {
  const _SegmentModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'start_ms') this.startMs = 0, @JsonKey(name: 'end_ms') this.endMs = 0, @JsonKey(name: 'text') this.text = '', @JsonKey(name: 'speaker_id') this.speakerId, @JsonKey(name: 'edited') this.edited = false}): super._();
  factory _SegmentModel.fromJson(Map<String, dynamic> json) => _$SegmentModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'start_ms') final  int startMs;
@override@JsonKey(name: 'end_ms') final  int endMs;
@override@JsonKey(name: 'text') final  String text;
@override@JsonKey(name: 'speaker_id') final  String? speakerId;
@override@JsonKey(name: 'edited') final  bool edited;

/// Create a copy of SegmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentModelCopyWith<_SegmentModel> get copyWith => __$SegmentModelCopyWithImpl<_SegmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SegmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.startMs, startMs) || other.startMs == startMs)&&(identical(other.endMs, endMs) || other.endMs == endMs)&&(identical(other.text, text) || other.text == text)&&(identical(other.speakerId, speakerId) || other.speakerId == speakerId)&&(identical(other.edited, edited) || other.edited == edited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,startMs,endMs,text,speakerId,edited);
}

@override
String toString() {
    return 'SegmentModel(id: $id, startMs: $startMs, endMs: $endMs, text: $text, speakerId: $speakerId, edited: $edited)';
}


}

/// @nodoc
abstract mixin class _$SegmentModelCopyWith<$Res> implements $SegmentModelCopyWith<$Res> {
  factory _$SegmentModelCopyWith(_SegmentModel value, $Res Function(_SegmentModel) _then) = __$SegmentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'start_ms') int startMs,@JsonKey(name: 'end_ms') int endMs,@JsonKey(name: 'text') String text,@JsonKey(name: 'speaker_id') String? speakerId,@JsonKey(name: 'edited') bool edited
});




}
/// @nodoc
class __$SegmentModelCopyWithImpl<$Res>
    implements _$SegmentModelCopyWith<$Res> {
  __$SegmentModelCopyWithImpl(this._self, this._then);

  final _SegmentModel _self;
  final $Res Function(_SegmentModel) _then;

/// Create a copy of SegmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startMs = null,Object? endMs = null,Object? text = null,Object? speakerId = freezed,Object? edited = null,}) {
  return _then(_SegmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startMs: null == startMs ? _self.startMs : startMs // ignore: cast_nullable_to_non_nullable
as int,endMs: null == endMs ? _self.endMs : endMs // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,speakerId: freezed == speakerId ? _self.speakerId : speakerId // ignore: cast_nullable_to_non_nullable
as String?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TranscriptModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'title') String get title;@JsonKey(name: 'duration_ms') int? get durationMs;@JsonKey(name: 'speakers') List<SpeakerModel> get speakers;@JsonKey(name: 'segments') List<SegmentModel> get segments;@JsonKey(name: 'revision') int get revision;
/// Create a copy of TranscriptModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptModelCopyWith<TranscriptModel> get copyWith => _$TranscriptModelCopyWithImpl<TranscriptModel>(this as TranscriptModel, _$identity);

  /// Serializes this TranscriptModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TranscriptModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&const DeepCollectionEquality().equals(other.speakers, _this.speakers)&&const DeepCollectionEquality().equals(other.segments, _this.segments)&&(identical(other.revision, _this.revision) || other.revision == _this.revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TranscriptModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.durationMs,const DeepCollectionEquality().hash(_this.speakers),const DeepCollectionEquality().hash(_this.segments),_this.revision);
}

@override
String toString() {
  final _this = this as TranscriptModel;
  return 'TranscriptModel(id: ${_this.id}, title: ${_this.title}, durationMs: ${_this.durationMs}, speakers: ${_this.speakers}, segments: ${_this.segments}, revision: ${_this.revision})';
}


}

/// @nodoc
abstract mixin class $TranscriptModelCopyWith<$Res>  {
  factory $TranscriptModelCopyWith(TranscriptModel value, $Res Function(TranscriptModel) _then) = _$TranscriptModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'title') String title,@JsonKey(name: 'duration_ms') int? durationMs,@JsonKey(name: 'speakers') List<SpeakerModel> speakers,@JsonKey(name: 'segments') List<SegmentModel> segments,@JsonKey(name: 'revision') int revision
});




}
/// @nodoc
class _$TranscriptModelCopyWithImpl<$Res>
    implements $TranscriptModelCopyWith<$Res> {
  _$TranscriptModelCopyWithImpl(this._self, this._then);

  final TranscriptModel _self;
  final $Res Function(TranscriptModel) _then;

/// Create a copy of TranscriptModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? durationMs = freezed,Object? speakers = null,Object? segments = null,Object? revision = null,}) {
  return _then(TranscriptModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<SpeakerModel>,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<SegmentModel>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TranscriptModel].
extension TranscriptModelPatterns on TranscriptModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptModel value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptModel value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'duration_ms')  int? durationMs, @JsonKey(name: 'speakers')  List<SpeakerModel> speakers, @JsonKey(name: 'segments')  List<SegmentModel> segments, @JsonKey(name: 'revision')  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptModel() when $default != null:
return $default(_that.id,_that.title,_that.durationMs,_that.speakers,_that.segments,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'duration_ms')  int? durationMs, @JsonKey(name: 'speakers')  List<SpeakerModel> speakers, @JsonKey(name: 'segments')  List<SegmentModel> segments, @JsonKey(name: 'revision')  int revision)  $default,) {final _that = this;
switch (_that) {
case _TranscriptModel():
return $default(_that.id,_that.title,_that.durationMs,_that.speakers,_that.segments,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'duration_ms')  int? durationMs, @JsonKey(name: 'speakers')  List<SpeakerModel> speakers, @JsonKey(name: 'segments')  List<SegmentModel> segments, @JsonKey(name: 'revision')  int revision)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptModel() when $default != null:
return $default(_that.id,_that.title,_that.durationMs,_that.speakers,_that.segments,_that.revision);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranscriptModel extends TranscriptModel {
  const _TranscriptModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'title') this.title = '', @JsonKey(name: 'duration_ms') this.durationMs, @JsonKey(name: 'speakers')  List<SpeakerModel> speakers = const <SpeakerModel>[], @JsonKey(name: 'segments')  List<SegmentModel> segments = const <SegmentModel>[], @JsonKey(name: 'revision') this.revision = 0}): _speakers = speakers,_segments = segments,super._();
  factory _TranscriptModel.fromJson(Map<String, dynamic> json) => _$TranscriptModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'duration_ms') final  int? durationMs;
 final  List<SpeakerModel> _speakers;
@override@JsonKey(name: 'speakers') List<SpeakerModel> get speakers {
  if (_speakers is EqualUnmodifiableListView) return _speakers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_speakers);
}

 final  List<SegmentModel> _segments;
@override@JsonKey(name: 'segments') List<SegmentModel> get segments {
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_segments);
}

@override@JsonKey(name: 'revision') final  int revision;

/// Create a copy of TranscriptModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptModelCopyWith<_TranscriptModel> get copyWith => __$TranscriptModelCopyWithImpl<_TranscriptModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranscriptModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&const DeepCollectionEquality().equals(other.speakers, _speakers)&&const DeepCollectionEquality().equals(other.segments, _segments)&&(identical(other.revision, revision) || other.revision == revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,durationMs,const DeepCollectionEquality().hash(_speakers),const DeepCollectionEquality().hash(_segments),revision);
}

@override
String toString() {
    return 'TranscriptModel(id: $id, title: $title, durationMs: $durationMs, speakers: $speakers, segments: $segments, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$TranscriptModelCopyWith<$Res> implements $TranscriptModelCopyWith<$Res> {
  factory _$TranscriptModelCopyWith(_TranscriptModel value, $Res Function(_TranscriptModel) _then) = __$TranscriptModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'title') String title,@JsonKey(name: 'duration_ms') int? durationMs,@JsonKey(name: 'speakers') List<SpeakerModel> speakers,@JsonKey(name: 'segments') List<SegmentModel> segments,@JsonKey(name: 'revision') int revision
});




}
/// @nodoc
class __$TranscriptModelCopyWithImpl<$Res>
    implements _$TranscriptModelCopyWith<$Res> {
  __$TranscriptModelCopyWithImpl(this._self, this._then);

  final _TranscriptModel _self;
  final $Res Function(_TranscriptModel) _then;

/// Create a copy of TranscriptModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? durationMs = freezed,Object? speakers = null,Object? segments = null,Object? revision = null,}) {
  return _then(_TranscriptModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,speakers: null == speakers ? _self._speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<SpeakerModel>,segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<SegmentModel>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SegmentEditModel {

@JsonKey(name: 'segment') SegmentModel get segment;@JsonKey(name: 'revision') int get revision;@JsonKey(name: 'new_speaker') SpeakerModel? get newSpeaker;
/// Create a copy of SegmentEditModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentEditModelCopyWith<SegmentEditModel> get copyWith => _$SegmentEditModelCopyWithImpl<SegmentEditModel>(this as SegmentEditModel, _$identity);

  /// Serializes this SegmentEditModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SegmentEditModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentEditModel&&(identical(other.segment, _this.segment) || other.segment == _this.segment)&&(identical(other.revision, _this.revision) || other.revision == _this.revision)&&(identical(other.newSpeaker, _this.newSpeaker) || other.newSpeaker == _this.newSpeaker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SegmentEditModel;
  return Object.hash(runtimeType,_this.segment,_this.revision,_this.newSpeaker);
}

@override
String toString() {
  final _this = this as SegmentEditModel;
  return 'SegmentEditModel(segment: ${_this.segment}, revision: ${_this.revision}, newSpeaker: ${_this.newSpeaker})';
}


}

/// @nodoc
abstract mixin class $SegmentEditModelCopyWith<$Res>  {
  factory $SegmentEditModelCopyWith(SegmentEditModel value, $Res Function(SegmentEditModel) _then) = _$SegmentEditModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'segment') SegmentModel segment,@JsonKey(name: 'revision') int revision,@JsonKey(name: 'new_speaker') SpeakerModel? newSpeaker
});


$SegmentModelCopyWith<$Res> get segment;$SpeakerModelCopyWith<$Res>? get newSpeaker;

}
/// @nodoc
class _$SegmentEditModelCopyWithImpl<$Res>
    implements $SegmentEditModelCopyWith<$Res> {
  _$SegmentEditModelCopyWithImpl(this._self, this._then);

  final SegmentEditModel _self;
  final $Res Function(SegmentEditModel) _then;

/// Create a copy of SegmentEditModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segment = null,Object? revision = null,Object? newSpeaker = freezed,}) {
  return _then(SegmentEditModel(
segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as SegmentModel,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,newSpeaker: freezed == newSpeaker ? _self.newSpeaker : newSpeaker // ignore: cast_nullable_to_non_nullable
as SpeakerModel?,
  ));
}
/// Create a copy of SegmentEditModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentModelCopyWith<$Res> get segment {
  
  return $SegmentModelCopyWith<$Res>(_self.segment, (value) {
    return _then(_self.copyWith(segment: value));
  });
}/// Create a copy of SegmentEditModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<$Res>? get newSpeaker {
    if (_self.newSpeaker == null) {
    return null;
  }

  return $SpeakerModelCopyWith<$Res>(_self.newSpeaker!, (value) {
    return _then(_self.copyWith(newSpeaker: value));
  });
}
}


/// Adds pattern-matching-related methods to [SegmentEditModel].
extension SegmentEditModelPatterns on SegmentEditModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentEditModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentEditModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentEditModel value)  $default,){
final _that = this;
switch (_that) {
case _SegmentEditModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentEditModel value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentEditModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'segment')  SegmentModel segment, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'new_speaker')  SpeakerModel? newSpeaker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentEditModel() when $default != null:
return $default(_that.segment,_that.revision,_that.newSpeaker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'segment')  SegmentModel segment, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'new_speaker')  SpeakerModel? newSpeaker)  $default,) {final _that = this;
switch (_that) {
case _SegmentEditModel():
return $default(_that.segment,_that.revision,_that.newSpeaker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'segment')  SegmentModel segment, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'new_speaker')  SpeakerModel? newSpeaker)?  $default,) {final _that = this;
switch (_that) {
case _SegmentEditModel() when $default != null:
return $default(_that.segment,_that.revision,_that.newSpeaker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SegmentEditModel extends SegmentEditModel {
  const _SegmentEditModel({@JsonKey(name: 'segment') required this.segment, @JsonKey(name: 'revision') this.revision = 0, @JsonKey(name: 'new_speaker') this.newSpeaker}): super._();
  factory _SegmentEditModel.fromJson(Map<String, dynamic> json) => _$SegmentEditModelFromJson(json);

@override@JsonKey(name: 'segment') final  SegmentModel segment;
@override@JsonKey(name: 'revision') final  int revision;
@override@JsonKey(name: 'new_speaker') final  SpeakerModel? newSpeaker;

/// Create a copy of SegmentEditModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentEditModelCopyWith<_SegmentEditModel> get copyWith => __$SegmentEditModelCopyWithImpl<_SegmentEditModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SegmentEditModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentEditModel&&(identical(other.segment, segment) || other.segment == segment)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.newSpeaker, newSpeaker) || other.newSpeaker == newSpeaker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,segment,revision,newSpeaker);
}

@override
String toString() {
    return 'SegmentEditModel(segment: $segment, revision: $revision, newSpeaker: $newSpeaker)';
}


}

/// @nodoc
abstract mixin class _$SegmentEditModelCopyWith<$Res> implements $SegmentEditModelCopyWith<$Res> {
  factory _$SegmentEditModelCopyWith(_SegmentEditModel value, $Res Function(_SegmentEditModel) _then) = __$SegmentEditModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'segment') SegmentModel segment,@JsonKey(name: 'revision') int revision,@JsonKey(name: 'new_speaker') SpeakerModel? newSpeaker
});


@override $SegmentModelCopyWith<$Res> get segment;@override $SpeakerModelCopyWith<$Res>? get newSpeaker;

}
/// @nodoc
class __$SegmentEditModelCopyWithImpl<$Res>
    implements _$SegmentEditModelCopyWith<$Res> {
  __$SegmentEditModelCopyWithImpl(this._self, this._then);

  final _SegmentEditModel _self;
  final $Res Function(_SegmentEditModel) _then;

/// Create a copy of SegmentEditModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segment = null,Object? revision = null,Object? newSpeaker = freezed,}) {
  return _then(_SegmentEditModel(
segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as SegmentModel,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,newSpeaker: freezed == newSpeaker ? _self.newSpeaker : newSpeaker // ignore: cast_nullable_to_non_nullable
as SpeakerModel?,
  ));
}

/// Create a copy of SegmentEditModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentModelCopyWith<$Res> get segment {
  
  return $SegmentModelCopyWith<$Res>(_self.segment, (value) {
    return _then(_self.copyWith(segment: value));
  });
}/// Create a copy of SegmentEditModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<$Res>? get newSpeaker {
    if (_self.newSpeaker == null) {
    return null;
  }

  return $SpeakerModelCopyWith<$Res>(_self.newSpeaker!, (value) {
    return _then(_self.copyWith(newSpeaker: value));
  });
}
}


/// @nodoc
mixin _$SpeakerEditModel {

@JsonKey(name: 'speaker') SpeakerModel get speaker;
/// Create a copy of SpeakerEditModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerEditModelCopyWith<SpeakerEditModel> get copyWith => _$SpeakerEditModelCopyWithImpl<SpeakerEditModel>(this as SpeakerEditModel, _$identity);

  /// Serializes this SpeakerEditModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpeakerEditModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakerEditModel&&(identical(other.speaker, _this.speaker) || other.speaker == _this.speaker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpeakerEditModel;
  return Object.hash(runtimeType,_this.speaker);
}

@override
String toString() {
  final _this = this as SpeakerEditModel;
  return 'SpeakerEditModel(speaker: ${_this.speaker})';
}


}

/// @nodoc
abstract mixin class $SpeakerEditModelCopyWith<$Res>  {
  factory $SpeakerEditModelCopyWith(SpeakerEditModel value, $Res Function(SpeakerEditModel) _then) = _$SpeakerEditModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'speaker') SpeakerModel speaker
});


$SpeakerModelCopyWith<$Res> get speaker;

}
/// @nodoc
class _$SpeakerEditModelCopyWithImpl<$Res>
    implements $SpeakerEditModelCopyWith<$Res> {
  _$SpeakerEditModelCopyWithImpl(this._self, this._then);

  final SpeakerEditModel _self;
  final $Res Function(SpeakerEditModel) _then;

/// Create a copy of SpeakerEditModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speaker = null,}) {
  return _then(SpeakerEditModel(
speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as SpeakerModel,
  ));
}
/// Create a copy of SpeakerEditModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<$Res> get speaker {
  
  return $SpeakerModelCopyWith<$Res>(_self.speaker, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}


/// Adds pattern-matching-related methods to [SpeakerEditModel].
extension SpeakerEditModelPatterns on SpeakerEditModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakerEditModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakerEditModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakerEditModel value)  $default,){
final _that = this;
switch (_that) {
case _SpeakerEditModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakerEditModel value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakerEditModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'speaker')  SpeakerModel speaker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakerEditModel() when $default != null:
return $default(_that.speaker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'speaker')  SpeakerModel speaker)  $default,) {final _that = this;
switch (_that) {
case _SpeakerEditModel():
return $default(_that.speaker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'speaker')  SpeakerModel speaker)?  $default,) {final _that = this;
switch (_that) {
case _SpeakerEditModel() when $default != null:
return $default(_that.speaker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpeakerEditModel implements SpeakerEditModel {
  const _SpeakerEditModel({@JsonKey(name: 'speaker') required this.speaker});
  factory _SpeakerEditModel.fromJson(Map<String, dynamic> json) => _$SpeakerEditModelFromJson(json);

@override@JsonKey(name: 'speaker') final  SpeakerModel speaker;

/// Create a copy of SpeakerEditModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerEditModelCopyWith<_SpeakerEditModel> get copyWith => __$SpeakerEditModelCopyWithImpl<_SpeakerEditModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeakerEditModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakerEditModel&&(identical(other.speaker, speaker) || other.speaker == speaker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,speaker);
}

@override
String toString() {
    return 'SpeakerEditModel(speaker: $speaker)';
}


}

/// @nodoc
abstract mixin class _$SpeakerEditModelCopyWith<$Res> implements $SpeakerEditModelCopyWith<$Res> {
  factory _$SpeakerEditModelCopyWith(_SpeakerEditModel value, $Res Function(_SpeakerEditModel) _then) = __$SpeakerEditModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'speaker') SpeakerModel speaker
});


@override $SpeakerModelCopyWith<$Res> get speaker;

}
/// @nodoc
class __$SpeakerEditModelCopyWithImpl<$Res>
    implements _$SpeakerEditModelCopyWith<$Res> {
  __$SpeakerEditModelCopyWithImpl(this._self, this._then);

  final _SpeakerEditModel _self;
  final $Res Function(_SpeakerEditModel) _then;

/// Create a copy of SpeakerEditModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speaker = null,}) {
  return _then(_SpeakerEditModel(
speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as SpeakerModel,
  ));
}

/// Create a copy of SpeakerEditModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<$Res> get speaker {
  
  return $SpeakerModelCopyWith<$Res>(_self.speaker, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}


/// @nodoc
mixin _$SegmentSplitModel {

@JsonKey(name: 'segments') List<SegmentModel> get segments;@JsonKey(name: 'revision') int get revision;
/// Create a copy of SegmentSplitModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentSplitModelCopyWith<SegmentSplitModel> get copyWith => _$SegmentSplitModelCopyWithImpl<SegmentSplitModel>(this as SegmentSplitModel, _$identity);

  /// Serializes this SegmentSplitModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SegmentSplitModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentSplitModel&&const DeepCollectionEquality().equals(other.segments, _this.segments)&&(identical(other.revision, _this.revision) || other.revision == _this.revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SegmentSplitModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.segments),_this.revision);
}

@override
String toString() {
  final _this = this as SegmentSplitModel;
  return 'SegmentSplitModel(segments: ${_this.segments}, revision: ${_this.revision})';
}


}

/// @nodoc
abstract mixin class $SegmentSplitModelCopyWith<$Res>  {
  factory $SegmentSplitModelCopyWith(SegmentSplitModel value, $Res Function(SegmentSplitModel) _then) = _$SegmentSplitModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'segments') List<SegmentModel> segments,@JsonKey(name: 'revision') int revision
});




}
/// @nodoc
class _$SegmentSplitModelCopyWithImpl<$Res>
    implements $SegmentSplitModelCopyWith<$Res> {
  _$SegmentSplitModelCopyWithImpl(this._self, this._then);

  final SegmentSplitModel _self;
  final $Res Function(SegmentSplitModel) _then;

/// Create a copy of SegmentSplitModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segments = null,Object? revision = null,}) {
  return _then(SegmentSplitModel(
segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<SegmentModel>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SegmentSplitModel].
extension SegmentSplitModelPatterns on SegmentSplitModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentSplitModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentSplitModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentSplitModel value)  $default,){
final _that = this;
switch (_that) {
case _SegmentSplitModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentSplitModel value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentSplitModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'segments')  List<SegmentModel> segments, @JsonKey(name: 'revision')  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentSplitModel() when $default != null:
return $default(_that.segments,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'segments')  List<SegmentModel> segments, @JsonKey(name: 'revision')  int revision)  $default,) {final _that = this;
switch (_that) {
case _SegmentSplitModel():
return $default(_that.segments,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'segments')  List<SegmentModel> segments, @JsonKey(name: 'revision')  int revision)?  $default,) {final _that = this;
switch (_that) {
case _SegmentSplitModel() when $default != null:
return $default(_that.segments,_that.revision);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SegmentSplitModel extends SegmentSplitModel {
  const _SegmentSplitModel({@JsonKey(name: 'segments')  List<SegmentModel> segments = const <SegmentModel>[], @JsonKey(name: 'revision') this.revision = 0}): _segments = segments,super._();
  factory _SegmentSplitModel.fromJson(Map<String, dynamic> json) => _$SegmentSplitModelFromJson(json);

 final  List<SegmentModel> _segments;
@override@JsonKey(name: 'segments') List<SegmentModel> get segments {
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_segments);
}

@override@JsonKey(name: 'revision') final  int revision;

/// Create a copy of SegmentSplitModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentSplitModelCopyWith<_SegmentSplitModel> get copyWith => __$SegmentSplitModelCopyWithImpl<_SegmentSplitModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SegmentSplitModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentSplitModel&&const DeepCollectionEquality().equals(other.segments, _segments)&&(identical(other.revision, revision) || other.revision == revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_segments),revision);
}

@override
String toString() {
    return 'SegmentSplitModel(segments: $segments, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$SegmentSplitModelCopyWith<$Res> implements $SegmentSplitModelCopyWith<$Res> {
  factory _$SegmentSplitModelCopyWith(_SegmentSplitModel value, $Res Function(_SegmentSplitModel) _then) = __$SegmentSplitModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'segments') List<SegmentModel> segments,@JsonKey(name: 'revision') int revision
});




}
/// @nodoc
class __$SegmentSplitModelCopyWithImpl<$Res>
    implements _$SegmentSplitModelCopyWith<$Res> {
  __$SegmentSplitModelCopyWithImpl(this._self, this._then);

  final _SegmentSplitModel _self;
  final $Res Function(_SegmentSplitModel) _then;

/// Create a copy of SegmentSplitModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segments = null,Object? revision = null,}) {
  return _then(_SegmentSplitModel(
segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<SegmentModel>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SegmentMergeModel {

@JsonKey(name: 'segment') SegmentModel get segment;@JsonKey(name: 'removed_id') String get removedId;@JsonKey(name: 'revision') int get revision;
/// Create a copy of SegmentMergeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentMergeModelCopyWith<SegmentMergeModel> get copyWith => _$SegmentMergeModelCopyWithImpl<SegmentMergeModel>(this as SegmentMergeModel, _$identity);

  /// Serializes this SegmentMergeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SegmentMergeModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentMergeModel&&(identical(other.segment, _this.segment) || other.segment == _this.segment)&&(identical(other.removedId, _this.removedId) || other.removedId == _this.removedId)&&(identical(other.revision, _this.revision) || other.revision == _this.revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SegmentMergeModel;
  return Object.hash(runtimeType,_this.segment,_this.removedId,_this.revision);
}

@override
String toString() {
  final _this = this as SegmentMergeModel;
  return 'SegmentMergeModel(segment: ${_this.segment}, removedId: ${_this.removedId}, revision: ${_this.revision})';
}


}

/// @nodoc
abstract mixin class $SegmentMergeModelCopyWith<$Res>  {
  factory $SegmentMergeModelCopyWith(SegmentMergeModel value, $Res Function(SegmentMergeModel) _then) = _$SegmentMergeModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'segment') SegmentModel segment,@JsonKey(name: 'removed_id') String removedId,@JsonKey(name: 'revision') int revision
});


$SegmentModelCopyWith<$Res> get segment;

}
/// @nodoc
class _$SegmentMergeModelCopyWithImpl<$Res>
    implements $SegmentMergeModelCopyWith<$Res> {
  _$SegmentMergeModelCopyWithImpl(this._self, this._then);

  final SegmentMergeModel _self;
  final $Res Function(SegmentMergeModel) _then;

/// Create a copy of SegmentMergeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segment = null,Object? removedId = null,Object? revision = null,}) {
  return _then(SegmentMergeModel(
segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as SegmentModel,removedId: null == removedId ? _self.removedId : removedId // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SegmentMergeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentModelCopyWith<$Res> get segment {
  
  return $SegmentModelCopyWith<$Res>(_self.segment, (value) {
    return _then(_self.copyWith(segment: value));
  });
}
}


/// Adds pattern-matching-related methods to [SegmentMergeModel].
extension SegmentMergeModelPatterns on SegmentMergeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentMergeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentMergeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentMergeModel value)  $default,){
final _that = this;
switch (_that) {
case _SegmentMergeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentMergeModel value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentMergeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'segment')  SegmentModel segment, @JsonKey(name: 'removed_id')  String removedId, @JsonKey(name: 'revision')  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentMergeModel() when $default != null:
return $default(_that.segment,_that.removedId,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'segment')  SegmentModel segment, @JsonKey(name: 'removed_id')  String removedId, @JsonKey(name: 'revision')  int revision)  $default,) {final _that = this;
switch (_that) {
case _SegmentMergeModel():
return $default(_that.segment,_that.removedId,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'segment')  SegmentModel segment, @JsonKey(name: 'removed_id')  String removedId, @JsonKey(name: 'revision')  int revision)?  $default,) {final _that = this;
switch (_that) {
case _SegmentMergeModel() when $default != null:
return $default(_that.segment,_that.removedId,_that.revision);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SegmentMergeModel extends SegmentMergeModel {
  const _SegmentMergeModel({@JsonKey(name: 'segment') required this.segment, @JsonKey(name: 'removed_id') this.removedId = '', @JsonKey(name: 'revision') this.revision = 0}): super._();
  factory _SegmentMergeModel.fromJson(Map<String, dynamic> json) => _$SegmentMergeModelFromJson(json);

@override@JsonKey(name: 'segment') final  SegmentModel segment;
@override@JsonKey(name: 'removed_id') final  String removedId;
@override@JsonKey(name: 'revision') final  int revision;

/// Create a copy of SegmentMergeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentMergeModelCopyWith<_SegmentMergeModel> get copyWith => __$SegmentMergeModelCopyWithImpl<_SegmentMergeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SegmentMergeModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentMergeModel&&(identical(other.segment, segment) || other.segment == segment)&&(identical(other.removedId, removedId) || other.removedId == removedId)&&(identical(other.revision, revision) || other.revision == revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,segment,removedId,revision);
}

@override
String toString() {
    return 'SegmentMergeModel(segment: $segment, removedId: $removedId, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$SegmentMergeModelCopyWith<$Res> implements $SegmentMergeModelCopyWith<$Res> {
  factory _$SegmentMergeModelCopyWith(_SegmentMergeModel value, $Res Function(_SegmentMergeModel) _then) = __$SegmentMergeModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'segment') SegmentModel segment,@JsonKey(name: 'removed_id') String removedId,@JsonKey(name: 'revision') int revision
});


@override $SegmentModelCopyWith<$Res> get segment;

}
/// @nodoc
class __$SegmentMergeModelCopyWithImpl<$Res>
    implements _$SegmentMergeModelCopyWith<$Res> {
  __$SegmentMergeModelCopyWithImpl(this._self, this._then);

  final _SegmentMergeModel _self;
  final $Res Function(_SegmentMergeModel) _then;

/// Create a copy of SegmentMergeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segment = null,Object? removedId = null,Object? revision = null,}) {
  return _then(_SegmentMergeModel(
segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as SegmentModel,removedId: null == removedId ? _self.removedId : removedId // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SegmentMergeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentModelCopyWith<$Res> get segment {
  
  return $SegmentModelCopyWith<$Res>(_self.segment, (value) {
    return _then(_self.copyWith(segment: value));
  });
}
}

// dart format on
