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

 String get id; String get title; Duration? get duration; List<Speaker> get speakers;/// In position order, as the API returns them.
 List<Segment> get segments;
/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptCopyWith<Transcript> get copyWith => _$TranscriptCopyWithImpl<Transcript>(this as Transcript, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Transcript;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transcript&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&const DeepCollectionEquality().equals(other.speakers, _this.speakers)&&const DeepCollectionEquality().equals(other.segments, _this.segments));
}


@override
int get hashCode {
  final _this = this as Transcript;
  return Object.hash(runtimeType,_this.id,_this.title,_this.duration,const DeepCollectionEquality().hash(_this.speakers),const DeepCollectionEquality().hash(_this.segments));
}

@override
String toString() {
  final _this = this as Transcript;
  return 'Transcript(id: ${_this.id}, title: ${_this.title}, duration: ${_this.duration}, speakers: ${_this.speakers}, segments: ${_this.segments})';
}


}

/// @nodoc
abstract mixin class $TranscriptCopyWith<$Res>  {
  factory $TranscriptCopyWith(Transcript value, $Res Function(Transcript) _then) = _$TranscriptCopyWithImpl;
@useResult
$Res call({
 String id, String title, Duration? duration, List<Speaker> speakers, List<Segment> segments
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? duration = freezed,Object? speakers = null,Object? segments = null,}) {
  return _then(Transcript(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<Speaker>,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<Segment>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  Duration? duration,  List<Speaker> speakers,  List<Segment> segments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transcript() when $default != null:
return $default(_that.id,_that.title,_that.duration,_that.speakers,_that.segments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  Duration? duration,  List<Speaker> speakers,  List<Segment> segments)  $default,) {final _that = this;
switch (_that) {
case _Transcript():
return $default(_that.id,_that.title,_that.duration,_that.speakers,_that.segments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  Duration? duration,  List<Speaker> speakers,  List<Segment> segments)?  $default,) {final _that = this;
switch (_that) {
case _Transcript() when $default != null:
return $default(_that.id,_that.title,_that.duration,_that.speakers,_that.segments);case _:
  return null;

}
}

}

/// @nodoc


class _Transcript implements Transcript {
  const _Transcript({required this.id, required this.title, this.duration,  List<Speaker> speakers = const <Speaker>[],  List<Segment> segments = const <Segment>[]}): _speakers = speakers,_segments = segments;
  

@override final  String id;
@override final  String title;
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


/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptCopyWith<_Transcript> get copyWith => __$TranscriptCopyWithImpl<_Transcript>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transcript&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.speakers, _speakers)&&const DeepCollectionEquality().equals(other.segments, _segments));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,duration,const DeepCollectionEquality().hash(_speakers),const DeepCollectionEquality().hash(_segments));
}

@override
String toString() {
    return 'Transcript(id: $id, title: $title, duration: $duration, speakers: $speakers, segments: $segments)';
}


}

/// @nodoc
abstract mixin class _$TranscriptCopyWith<$Res> implements $TranscriptCopyWith<$Res> {
  factory _$TranscriptCopyWith(_Transcript value, $Res Function(_Transcript) _then) = __$TranscriptCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, Duration? duration, List<Speaker> speakers, List<Segment> segments
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? duration = freezed,Object? speakers = null,Object? segments = null,}) {
  return _then(_Transcript(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,speakers: null == speakers ? _self._speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<Speaker>,segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<Segment>,
  ));
}


}

// dart format on
