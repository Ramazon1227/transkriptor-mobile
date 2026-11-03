// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_queue_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueItem {

 PendingFile get file; QueueItemStatus get status;/// 0–1, bytes sent of this file.
 double get progress; String? get mediaId; Failure? get failure;
/// Create a copy of QueueItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueItemCopyWith<QueueItem> get copyWith => _$QueueItemCopyWithImpl<QueueItem>(this as QueueItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QueueItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueItem&&(identical(other.file, _this.file) || other.file == _this.file)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as QueueItem;
  return Object.hash(runtimeType,_this.file,_this.status,_this.progress,_this.mediaId,_this.failure);
}

@override
String toString() {
  final _this = this as QueueItem;
  return 'QueueItem(file: ${_this.file}, status: ${_this.status}, progress: ${_this.progress}, mediaId: ${_this.mediaId}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $QueueItemCopyWith<$Res>  {
  factory $QueueItemCopyWith(QueueItem value, $Res Function(QueueItem) _then) = _$QueueItemCopyWithImpl;
@useResult
$Res call({
 PendingFile file, QueueItemStatus status, double progress, String? mediaId, Failure? failure
});


$PendingFileCopyWith<$Res> get file;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$QueueItemCopyWithImpl<$Res>
    implements $QueueItemCopyWith<$Res> {
  _$QueueItemCopyWithImpl(this._self, this._then);

  final QueueItem _self;
  final $Res Function(QueueItem) _then;

/// Create a copy of QueueItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? file = null,Object? status = null,Object? progress = null,Object? mediaId = freezed,Object? failure = freezed,}) {
  return _then(QueueItem(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as PendingFile,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueueItemStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,mediaId: freezed == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of QueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingFileCopyWith<$Res> get file {
  
  return $PendingFileCopyWith<$Res>(_self.file, (value) {
    return _then(_self.copyWith(file: value));
  });
}/// Create a copy of QueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueueItem].
extension QueueItemPatterns on QueueItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueItem value)  $default,){
final _that = this;
switch (_that) {
case _QueueItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueItem value)?  $default,){
final _that = this;
switch (_that) {
case _QueueItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PendingFile file,  QueueItemStatus status,  double progress,  String? mediaId,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueItem() when $default != null:
return $default(_that.file,_that.status,_that.progress,_that.mediaId,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PendingFile file,  QueueItemStatus status,  double progress,  String? mediaId,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _QueueItem():
return $default(_that.file,_that.status,_that.progress,_that.mediaId,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PendingFile file,  QueueItemStatus status,  double progress,  String? mediaId,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _QueueItem() when $default != null:
return $default(_that.file,_that.status,_that.progress,_that.mediaId,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _QueueItem implements QueueItem {
  const _QueueItem({required this.file, this.status = QueueItemStatus.waiting, this.progress = 0, this.mediaId, this.failure});
  

@override final  PendingFile file;
@override@JsonKey() final  QueueItemStatus status;
/// 0–1, bytes sent of this file.
@override@JsonKey() final  double progress;
@override final  String? mediaId;
@override final  Failure? failure;

/// Create a copy of QueueItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueItemCopyWith<_QueueItem> get copyWith => __$QueueItemCopyWithImpl<_QueueItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueItem&&(identical(other.file, file) || other.file == file)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,file,status,progress,mediaId,failure);
}

@override
String toString() {
    return 'QueueItem(file: $file, status: $status, progress: $progress, mediaId: $mediaId, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$QueueItemCopyWith<$Res> implements $QueueItemCopyWith<$Res> {
  factory _$QueueItemCopyWith(_QueueItem value, $Res Function(_QueueItem) _then) = __$QueueItemCopyWithImpl;
@override @useResult
$Res call({
 PendingFile file, QueueItemStatus status, double progress, String? mediaId, Failure? failure
});


@override $PendingFileCopyWith<$Res> get file;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$QueueItemCopyWithImpl<$Res>
    implements _$QueueItemCopyWith<$Res> {
  __$QueueItemCopyWithImpl(this._self, this._then);

  final _QueueItem _self;
  final $Res Function(_QueueItem) _then;

/// Create a copy of QueueItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file = null,Object? status = null,Object? progress = null,Object? mediaId = freezed,Object? failure = freezed,}) {
  return _then(_QueueItem(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as PendingFile,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueueItemStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,mediaId: freezed == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of QueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingFileCopyWith<$Res> get file {
  
  return $PendingFileCopyWith<$Res>(_self.file, (value) {
    return _then(_self.copyWith(file: value));
  });
}/// Create a copy of QueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc
mixin _$UploadQueueState {

 List<QueueItem> get items;/// Uploading the list. Nothing is added while it runs; leaving the
/// page asks first and cancels what is still uploading.
 bool get running; Failure? get pickFailure;
/// Create a copy of UploadQueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadQueueStateCopyWith<UploadQueueState> get copyWith => _$UploadQueueStateCopyWithImpl<UploadQueueState>(this as UploadQueueState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UploadQueueState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadQueueState&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.running, _this.running) || other.running == _this.running)&&(identical(other.pickFailure, _this.pickFailure) || other.pickFailure == _this.pickFailure));
}


@override
int get hashCode {
  final _this = this as UploadQueueState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.running,_this.pickFailure);
}

@override
String toString() {
  final _this = this as UploadQueueState;
  return 'UploadQueueState(items: ${_this.items}, running: ${_this.running}, pickFailure: ${_this.pickFailure})';
}


}

/// @nodoc
abstract mixin class $UploadQueueStateCopyWith<$Res>  {
  factory $UploadQueueStateCopyWith(UploadQueueState value, $Res Function(UploadQueueState) _then) = _$UploadQueueStateCopyWithImpl;
@useResult
$Res call({
 List<QueueItem> items, bool running, Failure? pickFailure
});


$FailureCopyWith<$Res>? get pickFailure;

}
/// @nodoc
class _$UploadQueueStateCopyWithImpl<$Res>
    implements $UploadQueueStateCopyWith<$Res> {
  _$UploadQueueStateCopyWithImpl(this._self, this._then);

  final UploadQueueState _self;
  final $Res Function(UploadQueueState) _then;

/// Create a copy of UploadQueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? running = null,Object? pickFailure = freezed,}) {
  return _then(UploadQueueState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<QueueItem>,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,pickFailure: freezed == pickFailure ? _self.pickFailure : pickFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of UploadQueueState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get pickFailure {
    if (_self.pickFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.pickFailure!, (value) {
    return _then(_self.copyWith(pickFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [UploadQueueState].
extension UploadQueueStatePatterns on UploadQueueState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadQueueState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadQueueState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadQueueState value)  $default,){
final _that = this;
switch (_that) {
case _UploadQueueState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadQueueState value)?  $default,){
final _that = this;
switch (_that) {
case _UploadQueueState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<QueueItem> items,  bool running,  Failure? pickFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadQueueState() when $default != null:
return $default(_that.items,_that.running,_that.pickFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<QueueItem> items,  bool running,  Failure? pickFailure)  $default,) {final _that = this;
switch (_that) {
case _UploadQueueState():
return $default(_that.items,_that.running,_that.pickFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<QueueItem> items,  bool running,  Failure? pickFailure)?  $default,) {final _that = this;
switch (_that) {
case _UploadQueueState() when $default != null:
return $default(_that.items,_that.running,_that.pickFailure);case _:
  return null;

}
}

}

/// @nodoc


class _UploadQueueState extends UploadQueueState {
  const _UploadQueueState({ List<QueueItem> items = const <QueueItem>[], this.running = false, this.pickFailure}): _items = items,super._();
  

 final  List<QueueItem> _items;
@override@JsonKey() List<QueueItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Uploading the list. Nothing is added while it runs; leaving the
/// page asks first and cancels what is still uploading.
@override@JsonKey() final  bool running;
@override final  Failure? pickFailure;

/// Create a copy of UploadQueueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadQueueStateCopyWith<_UploadQueueState> get copyWith => __$UploadQueueStateCopyWithImpl<_UploadQueueState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadQueueState&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.running, running) || other.running == running)&&(identical(other.pickFailure, pickFailure) || other.pickFailure == pickFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),running,pickFailure);
}

@override
String toString() {
    return 'UploadQueueState(items: $items, running: $running, pickFailure: $pickFailure)';
}


}

/// @nodoc
abstract mixin class _$UploadQueueStateCopyWith<$Res> implements $UploadQueueStateCopyWith<$Res> {
  factory _$UploadQueueStateCopyWith(_UploadQueueState value, $Res Function(_UploadQueueState) _then) = __$UploadQueueStateCopyWithImpl;
@override @useResult
$Res call({
 List<QueueItem> items, bool running, Failure? pickFailure
});


@override $FailureCopyWith<$Res>? get pickFailure;

}
/// @nodoc
class __$UploadQueueStateCopyWithImpl<$Res>
    implements _$UploadQueueStateCopyWith<$Res> {
  __$UploadQueueStateCopyWithImpl(this._self, this._then);

  final _UploadQueueState _self;
  final $Res Function(_UploadQueueState) _then;

/// Create a copy of UploadQueueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? running = null,Object? pickFailure = freezed,}) {
  return _then(_UploadQueueState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<QueueItem>,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,pickFailure: freezed == pickFailure ? _self.pickFailure : pickFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of UploadQueueState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get pickFailure {
    if (_self.pickFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.pickFailure!, (value) {
    return _then(_self.copyWith(pickFailure: value));
  });
}
}

// dart format on
