// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarEvent {

 String get id; String get title; DateTime? get startsAt; DateTime? get endsAt;/// Empty when the event has no video link.
 String get joinUrl;/// MEET, ZOOM, TEAMS or empty.
 String get platform;
/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventCopyWith<CalendarEvent> get copyWith => _$CalendarEventCopyWithImpl<CalendarEvent>(this as CalendarEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CalendarEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.joinUrl, _this.joinUrl) || other.joinUrl == _this.joinUrl)&&(identical(other.platform, _this.platform) || other.platform == _this.platform));
}


@override
int get hashCode {
  final _this = this as CalendarEvent;
  return Object.hash(runtimeType,_this.id,_this.title,_this.startsAt,_this.endsAt,_this.joinUrl,_this.platform);
}

@override
String toString() {
  final _this = this as CalendarEvent;
  return 'CalendarEvent(id: ${_this.id}, title: ${_this.title}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, joinUrl: ${_this.joinUrl}, platform: ${_this.platform})';
}


}

/// @nodoc
abstract mixin class $CalendarEventCopyWith<$Res>  {
  factory $CalendarEventCopyWith(CalendarEvent value, $Res Function(CalendarEvent) _then) = _$CalendarEventCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime? startsAt, DateTime? endsAt, String joinUrl, String platform
});




}
/// @nodoc
class _$CalendarEventCopyWithImpl<$Res>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._self, this._then);

  final CalendarEvent _self;
  final $Res Function(CalendarEvent) _then;

/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? joinUrl = null,Object? platform = null,}) {
  return _then(CalendarEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinUrl: null == joinUrl ? _self.joinUrl : joinUrl // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarEvent].
extension CalendarEventPatterns on CalendarEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEvent value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEvent value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime? startsAt,  DateTime? endsAt,  String joinUrl,  String platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.joinUrl,_that.platform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime? startsAt,  DateTime? endsAt,  String joinUrl,  String platform)  $default,) {final _that = this;
switch (_that) {
case _CalendarEvent():
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.joinUrl,_that.platform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime? startsAt,  DateTime? endsAt,  String joinUrl,  String platform)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.joinUrl,_that.platform);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarEvent implements CalendarEvent {
  const _CalendarEvent({required this.id, required this.title, this.startsAt, this.endsAt, this.joinUrl = '', this.platform = ''});
  

@override final  String id;
@override final  String title;
@override final  DateTime? startsAt;
@override final  DateTime? endsAt;
/// Empty when the event has no video link.
@override@JsonKey() final  String joinUrl;
/// MEET, ZOOM, TEAMS or empty.
@override@JsonKey() final  String platform;

/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEventCopyWith<_CalendarEvent> get copyWith => __$CalendarEventCopyWithImpl<_CalendarEvent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.joinUrl, joinUrl) || other.joinUrl == joinUrl)&&(identical(other.platform, platform) || other.platform == platform));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,startsAt,endsAt,joinUrl,platform);
}

@override
String toString() {
    return 'CalendarEvent(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, joinUrl: $joinUrl, platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$CalendarEventCopyWith<$Res> implements $CalendarEventCopyWith<$Res> {
  factory _$CalendarEventCopyWith(_CalendarEvent value, $Res Function(_CalendarEvent) _then) = __$CalendarEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime? startsAt, DateTime? endsAt, String joinUrl, String platform
});




}
/// @nodoc
class __$CalendarEventCopyWithImpl<$Res>
    implements _$CalendarEventCopyWith<$Res> {
  __$CalendarEventCopyWithImpl(this._self, this._then);

  final _CalendarEvent _self;
  final $Res Function(_CalendarEvent) _then;

/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? joinUrl = null,Object? platform = null,}) {
  return _then(_CalendarEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinUrl: null == joinUrl ? _self.joinUrl : joinUrl // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CalendarOverview {

 bool get connected; List<CalendarEvent> get events;
/// Create a copy of CalendarOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarOverviewCopyWith<CalendarOverview> get copyWith => _$CalendarOverviewCopyWithImpl<CalendarOverview>(this as CalendarOverview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CalendarOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarOverview&&(identical(other.connected, _this.connected) || other.connected == _this.connected)&&const DeepCollectionEquality().equals(other.events, _this.events));
}


@override
int get hashCode {
  final _this = this as CalendarOverview;
  return Object.hash(runtimeType,_this.connected,const DeepCollectionEquality().hash(_this.events));
}

@override
String toString() {
  final _this = this as CalendarOverview;
  return 'CalendarOverview(connected: ${_this.connected}, events: ${_this.events})';
}


}

/// @nodoc
abstract mixin class $CalendarOverviewCopyWith<$Res>  {
  factory $CalendarOverviewCopyWith(CalendarOverview value, $Res Function(CalendarOverview) _then) = _$CalendarOverviewCopyWithImpl;
@useResult
$Res call({
 bool connected, List<CalendarEvent> events
});




}
/// @nodoc
class _$CalendarOverviewCopyWithImpl<$Res>
    implements $CalendarOverviewCopyWith<$Res> {
  _$CalendarOverviewCopyWithImpl(this._self, this._then);

  final CalendarOverview _self;
  final $Res Function(CalendarOverview) _then;

/// Create a copy of CalendarOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connected = null,Object? events = null,}) {
  return _then(CalendarOverview(
connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarOverview].
extension CalendarOverviewPatterns on CalendarOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarOverview value)  $default,){
final _that = this;
switch (_that) {
case _CalendarOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarOverview value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool connected,  List<CalendarEvent> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarOverview() when $default != null:
return $default(_that.connected,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool connected,  List<CalendarEvent> events)  $default,) {final _that = this;
switch (_that) {
case _CalendarOverview():
return $default(_that.connected,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool connected,  List<CalendarEvent> events)?  $default,) {final _that = this;
switch (_that) {
case _CalendarOverview() when $default != null:
return $default(_that.connected,_that.events);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarOverview implements CalendarOverview {
  const _CalendarOverview({this.connected = false,  List<CalendarEvent> events = const <CalendarEvent>[]}): _events = events;
  

@override@JsonKey() final  bool connected;
 final  List<CalendarEvent> _events;
@override@JsonKey() List<CalendarEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of CalendarOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarOverviewCopyWith<_CalendarOverview> get copyWith => __$CalendarOverviewCopyWithImpl<_CalendarOverview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarOverview&&(identical(other.connected, connected) || other.connected == connected)&&const DeepCollectionEquality().equals(other.events, _events));
}


@override
int get hashCode {
    return Object.hash(runtimeType,connected,const DeepCollectionEquality().hash(_events));
}

@override
String toString() {
    return 'CalendarOverview(connected: $connected, events: $events)';
}


}

/// @nodoc
abstract mixin class _$CalendarOverviewCopyWith<$Res> implements $CalendarOverviewCopyWith<$Res> {
  factory _$CalendarOverviewCopyWith(_CalendarOverview value, $Res Function(_CalendarOverview) _then) = __$CalendarOverviewCopyWithImpl;
@override @useResult
$Res call({
 bool connected, List<CalendarEvent> events
});




}
/// @nodoc
class __$CalendarOverviewCopyWithImpl<$Res>
    implements _$CalendarOverviewCopyWith<$Res> {
  __$CalendarOverviewCopyWithImpl(this._self, this._then);

  final _CalendarOverview _self;
  final $Res Function(_CalendarOverview) _then;

/// Create a copy of CalendarOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connected = null,Object? events = null,}) {
  return _then(_CalendarOverview(
connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}


}

// dart format on
