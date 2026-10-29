// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_bot_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeetingBotState {

 String? get workspaceId;/// The recent-bots list under the form; its own status, so a failed
/// list never hides the form or a bot being watched.
 MeetingListStatus get listStatus; List<MeetingBot> get items; Failure? get listFailure;/// The server has the bot routes but it is switched off there.
 bool get available; String get defaultBotName;/// The server answered 404 for the route itself: it has no meeting
/// bot yet (backend branch not deployed).
 bool get routeMissing;/// The form's URL is not a Google Meet link; nothing was sent.
 bool get urlInvalid; bool get submitting;/// Of the last send or cancel.
 Failure? get actionFailure;/// The bot whose status view is open; null shows the form.
 MeetingBot? get active; bool get cancelling;/// The last poll failed; the bot is still shown and polling goes on
/// when the failure is transient.
 Failure? get pollFailure;
/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingBotStateCopyWith<MeetingBotState> get copyWith => _$MeetingBotStateCopyWithImpl<MeetingBotState>(this as MeetingBotState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MeetingBotState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingBotState&&(identical(other.workspaceId, _this.workspaceId) || other.workspaceId == _this.workspaceId)&&(identical(other.listStatus, _this.listStatus) || other.listStatus == _this.listStatus)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.listFailure, _this.listFailure) || other.listFailure == _this.listFailure)&&(identical(other.available, _this.available) || other.available == _this.available)&&(identical(other.defaultBotName, _this.defaultBotName) || other.defaultBotName == _this.defaultBotName)&&(identical(other.routeMissing, _this.routeMissing) || other.routeMissing == _this.routeMissing)&&(identical(other.urlInvalid, _this.urlInvalid) || other.urlInvalid == _this.urlInvalid)&&(identical(other.submitting, _this.submitting) || other.submitting == _this.submitting)&&(identical(other.actionFailure, _this.actionFailure) || other.actionFailure == _this.actionFailure)&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.cancelling, _this.cancelling) || other.cancelling == _this.cancelling)&&(identical(other.pollFailure, _this.pollFailure) || other.pollFailure == _this.pollFailure));
}


@override
int get hashCode {
  final _this = this as MeetingBotState;
  return Object.hash(runtimeType,_this.workspaceId,_this.listStatus,const DeepCollectionEquality().hash(_this.items),_this.listFailure,_this.available,_this.defaultBotName,_this.routeMissing,_this.urlInvalid,_this.submitting,_this.actionFailure,_this.active,_this.cancelling,_this.pollFailure);
}

@override
String toString() {
  final _this = this as MeetingBotState;
  return 'MeetingBotState(workspaceId: ${_this.workspaceId}, listStatus: ${_this.listStatus}, items: ${_this.items}, listFailure: ${_this.listFailure}, available: ${_this.available}, defaultBotName: ${_this.defaultBotName}, routeMissing: ${_this.routeMissing}, urlInvalid: ${_this.urlInvalid}, submitting: ${_this.submitting}, actionFailure: ${_this.actionFailure}, active: ${_this.active}, cancelling: ${_this.cancelling}, pollFailure: ${_this.pollFailure})';
}


}

/// @nodoc
abstract mixin class $MeetingBotStateCopyWith<$Res>  {
  factory $MeetingBotStateCopyWith(MeetingBotState value, $Res Function(MeetingBotState) _then) = _$MeetingBotStateCopyWithImpl;
@useResult
$Res call({
 String? workspaceId, MeetingListStatus listStatus, List<MeetingBot> items, Failure? listFailure, bool available, String defaultBotName, bool routeMissing, bool urlInvalid, bool submitting, Failure? actionFailure, MeetingBot? active, bool cancelling, Failure? pollFailure
});


$FailureCopyWith<$Res>? get listFailure;$FailureCopyWith<$Res>? get actionFailure;$MeetingBotCopyWith<$Res>? get active;$FailureCopyWith<$Res>? get pollFailure;

}
/// @nodoc
class _$MeetingBotStateCopyWithImpl<$Res>
    implements $MeetingBotStateCopyWith<$Res> {
  _$MeetingBotStateCopyWithImpl(this._self, this._then);

  final MeetingBotState _self;
  final $Res Function(MeetingBotState) _then;

/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workspaceId = freezed,Object? listStatus = null,Object? items = null,Object? listFailure = freezed,Object? available = null,Object? defaultBotName = null,Object? routeMissing = null,Object? urlInvalid = null,Object? submitting = null,Object? actionFailure = freezed,Object? active = freezed,Object? cancelling = null,Object? pollFailure = freezed,}) {
  return _then(MeetingBotState(
workspaceId: freezed == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String?,listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as MeetingListStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MeetingBot>,listFailure: freezed == listFailure ? _self.listFailure : listFailure // ignore: cast_nullable_to_non_nullable
as Failure?,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,defaultBotName: null == defaultBotName ? _self.defaultBotName : defaultBotName // ignore: cast_nullable_to_non_nullable
as String,routeMissing: null == routeMissing ? _self.routeMissing : routeMissing // ignore: cast_nullable_to_non_nullable
as bool,urlInvalid: null == urlInvalid ? _self.urlInvalid : urlInvalid // ignore: cast_nullable_to_non_nullable
as bool,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as MeetingBot?,cancelling: null == cancelling ? _self.cancelling : cancelling // ignore: cast_nullable_to_non_nullable
as bool,pollFailure: freezed == pollFailure ? _self.pollFailure : pollFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get listFailure {
    if (_self.listFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.listFailure!, (value) {
    return _then(_self.copyWith(listFailure: value));
  });
}/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeetingBotCopyWith<$Res>? get active {
    if (_self.active == null) {
    return null;
  }

  return $MeetingBotCopyWith<$Res>(_self.active!, (value) {
    return _then(_self.copyWith(active: value));
  });
}/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get pollFailure {
    if (_self.pollFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.pollFailure!, (value) {
    return _then(_self.copyWith(pollFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeetingBotState].
extension MeetingBotStatePatterns on MeetingBotState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingBotState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingBotState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingBotState value)  $default,){
final _that = this;
switch (_that) {
case _MeetingBotState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingBotState value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingBotState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? workspaceId,  MeetingListStatus listStatus,  List<MeetingBot> items,  Failure? listFailure,  bool available,  String defaultBotName,  bool routeMissing,  bool urlInvalid,  bool submitting,  Failure? actionFailure,  MeetingBot? active,  bool cancelling,  Failure? pollFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingBotState() when $default != null:
return $default(_that.workspaceId,_that.listStatus,_that.items,_that.listFailure,_that.available,_that.defaultBotName,_that.routeMissing,_that.urlInvalid,_that.submitting,_that.actionFailure,_that.active,_that.cancelling,_that.pollFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? workspaceId,  MeetingListStatus listStatus,  List<MeetingBot> items,  Failure? listFailure,  bool available,  String defaultBotName,  bool routeMissing,  bool urlInvalid,  bool submitting,  Failure? actionFailure,  MeetingBot? active,  bool cancelling,  Failure? pollFailure)  $default,) {final _that = this;
switch (_that) {
case _MeetingBotState():
return $default(_that.workspaceId,_that.listStatus,_that.items,_that.listFailure,_that.available,_that.defaultBotName,_that.routeMissing,_that.urlInvalid,_that.submitting,_that.actionFailure,_that.active,_that.cancelling,_that.pollFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? workspaceId,  MeetingListStatus listStatus,  List<MeetingBot> items,  Failure? listFailure,  bool available,  String defaultBotName,  bool routeMissing,  bool urlInvalid,  bool submitting,  Failure? actionFailure,  MeetingBot? active,  bool cancelling,  Failure? pollFailure)?  $default,) {final _that = this;
switch (_that) {
case _MeetingBotState() when $default != null:
return $default(_that.workspaceId,_that.listStatus,_that.items,_that.listFailure,_that.available,_that.defaultBotName,_that.routeMissing,_that.urlInvalid,_that.submitting,_that.actionFailure,_that.active,_that.cancelling,_that.pollFailure);case _:
  return null;

}
}

}

/// @nodoc


class _MeetingBotState implements MeetingBotState {
  const _MeetingBotState({this.workspaceId, this.listStatus = MeetingListStatus.initial,  List<MeetingBot> items = const <MeetingBot>[], this.listFailure, this.available = true, this.defaultBotName = '', this.routeMissing = false, this.urlInvalid = false, this.submitting = false, this.actionFailure, this.active, this.cancelling = false, this.pollFailure}): _items = items;
  

@override final  String? workspaceId;
/// The recent-bots list under the form; its own status, so a failed
/// list never hides the form or a bot being watched.
@override@JsonKey() final  MeetingListStatus listStatus;
 final  List<MeetingBot> _items;
@override@JsonKey() List<MeetingBot> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  Failure? listFailure;
/// The server has the bot routes but it is switched off there.
@override@JsonKey() final  bool available;
@override@JsonKey() final  String defaultBotName;
/// The server answered 404 for the route itself: it has no meeting
/// bot yet (backend branch not deployed).
@override@JsonKey() final  bool routeMissing;
/// The form's URL is not a Google Meet link; nothing was sent.
@override@JsonKey() final  bool urlInvalid;
@override@JsonKey() final  bool submitting;
/// Of the last send or cancel.
@override final  Failure? actionFailure;
/// The bot whose status view is open; null shows the form.
@override final  MeetingBot? active;
@override@JsonKey() final  bool cancelling;
/// The last poll failed; the bot is still shown and polling goes on
/// when the failure is transient.
@override final  Failure? pollFailure;

/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingBotStateCopyWith<_MeetingBotState> get copyWith => __$MeetingBotStateCopyWithImpl<_MeetingBotState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingBotState&&(identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId)&&(identical(other.listStatus, listStatus) || other.listStatus == listStatus)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.listFailure, listFailure) || other.listFailure == listFailure)&&(identical(other.available, available) || other.available == available)&&(identical(other.defaultBotName, defaultBotName) || other.defaultBotName == defaultBotName)&&(identical(other.routeMissing, routeMissing) || other.routeMissing == routeMissing)&&(identical(other.urlInvalid, urlInvalid) || other.urlInvalid == urlInvalid)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure)&&(identical(other.active, active) || other.active == active)&&(identical(other.cancelling, cancelling) || other.cancelling == cancelling)&&(identical(other.pollFailure, pollFailure) || other.pollFailure == pollFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,workspaceId,listStatus,const DeepCollectionEquality().hash(_items),listFailure,available,defaultBotName,routeMissing,urlInvalid,submitting,actionFailure,active,cancelling,pollFailure);
}

@override
String toString() {
    return 'MeetingBotState(workspaceId: $workspaceId, listStatus: $listStatus, items: $items, listFailure: $listFailure, available: $available, defaultBotName: $defaultBotName, routeMissing: $routeMissing, urlInvalid: $urlInvalid, submitting: $submitting, actionFailure: $actionFailure, active: $active, cancelling: $cancelling, pollFailure: $pollFailure)';
}


}

/// @nodoc
abstract mixin class _$MeetingBotStateCopyWith<$Res> implements $MeetingBotStateCopyWith<$Res> {
  factory _$MeetingBotStateCopyWith(_MeetingBotState value, $Res Function(_MeetingBotState) _then) = __$MeetingBotStateCopyWithImpl;
@override @useResult
$Res call({
 String? workspaceId, MeetingListStatus listStatus, List<MeetingBot> items, Failure? listFailure, bool available, String defaultBotName, bool routeMissing, bool urlInvalid, bool submitting, Failure? actionFailure, MeetingBot? active, bool cancelling, Failure? pollFailure
});


@override $FailureCopyWith<$Res>? get listFailure;@override $FailureCopyWith<$Res>? get actionFailure;@override $MeetingBotCopyWith<$Res>? get active;@override $FailureCopyWith<$Res>? get pollFailure;

}
/// @nodoc
class __$MeetingBotStateCopyWithImpl<$Res>
    implements _$MeetingBotStateCopyWith<$Res> {
  __$MeetingBotStateCopyWithImpl(this._self, this._then);

  final _MeetingBotState _self;
  final $Res Function(_MeetingBotState) _then;

/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workspaceId = freezed,Object? listStatus = null,Object? items = null,Object? listFailure = freezed,Object? available = null,Object? defaultBotName = null,Object? routeMissing = null,Object? urlInvalid = null,Object? submitting = null,Object? actionFailure = freezed,Object? active = freezed,Object? cancelling = null,Object? pollFailure = freezed,}) {
  return _then(_MeetingBotState(
workspaceId: freezed == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String?,listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as MeetingListStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MeetingBot>,listFailure: freezed == listFailure ? _self.listFailure : listFailure // ignore: cast_nullable_to_non_nullable
as Failure?,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,defaultBotName: null == defaultBotName ? _self.defaultBotName : defaultBotName // ignore: cast_nullable_to_non_nullable
as String,routeMissing: null == routeMissing ? _self.routeMissing : routeMissing // ignore: cast_nullable_to_non_nullable
as bool,urlInvalid: null == urlInvalid ? _self.urlInvalid : urlInvalid // ignore: cast_nullable_to_non_nullable
as bool,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as MeetingBot?,cancelling: null == cancelling ? _self.cancelling : cancelling // ignore: cast_nullable_to_non_nullable
as bool,pollFailure: freezed == pollFailure ? _self.pollFailure : pollFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get listFailure {
    if (_self.listFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.listFailure!, (value) {
    return _then(_self.copyWith(listFailure: value));
  });
}/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeetingBotCopyWith<$Res>? get active {
    if (_self.active == null) {
    return null;
  }

  return $MeetingBotCopyWith<$Res>(_self.active!, (value) {
    return _then(_self.copyWith(active: value));
  });
}/// Create a copy of MeetingBotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get pollFailure {
    if (_self.pollFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.pollFailure!, (value) {
    return _then(_self.copyWith(pollFailure: value));
  });
}
}

// dart format on
