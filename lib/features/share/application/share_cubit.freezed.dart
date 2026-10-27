// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShareState {

 ShareListStatus get listStatus; List<ShareLink> get links; Failure? get listFailure; ShareActionStatus get actionStatus; Failure? get actionFailure;/// The link just created, with its URL. Shown once: closing the sheet
/// loses it, and the server cannot show it again.
 ShareLink? get created; bool get includeMedia; int get expiresDays;
/// Create a copy of ShareState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareStateCopyWith<ShareState> get copyWith => _$ShareStateCopyWithImpl<ShareState>(this as ShareState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ShareState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareState&&(identical(other.listStatus, _this.listStatus) || other.listStatus == _this.listStatus)&&const DeepCollectionEquality().equals(other.links, _this.links)&&(identical(other.listFailure, _this.listFailure) || other.listFailure == _this.listFailure)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionFailure, _this.actionFailure) || other.actionFailure == _this.actionFailure)&&(identical(other.created, _this.created) || other.created == _this.created)&&(identical(other.includeMedia, _this.includeMedia) || other.includeMedia == _this.includeMedia)&&(identical(other.expiresDays, _this.expiresDays) || other.expiresDays == _this.expiresDays));
}


@override
int get hashCode {
  final _this = this as ShareState;
  return Object.hash(runtimeType,_this.listStatus,const DeepCollectionEquality().hash(_this.links),_this.listFailure,_this.actionStatus,_this.actionFailure,_this.created,_this.includeMedia,_this.expiresDays);
}

@override
String toString() {
  final _this = this as ShareState;
  return 'ShareState(listStatus: ${_this.listStatus}, links: ${_this.links}, listFailure: ${_this.listFailure}, actionStatus: ${_this.actionStatus}, actionFailure: ${_this.actionFailure}, created: ${_this.created}, includeMedia: ${_this.includeMedia}, expiresDays: ${_this.expiresDays})';
}


}

/// @nodoc
abstract mixin class $ShareStateCopyWith<$Res>  {
  factory $ShareStateCopyWith(ShareState value, $Res Function(ShareState) _then) = _$ShareStateCopyWithImpl;
@useResult
$Res call({
 ShareListStatus listStatus, List<ShareLink> links, Failure? listFailure, ShareActionStatus actionStatus, Failure? actionFailure, ShareLink? created, bool includeMedia, int expiresDays
});


$FailureCopyWith<$Res>? get listFailure;$FailureCopyWith<$Res>? get actionFailure;$ShareLinkCopyWith<$Res>? get created;

}
/// @nodoc
class _$ShareStateCopyWithImpl<$Res>
    implements $ShareStateCopyWith<$Res> {
  _$ShareStateCopyWithImpl(this._self, this._then);

  final ShareState _self;
  final $Res Function(ShareState) _then;

/// Create a copy of ShareState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listStatus = null,Object? links = null,Object? listFailure = freezed,Object? actionStatus = null,Object? actionFailure = freezed,Object? created = freezed,Object? includeMedia = null,Object? expiresDays = null,}) {
  return _then(ShareState(
listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as ShareListStatus,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as List<ShareLink>,listFailure: freezed == listFailure ? _self.listFailure : listFailure // ignore: cast_nullable_to_non_nullable
as Failure?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as ShareActionStatus,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as ShareLink?,includeMedia: null == includeMedia ? _self.includeMedia : includeMedia // ignore: cast_nullable_to_non_nullable
as bool,expiresDays: null == expiresDays ? _self.expiresDays : expiresDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ShareState
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
}/// Create a copy of ShareState
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
}/// Create a copy of ShareState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShareLinkCopyWith<$Res>? get created {
    if (_self.created == null) {
    return null;
  }

  return $ShareLinkCopyWith<$Res>(_self.created!, (value) {
    return _then(_self.copyWith(created: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShareState].
extension ShareStatePatterns on ShareState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareState value)  $default,){
final _that = this;
switch (_that) {
case _ShareState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareState value)?  $default,){
final _that = this;
switch (_that) {
case _ShareState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ShareListStatus listStatus,  List<ShareLink> links,  Failure? listFailure,  ShareActionStatus actionStatus,  Failure? actionFailure,  ShareLink? created,  bool includeMedia,  int expiresDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareState() when $default != null:
return $default(_that.listStatus,_that.links,_that.listFailure,_that.actionStatus,_that.actionFailure,_that.created,_that.includeMedia,_that.expiresDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ShareListStatus listStatus,  List<ShareLink> links,  Failure? listFailure,  ShareActionStatus actionStatus,  Failure? actionFailure,  ShareLink? created,  bool includeMedia,  int expiresDays)  $default,) {final _that = this;
switch (_that) {
case _ShareState():
return $default(_that.listStatus,_that.links,_that.listFailure,_that.actionStatus,_that.actionFailure,_that.created,_that.includeMedia,_that.expiresDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ShareListStatus listStatus,  List<ShareLink> links,  Failure? listFailure,  ShareActionStatus actionStatus,  Failure? actionFailure,  ShareLink? created,  bool includeMedia,  int expiresDays)?  $default,) {final _that = this;
switch (_that) {
case _ShareState() when $default != null:
return $default(_that.listStatus,_that.links,_that.listFailure,_that.actionStatus,_that.actionFailure,_that.created,_that.includeMedia,_that.expiresDays);case _:
  return null;

}
}

}

/// @nodoc


class _ShareState implements ShareState {
  const _ShareState({this.listStatus = ShareListStatus.initial,  List<ShareLink> links = const <ShareLink>[], this.listFailure, this.actionStatus = ShareActionStatus.idle, this.actionFailure, this.created, this.includeMedia = true, this.expiresDays = 30}): _links = links;
  

@override@JsonKey() final  ShareListStatus listStatus;
 final  List<ShareLink> _links;
@override@JsonKey() List<ShareLink> get links {
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_links);
}

@override final  Failure? listFailure;
@override@JsonKey() final  ShareActionStatus actionStatus;
@override final  Failure? actionFailure;
/// The link just created, with its URL. Shown once: closing the sheet
/// loses it, and the server cannot show it again.
@override final  ShareLink? created;
@override@JsonKey() final  bool includeMedia;
@override@JsonKey() final  int expiresDays;

/// Create a copy of ShareState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareStateCopyWith<_ShareState> get copyWith => __$ShareStateCopyWithImpl<_ShareState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareState&&(identical(other.listStatus, listStatus) || other.listStatus == listStatus)&&const DeepCollectionEquality().equals(other.links, _links)&&(identical(other.listFailure, listFailure) || other.listFailure == listFailure)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure)&&(identical(other.created, created) || other.created == created)&&(identical(other.includeMedia, includeMedia) || other.includeMedia == includeMedia)&&(identical(other.expiresDays, expiresDays) || other.expiresDays == expiresDays));
}


@override
int get hashCode {
    return Object.hash(runtimeType,listStatus,const DeepCollectionEquality().hash(_links),listFailure,actionStatus,actionFailure,created,includeMedia,expiresDays);
}

@override
String toString() {
    return 'ShareState(listStatus: $listStatus, links: $links, listFailure: $listFailure, actionStatus: $actionStatus, actionFailure: $actionFailure, created: $created, includeMedia: $includeMedia, expiresDays: $expiresDays)';
}


}

/// @nodoc
abstract mixin class _$ShareStateCopyWith<$Res> implements $ShareStateCopyWith<$Res> {
  factory _$ShareStateCopyWith(_ShareState value, $Res Function(_ShareState) _then) = __$ShareStateCopyWithImpl;
@override @useResult
$Res call({
 ShareListStatus listStatus, List<ShareLink> links, Failure? listFailure, ShareActionStatus actionStatus, Failure? actionFailure, ShareLink? created, bool includeMedia, int expiresDays
});


@override $FailureCopyWith<$Res>? get listFailure;@override $FailureCopyWith<$Res>? get actionFailure;@override $ShareLinkCopyWith<$Res>? get created;

}
/// @nodoc
class __$ShareStateCopyWithImpl<$Res>
    implements _$ShareStateCopyWith<$Res> {
  __$ShareStateCopyWithImpl(this._self, this._then);

  final _ShareState _self;
  final $Res Function(_ShareState) _then;

/// Create a copy of ShareState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listStatus = null,Object? links = null,Object? listFailure = freezed,Object? actionStatus = null,Object? actionFailure = freezed,Object? created = freezed,Object? includeMedia = null,Object? expiresDays = null,}) {
  return _then(_ShareState(
listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as ShareListStatus,links: null == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<ShareLink>,listFailure: freezed == listFailure ? _self.listFailure : listFailure // ignore: cast_nullable_to_non_nullable
as Failure?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as ShareActionStatus,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as ShareLink?,includeMedia: null == includeMedia ? _self.includeMedia : includeMedia // ignore: cast_nullable_to_non_nullable
as bool,expiresDays: null == expiresDays ? _self.expiresDays : expiresDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ShareState
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
}/// Create a copy of ShareState
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
}/// Create a copy of ShareState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShareLinkCopyWith<$Res>? get created {
    if (_self.created == null) {
    return null;
  }

  return $ShareLinkCopyWith<$Res>(_self.created!, (value) {
    return _then(_self.copyWith(created: value));
  });
}
}

// dart format on
