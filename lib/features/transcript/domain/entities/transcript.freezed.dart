// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcript.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Speaker {

 String get id;/// "Maʼruzachi 1" until someone renames it.
 String get label;/// First-appearance order, from 1. Picks the speaker colour.
 int get ordinal;
/// Create a copy of Speaker
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerCopyWith<Speaker> get copyWith => _$SpeakerCopyWithImpl<Speaker>(this as Speaker, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Speaker;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Speaker&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.ordinal, _this.ordinal) || other.ordinal == _this.ordinal));
}


@override
int get hashCode {
  final _this = this as Speaker;
  return Object.hash(runtimeType,_this.id,_this.label,_this.ordinal);
}

@override
String toString() {
  final _this = this as Speaker;
  return 'Speaker(id: ${_this.id}, label: ${_this.label}, ordinal: ${_this.ordinal})';
}


}

/// @nodoc
abstract mixin class $SpeakerCopyWith<$Res>  {
  factory $SpeakerCopyWith(Speaker value, $Res Function(Speaker) _then) = _$SpeakerCopyWithImpl;
@useResult
$Res call({
 String id, String label, int ordinal
});




}
/// @nodoc
class _$SpeakerCopyWithImpl<$Res>
    implements $SpeakerCopyWith<$Res> {
  _$SpeakerCopyWithImpl(this._self, this._then);

  final Speaker _self;
  final $Res Function(Speaker) _then;

/// Create a copy of Speaker
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? ordinal = null,}) {
  return _then(Speaker(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,ordinal: null == ordinal ? _self.ordinal : ordinal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Speaker].
extension SpeakerPatterns on Speaker {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Speaker value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Speaker() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Speaker value)  $default,){
final _that = this;
switch (_that) {
case _Speaker():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Speaker value)?  $default,){
final _that = this;
switch (_that) {
case _Speaker() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  int ordinal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Speaker() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  int ordinal)  $default,) {final _that = this;
switch (_that) {
case _Speaker():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  int ordinal)?  $default,) {final _that = this;
switch (_that) {
case _Speaker() when $default != null:
return $default(_that.id,_that.label,_that.ordinal);case _:
  return null;

}
}

}

/// @nodoc


class _Speaker implements Speaker {
  const _Speaker({required this.id, required this.label, this.ordinal = 0});
  

@override final  String id;
/// "Maʼruzachi 1" until someone renames it.
@override final  String label;
/// First-appearance order, from 1. Picks the speaker colour.
@override@JsonKey() final  int ordinal;

/// Create a copy of Speaker
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerCopyWith<_Speaker> get copyWith => __$SpeakerCopyWithImpl<_Speaker>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Speaker&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.ordinal, ordinal) || other.ordinal == ordinal));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,label,ordinal);
}

@override
String toString() {
    return 'Speaker(id: $id, label: $label, ordinal: $ordinal)';
}


}

/// @nodoc
abstract mixin class _$SpeakerCopyWith<$Res> implements $SpeakerCopyWith<$Res> {
  factory _$SpeakerCopyWith(_Speaker value, $Res Function(_Speaker) _then) = __$SpeakerCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, int ordinal
});




}
/// @nodoc
class __$SpeakerCopyWithImpl<$Res>
    implements _$SpeakerCopyWith<$Res> {
  __$SpeakerCopyWithImpl(this._self, this._then);

  final _Speaker _self;
  final $Res Function(_Speaker) _then;

/// Create a copy of Speaker
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? ordinal = null,}) {
  return _then(_Speaker(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,ordinal: null == ordinal ? _self.ordinal : ordinal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Segment {

 String get id; Duration get start; Duration get end; String get text;/// Null without diarization: there is no fake single speaker.
 String? get speakerId; bool get edited;
/// Create a copy of Segment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentCopyWith<Segment> get copyWith => _$SegmentCopyWithImpl<Segment>(this as Segment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Segment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Segment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.start, _this.start) || other.start == _this.start)&&(identical(other.end, _this.end) || other.end == _this.end)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.speakerId, _this.speakerId) || other.speakerId == _this.speakerId)&&(identical(other.edited, _this.edited) || other.edited == _this.edited));
}


@override
int get hashCode {
  final _this = this as Segment;
  return Object.hash(runtimeType,_this.id,_this.start,_this.end,_this.text,_this.speakerId,_this.edited);
}

@override
String toString() {
  final _this = this as Segment;
  return 'Segment(id: ${_this.id}, start: ${_this.start}, end: ${_this.end}, text: ${_this.text}, speakerId: ${_this.speakerId}, edited: ${_this.edited})';
}


}

/// @nodoc
abstract mixin class $SegmentCopyWith<$Res>  {
  factory $SegmentCopyWith(Segment value, $Res Function(Segment) _then) = _$SegmentCopyWithImpl;
@useResult
$Res call({
 String id, Duration start, Duration end, String text, String? speakerId, bool edited
});




}
/// @nodoc
class _$SegmentCopyWithImpl<$Res>
    implements $SegmentCopyWith<$Res> {
  _$SegmentCopyWithImpl(this._self, this._then);

  final Segment _self;
  final $Res Function(Segment) _then;

/// Create a copy of Segment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? start = null,Object? end = null,Object? text = null,Object? speakerId = freezed,Object? edited = null,}) {
  return _then(Segment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Duration,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Duration,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,speakerId: freezed == speakerId ? _self.speakerId : speakerId // ignore: cast_nullable_to_non_nullable
as String?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Segment].
extension SegmentPatterns on Segment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Segment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Segment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Segment value)  $default,){
final _that = this;
switch (_that) {
case _Segment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Segment value)?  $default,){
final _that = this;
switch (_that) {
case _Segment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Duration start,  Duration end,  String text,  String? speakerId,  bool edited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Segment() when $default != null:
return $default(_that.id,_that.start,_that.end,_that.text,_that.speakerId,_that.edited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Duration start,  Duration end,  String text,  String? speakerId,  bool edited)  $default,) {final _that = this;
switch (_that) {
case _Segment():
return $default(_that.id,_that.start,_that.end,_that.text,_that.speakerId,_that.edited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Duration start,  Duration end,  String text,  String? speakerId,  bool edited)?  $default,) {final _that = this;
switch (_that) {
case _Segment() when $default != null:
return $default(_that.id,_that.start,_that.end,_that.text,_that.speakerId,_that.edited);case _:
  return null;

}
}

}

/// @nodoc


class _Segment implements Segment {
  const _Segment({required this.id, required this.start, required this.end, required this.text, this.speakerId, this.edited = false});
  

@override final  String id;
@override final  Duration start;
@override final  Duration end;
@override final  String text;
/// Null without diarization: there is no fake single speaker.
@override final  String? speakerId;
@override@JsonKey() final  bool edited;

/// Create a copy of Segment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentCopyWith<_Segment> get copyWith => __$SegmentCopyWithImpl<_Segment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Segment&&(identical(other.id, id) || other.id == id)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.text, text) || other.text == text)&&(identical(other.speakerId, speakerId) || other.speakerId == speakerId)&&(identical(other.edited, edited) || other.edited == edited));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,start,end,text,speakerId,edited);
}

@override
String toString() {
    return 'Segment(id: $id, start: $start, end: $end, text: $text, speakerId: $speakerId, edited: $edited)';
}


}

/// @nodoc
abstract mixin class _$SegmentCopyWith<$Res> implements $SegmentCopyWith<$Res> {
  factory _$SegmentCopyWith(_Segment value, $Res Function(_Segment) _then) = __$SegmentCopyWithImpl;
@override @useResult
$Res call({
 String id, Duration start, Duration end, String text, String? speakerId, bool edited
});




}
/// @nodoc
class __$SegmentCopyWithImpl<$Res>
    implements _$SegmentCopyWith<$Res> {
  __$SegmentCopyWithImpl(this._self, this._then);

  final _Segment _self;
  final $Res Function(_Segment) _then;

/// Create a copy of Segment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? start = null,Object? end = null,Object? text = null,Object? speakerId = freezed,Object? edited = null,}) {
  return _then(_Segment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Duration,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Duration,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,speakerId: freezed == speakerId ? _self.speakerId : speakerId // ignore: cast_nullable_to_non_nullable
as String?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Transcript {

 String get id; String get title;/// The file this transcript was made from: the player's media and
/// what «Qayta transkripsiya» starts again. Empty if the server
/// left it out.
 String get mediaId; Duration? get duration; List<Speaker> get speakers;/// In position order, as the API returns them.
 List<Segment> get segments;/// Optimistic lock for segment text. Sent with every text edit; the
/// server answers 409 when someone saved in between.
 int get revision;
/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptCopyWith<Transcript> get copyWith => _$TranscriptCopyWithImpl<Transcript>(this as Transcript, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Transcript;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transcript&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&const DeepCollectionEquality().equals(other.speakers, _this.speakers)&&const DeepCollectionEquality().equals(other.segments, _this.segments)&&(identical(other.revision, _this.revision) || other.revision == _this.revision));
}


@override
int get hashCode {
  final _this = this as Transcript;
  return Object.hash(runtimeType,_this.id,_this.title,_this.mediaId,_this.duration,const DeepCollectionEquality().hash(_this.speakers),const DeepCollectionEquality().hash(_this.segments),_this.revision);
}

@override
String toString() {
  final _this = this as Transcript;
  return 'Transcript(id: ${_this.id}, title: ${_this.title}, mediaId: ${_this.mediaId}, duration: ${_this.duration}, speakers: ${_this.speakers}, segments: ${_this.segments}, revision: ${_this.revision})';
}


}

/// @nodoc
abstract mixin class $TranscriptCopyWith<$Res>  {
  factory $TranscriptCopyWith(Transcript value, $Res Function(Transcript) _then) = _$TranscriptCopyWithImpl;
@useResult
$Res call({
 String id, String title, String mediaId, Duration? duration, List<Speaker> speakers, List<Segment> segments, int revision
});




}
/// @nodoc
class _$TranscriptCopyWithImpl<$Res>
    implements $TranscriptCopyWith<$Res> {
  _$TranscriptCopyWithImpl(this._self, this._then);

  final Transcript _self;
  final $Res Function(Transcript) _then;

/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? mediaId = null,Object? duration = freezed,Object? speakers = null,Object? segments = null,Object? revision = null,}) {
  return _then(Transcript(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<Speaker>,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<Segment>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Transcript].
extension TranscriptPatterns on Transcript {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transcript value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transcript() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transcript value)  $default,){
final _that = this;
switch (_that) {
case _Transcript():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transcript value)?  $default,){
final _that = this;
switch (_that) {
case _Transcript() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String mediaId,  Duration? duration,  List<Speaker> speakers,  List<Segment> segments,  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transcript() when $default != null:
return $default(_that.id,_that.title,_that.mediaId,_that.duration,_that.speakers,_that.segments,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String mediaId,  Duration? duration,  List<Speaker> speakers,  List<Segment> segments,  int revision)  $default,) {final _that = this;
switch (_that) {
case _Transcript():
return $default(_that.id,_that.title,_that.mediaId,_that.duration,_that.speakers,_that.segments,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String mediaId,  Duration? duration,  List<Speaker> speakers,  List<Segment> segments,  int revision)?  $default,) {final _that = this;
switch (_that) {
case _Transcript() when $default != null:
return $default(_that.id,_that.title,_that.mediaId,_that.duration,_that.speakers,_that.segments,_that.revision);case _:
  return null;

}
}

}

/// @nodoc


class _Transcript implements Transcript {
  const _Transcript({required this.id, required this.title, this.mediaId = '', this.duration,  List<Speaker> speakers = const <Speaker>[],  List<Segment> segments = const <Segment>[], this.revision = 0}): _speakers = speakers,_segments = segments;
  

@override final  String id;
@override final  String title;
/// The file this transcript was made from: the player's media and
/// what «Qayta transkripsiya» starts again. Empty if the server
/// left it out.
@override@JsonKey() final  String mediaId;
@override final  Duration? duration;
 final  List<Speaker> _speakers;
@override@JsonKey() List<Speaker> get speakers {
  if (_speakers is EqualUnmodifiableListView) return _speakers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_speakers);
}

/// In position order, as the API returns them.
 final  List<Segment> _segments;
/// In position order, as the API returns them.
@override@JsonKey() List<Segment> get segments {
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_segments);
}

/// Optimistic lock for segment text. Sent with every text edit; the
/// server answers 409 when someone saved in between.
@override@JsonKey() final  int revision;

/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptCopyWith<_Transcript> get copyWith => __$TranscriptCopyWithImpl<_Transcript>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transcript&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.speakers, _speakers)&&const DeepCollectionEquality().equals(other.segments, _segments)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,mediaId,duration,const DeepCollectionEquality().hash(_speakers),const DeepCollectionEquality().hash(_segments),revision);
}

@override
String toString() {
    return 'Transcript(id: $id, title: $title, mediaId: $mediaId, duration: $duration, speakers: $speakers, segments: $segments, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$TranscriptCopyWith<$Res> implements $TranscriptCopyWith<$Res> {
  factory _$TranscriptCopyWith(_Transcript value, $Res Function(_Transcript) _then) = __$TranscriptCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String mediaId, Duration? duration, List<Speaker> speakers, List<Segment> segments, int revision
});




}
/// @nodoc
class __$TranscriptCopyWithImpl<$Res>
    implements _$TranscriptCopyWith<$Res> {
  __$TranscriptCopyWithImpl(this._self, this._then);

  final _Transcript _self;
  final $Res Function(_Transcript) _then;

/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? mediaId = null,Object? duration = freezed,Object? speakers = null,Object? segments = null,Object? revision = null,}) {
  return _then(_Transcript(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,speakers: null == speakers ? _self._speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<Speaker>,segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<Segment>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SegmentEdit {

 Segment get segment; int get revision;/// The speaker a "new speaker" assignment opened, with the server's
/// default name. Null for every other edit.
 Speaker? get newSpeaker;
/// Create a copy of SegmentEdit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentEditCopyWith<SegmentEdit> get copyWith => _$SegmentEditCopyWithImpl<SegmentEdit>(this as SegmentEdit, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SegmentEdit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentEdit&&(identical(other.segment, _this.segment) || other.segment == _this.segment)&&(identical(other.revision, _this.revision) || other.revision == _this.revision)&&(identical(other.newSpeaker, _this.newSpeaker) || other.newSpeaker == _this.newSpeaker));
}


@override
int get hashCode {
  final _this = this as SegmentEdit;
  return Object.hash(runtimeType,_this.segment,_this.revision,_this.newSpeaker);
}

@override
String toString() {
  final _this = this as SegmentEdit;
  return 'SegmentEdit(segment: ${_this.segment}, revision: ${_this.revision}, newSpeaker: ${_this.newSpeaker})';
}


}

/// @nodoc
abstract mixin class $SegmentEditCopyWith<$Res>  {
  factory $SegmentEditCopyWith(SegmentEdit value, $Res Function(SegmentEdit) _then) = _$SegmentEditCopyWithImpl;
@useResult
$Res call({
 Segment segment, int revision, Speaker? newSpeaker
});


$SegmentCopyWith<$Res> get segment;$SpeakerCopyWith<$Res>? get newSpeaker;

}
/// @nodoc
class _$SegmentEditCopyWithImpl<$Res>
    implements $SegmentEditCopyWith<$Res> {
  _$SegmentEditCopyWithImpl(this._self, this._then);

  final SegmentEdit _self;
  final $Res Function(SegmentEdit) _then;

/// Create a copy of SegmentEdit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segment = null,Object? revision = null,Object? newSpeaker = freezed,}) {
  return _then(SegmentEdit(
segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as Segment,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,newSpeaker: freezed == newSpeaker ? _self.newSpeaker : newSpeaker // ignore: cast_nullable_to_non_nullable
as Speaker?,
  ));
}
/// Create a copy of SegmentEdit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentCopyWith<$Res> get segment {
  
  return $SegmentCopyWith<$Res>(_self.segment, (value) {
    return _then(_self.copyWith(segment: value));
  });
}/// Create a copy of SegmentEdit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerCopyWith<$Res>? get newSpeaker {
    if (_self.newSpeaker == null) {
    return null;
  }

  return $SpeakerCopyWith<$Res>(_self.newSpeaker!, (value) {
    return _then(_self.copyWith(newSpeaker: value));
  });
}
}


/// Adds pattern-matching-related methods to [SegmentEdit].
extension SegmentEditPatterns on SegmentEdit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentEdit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentEdit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentEdit value)  $default,){
final _that = this;
switch (_that) {
case _SegmentEdit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentEdit value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentEdit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Segment segment,  int revision,  Speaker? newSpeaker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentEdit() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Segment segment,  int revision,  Speaker? newSpeaker)  $default,) {final _that = this;
switch (_that) {
case _SegmentEdit():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Segment segment,  int revision,  Speaker? newSpeaker)?  $default,) {final _that = this;
switch (_that) {
case _SegmentEdit() when $default != null:
return $default(_that.segment,_that.revision,_that.newSpeaker);case _:
  return null;

}
}

}

/// @nodoc


class _SegmentEdit implements SegmentEdit {
  const _SegmentEdit({required this.segment, required this.revision, this.newSpeaker});
  

@override final  Segment segment;
@override final  int revision;
/// The speaker a "new speaker" assignment opened, with the server's
/// default name. Null for every other edit.
@override final  Speaker? newSpeaker;

/// Create a copy of SegmentEdit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentEditCopyWith<_SegmentEdit> get copyWith => __$SegmentEditCopyWithImpl<_SegmentEdit>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentEdit&&(identical(other.segment, segment) || other.segment == segment)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.newSpeaker, newSpeaker) || other.newSpeaker == newSpeaker));
}


@override
int get hashCode {
    return Object.hash(runtimeType,segment,revision,newSpeaker);
}

@override
String toString() {
    return 'SegmentEdit(segment: $segment, revision: $revision, newSpeaker: $newSpeaker)';
}


}

/// @nodoc
abstract mixin class _$SegmentEditCopyWith<$Res> implements $SegmentEditCopyWith<$Res> {
  factory _$SegmentEditCopyWith(_SegmentEdit value, $Res Function(_SegmentEdit) _then) = __$SegmentEditCopyWithImpl;
@override @useResult
$Res call({
 Segment segment, int revision, Speaker? newSpeaker
});


@override $SegmentCopyWith<$Res> get segment;@override $SpeakerCopyWith<$Res>? get newSpeaker;

}
/// @nodoc
class __$SegmentEditCopyWithImpl<$Res>
    implements _$SegmentEditCopyWith<$Res> {
  __$SegmentEditCopyWithImpl(this._self, this._then);

  final _SegmentEdit _self;
  final $Res Function(_SegmentEdit) _then;

/// Create a copy of SegmentEdit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segment = null,Object? revision = null,Object? newSpeaker = freezed,}) {
  return _then(_SegmentEdit(
segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as Segment,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,newSpeaker: freezed == newSpeaker ? _self.newSpeaker : newSpeaker // ignore: cast_nullable_to_non_nullable
as Speaker?,
  ));
}

/// Create a copy of SegmentEdit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentCopyWith<$Res> get segment {
  
  return $SegmentCopyWith<$Res>(_self.segment, (value) {
    return _then(_self.copyWith(segment: value));
  });
}/// Create a copy of SegmentEdit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerCopyWith<$Res>? get newSpeaker {
    if (_self.newSpeaker == null) {
    return null;
  }

  return $SpeakerCopyWith<$Res>(_self.newSpeaker!, (value) {
    return _then(_self.copyWith(newSpeaker: value));
  });
}
}

/// @nodoc
mixin _$SegmentSplit {

 Segment get first; Segment get second; int get revision;
/// Create a copy of SegmentSplit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentSplitCopyWith<SegmentSplit> get copyWith => _$SegmentSplitCopyWithImpl<SegmentSplit>(this as SegmentSplit, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SegmentSplit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentSplit&&(identical(other.first, _this.first) || other.first == _this.first)&&(identical(other.second, _this.second) || other.second == _this.second)&&(identical(other.revision, _this.revision) || other.revision == _this.revision));
}


@override
int get hashCode {
  final _this = this as SegmentSplit;
  return Object.hash(runtimeType,_this.first,_this.second,_this.revision);
}

@override
String toString() {
  final _this = this as SegmentSplit;
  return 'SegmentSplit(first: ${_this.first}, second: ${_this.second}, revision: ${_this.revision})';
}


}

/// @nodoc
abstract mixin class $SegmentSplitCopyWith<$Res>  {
  factory $SegmentSplitCopyWith(SegmentSplit value, $Res Function(SegmentSplit) _then) = _$SegmentSplitCopyWithImpl;
@useResult
$Res call({
 Segment first, Segment second, int revision
});


$SegmentCopyWith<$Res> get first;$SegmentCopyWith<$Res> get second;

}
/// @nodoc
class _$SegmentSplitCopyWithImpl<$Res>
    implements $SegmentSplitCopyWith<$Res> {
  _$SegmentSplitCopyWithImpl(this._self, this._then);

  final SegmentSplit _self;
  final $Res Function(SegmentSplit) _then;

/// Create a copy of SegmentSplit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? first = null,Object? second = null,Object? revision = null,}) {
  return _then(SegmentSplit(
first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as Segment,second: null == second ? _self.second : second // ignore: cast_nullable_to_non_nullable
as Segment,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SegmentSplit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentCopyWith<$Res> get first {
  
  return $SegmentCopyWith<$Res>(_self.first, (value) {
    return _then(_self.copyWith(first: value));
  });
}/// Create a copy of SegmentSplit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentCopyWith<$Res> get second {
  
  return $SegmentCopyWith<$Res>(_self.second, (value) {
    return _then(_self.copyWith(second: value));
  });
}
}


/// Adds pattern-matching-related methods to [SegmentSplit].
extension SegmentSplitPatterns on SegmentSplit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentSplit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentSplit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentSplit value)  $default,){
final _that = this;
switch (_that) {
case _SegmentSplit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentSplit value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentSplit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Segment first,  Segment second,  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentSplit() when $default != null:
return $default(_that.first,_that.second,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Segment first,  Segment second,  int revision)  $default,) {final _that = this;
switch (_that) {
case _SegmentSplit():
return $default(_that.first,_that.second,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Segment first,  Segment second,  int revision)?  $default,) {final _that = this;
switch (_that) {
case _SegmentSplit() when $default != null:
return $default(_that.first,_that.second,_that.revision);case _:
  return null;

}
}

}

/// @nodoc


class _SegmentSplit implements SegmentSplit {
  const _SegmentSplit({required this.first, required this.second, required this.revision});
  

@override final  Segment first;
@override final  Segment second;
@override final  int revision;

/// Create a copy of SegmentSplit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentSplitCopyWith<_SegmentSplit> get copyWith => __$SegmentSplitCopyWithImpl<_SegmentSplit>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentSplit&&(identical(other.first, first) || other.first == first)&&(identical(other.second, second) || other.second == second)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode {
    return Object.hash(runtimeType,first,second,revision);
}

@override
String toString() {
    return 'SegmentSplit(first: $first, second: $second, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$SegmentSplitCopyWith<$Res> implements $SegmentSplitCopyWith<$Res> {
  factory _$SegmentSplitCopyWith(_SegmentSplit value, $Res Function(_SegmentSplit) _then) = __$SegmentSplitCopyWithImpl;
@override @useResult
$Res call({
 Segment first, Segment second, int revision
});


@override $SegmentCopyWith<$Res> get first;@override $SegmentCopyWith<$Res> get second;

}
/// @nodoc
class __$SegmentSplitCopyWithImpl<$Res>
    implements _$SegmentSplitCopyWith<$Res> {
  __$SegmentSplitCopyWithImpl(this._self, this._then);

  final _SegmentSplit _self;
  final $Res Function(_SegmentSplit) _then;

/// Create a copy of SegmentSplit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? first = null,Object? second = null,Object? revision = null,}) {
  return _then(_SegmentSplit(
first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as Segment,second: null == second ? _self.second : second // ignore: cast_nullable_to_non_nullable
as Segment,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SegmentSplit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentCopyWith<$Res> get first {
  
  return $SegmentCopyWith<$Res>(_self.first, (value) {
    return _then(_self.copyWith(first: value));
  });
}/// Create a copy of SegmentSplit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentCopyWith<$Res> get second {
  
  return $SegmentCopyWith<$Res>(_self.second, (value) {
    return _then(_self.copyWith(second: value));
  });
}
}

/// @nodoc
mixin _$SegmentMerge {

 Segment get segment; String get removedId; int get revision;
/// Create a copy of SegmentMerge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentMergeCopyWith<SegmentMerge> get copyWith => _$SegmentMergeCopyWithImpl<SegmentMerge>(this as SegmentMerge, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SegmentMerge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentMerge&&(identical(other.segment, _this.segment) || other.segment == _this.segment)&&(identical(other.removedId, _this.removedId) || other.removedId == _this.removedId)&&(identical(other.revision, _this.revision) || other.revision == _this.revision));
}


@override
int get hashCode {
  final _this = this as SegmentMerge;
  return Object.hash(runtimeType,_this.segment,_this.removedId,_this.revision);
}

@override
String toString() {
  final _this = this as SegmentMerge;
  return 'SegmentMerge(segment: ${_this.segment}, removedId: ${_this.removedId}, revision: ${_this.revision})';
}


}

/// @nodoc
abstract mixin class $SegmentMergeCopyWith<$Res>  {
  factory $SegmentMergeCopyWith(SegmentMerge value, $Res Function(SegmentMerge) _then) = _$SegmentMergeCopyWithImpl;
@useResult
$Res call({
 Segment segment, String removedId, int revision
});


$SegmentCopyWith<$Res> get segment;

}
/// @nodoc
class _$SegmentMergeCopyWithImpl<$Res>
    implements $SegmentMergeCopyWith<$Res> {
  _$SegmentMergeCopyWithImpl(this._self, this._then);

  final SegmentMerge _self;
  final $Res Function(SegmentMerge) _then;

/// Create a copy of SegmentMerge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segment = null,Object? removedId = null,Object? revision = null,}) {
  return _then(SegmentMerge(
segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as Segment,removedId: null == removedId ? _self.removedId : removedId // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SegmentMerge
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentCopyWith<$Res> get segment {
  
  return $SegmentCopyWith<$Res>(_self.segment, (value) {
    return _then(_self.copyWith(segment: value));
  });
}
}


/// Adds pattern-matching-related methods to [SegmentMerge].
extension SegmentMergePatterns on SegmentMerge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentMerge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentMerge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentMerge value)  $default,){
final _that = this;
switch (_that) {
case _SegmentMerge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentMerge value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentMerge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Segment segment,  String removedId,  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentMerge() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Segment segment,  String removedId,  int revision)  $default,) {final _that = this;
switch (_that) {
case _SegmentMerge():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Segment segment,  String removedId,  int revision)?  $default,) {final _that = this;
switch (_that) {
case _SegmentMerge() when $default != null:
return $default(_that.segment,_that.removedId,_that.revision);case _:
  return null;

}
}

}

/// @nodoc


class _SegmentMerge implements SegmentMerge {
  const _SegmentMerge({required this.segment, required this.removedId, required this.revision});
  

@override final  Segment segment;
@override final  String removedId;
@override final  int revision;

/// Create a copy of SegmentMerge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentMergeCopyWith<_SegmentMerge> get copyWith => __$SegmentMergeCopyWithImpl<_SegmentMerge>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentMerge&&(identical(other.segment, segment) || other.segment == segment)&&(identical(other.removedId, removedId) || other.removedId == removedId)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode {
    return Object.hash(runtimeType,segment,removedId,revision);
}

@override
String toString() {
    return 'SegmentMerge(segment: $segment, removedId: $removedId, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$SegmentMergeCopyWith<$Res> implements $SegmentMergeCopyWith<$Res> {
  factory _$SegmentMergeCopyWith(_SegmentMerge value, $Res Function(_SegmentMerge) _then) = __$SegmentMergeCopyWithImpl;
@override @useResult
$Res call({
 Segment segment, String removedId, int revision
});


@override $SegmentCopyWith<$Res> get segment;

}
/// @nodoc
class __$SegmentMergeCopyWithImpl<$Res>
    implements _$SegmentMergeCopyWith<$Res> {
  __$SegmentMergeCopyWithImpl(this._self, this._then);

  final _SegmentMerge _self;
  final $Res Function(_SegmentMerge) _then;

/// Create a copy of SegmentMerge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segment = null,Object? removedId = null,Object? revision = null,}) {
  return _then(_SegmentMerge(
segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as Segment,removedId: null == removedId ? _self.removedId : removedId // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SegmentMerge
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentCopyWith<$Res> get segment {
  
  return $SegmentCopyWith<$Res>(_self.segment, (value) {
    return _then(_self.copyWith(segment: value));
  });
}
}

/// @nodoc
mixin _$TranscriptMeta {

 String get title; int get revision;
/// Create a copy of TranscriptMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptMetaCopyWith<TranscriptMeta> get copyWith => _$TranscriptMetaCopyWithImpl<TranscriptMeta>(this as TranscriptMeta, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TranscriptMeta;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptMeta&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.revision, _this.revision) || other.revision == _this.revision));
}


@override
int get hashCode {
  final _this = this as TranscriptMeta;
  return Object.hash(runtimeType,_this.title,_this.revision);
}

@override
String toString() {
  final _this = this as TranscriptMeta;
  return 'TranscriptMeta(title: ${_this.title}, revision: ${_this.revision})';
}


}

/// @nodoc
abstract mixin class $TranscriptMetaCopyWith<$Res>  {
  factory $TranscriptMetaCopyWith(TranscriptMeta value, $Res Function(TranscriptMeta) _then) = _$TranscriptMetaCopyWithImpl;
@useResult
$Res call({
 String title, int revision
});




}
/// @nodoc
class _$TranscriptMetaCopyWithImpl<$Res>
    implements $TranscriptMetaCopyWith<$Res> {
  _$TranscriptMetaCopyWithImpl(this._self, this._then);

  final TranscriptMeta _self;
  final $Res Function(TranscriptMeta) _then;

/// Create a copy of TranscriptMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? revision = null,}) {
  return _then(TranscriptMeta(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TranscriptMeta].
extension TranscriptMetaPatterns on TranscriptMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptMeta value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptMeta value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptMeta() when $default != null:
return $default(_that.title,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int revision)  $default,) {final _that = this;
switch (_that) {
case _TranscriptMeta():
return $default(_that.title,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int revision)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptMeta() when $default != null:
return $default(_that.title,_that.revision);case _:
  return null;

}
}

}

/// @nodoc


class _TranscriptMeta implements TranscriptMeta {
  const _TranscriptMeta({required this.title, required this.revision});
  

@override final  String title;
@override final  int revision;

/// Create a copy of TranscriptMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptMetaCopyWith<_TranscriptMeta> get copyWith => __$TranscriptMetaCopyWithImpl<_TranscriptMeta>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptMeta&&(identical(other.title, title) || other.title == title)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,revision);
}

@override
String toString() {
    return 'TranscriptMeta(title: $title, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$TranscriptMetaCopyWith<$Res> implements $TranscriptMetaCopyWith<$Res> {
  factory _$TranscriptMetaCopyWith(_TranscriptMeta value, $Res Function(_TranscriptMeta) _then) = __$TranscriptMetaCopyWithImpl;
@override @useResult
$Res call({
 String title, int revision
});




}
/// @nodoc
class __$TranscriptMetaCopyWithImpl<$Res>
    implements _$TranscriptMetaCopyWith<$Res> {
  __$TranscriptMetaCopyWithImpl(this._self, this._then);

  final _TranscriptMeta _self;
  final $Res Function(_TranscriptMeta) _then;

/// Create a copy of TranscriptMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? revision = null,}) {
  return _then(_TranscriptMeta(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
