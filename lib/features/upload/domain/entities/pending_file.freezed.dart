// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PendingFile {

 String get path;/// With its extension; the backend reads the type from it.
 String get fileName; int get sizeBytes; UploadSource get source;/// Known for recordings; for a picked file the server measures it.
 Duration? get duration;
/// Create a copy of PendingFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingFileCopyWith<PendingFile> get copyWith => _$PendingFileCopyWithImpl<PendingFile>(this as PendingFile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PendingFile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingFile&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.fileName, _this.fileName) || other.fileName == _this.fileName)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.duration, _this.duration) || other.duration == _this.duration));
}


@override
int get hashCode {
  final _this = this as PendingFile;
  return Object.hash(runtimeType,_this.path,_this.fileName,_this.sizeBytes,_this.source,_this.duration);
}

@override
String toString() {
  final _this = this as PendingFile;
  return 'PendingFile(path: ${_this.path}, fileName: ${_this.fileName}, sizeBytes: ${_this.sizeBytes}, source: ${_this.source}, duration: ${_this.duration})';
}


}

/// @nodoc
abstract mixin class $PendingFileCopyWith<$Res>  {
  factory $PendingFileCopyWith(PendingFile value, $Res Function(PendingFile) _then) = _$PendingFileCopyWithImpl;
@useResult
$Res call({
 String path, String fileName, int sizeBytes, UploadSource source, Duration? duration
});




}
/// @nodoc
class _$PendingFileCopyWithImpl<$Res>
    implements $PendingFileCopyWith<$Res> {
  _$PendingFileCopyWithImpl(this._self, this._then);

  final PendingFile _self;
  final $Res Function(PendingFile) _then;

/// Create a copy of PendingFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? fileName = null,Object? sizeBytes = null,Object? source = null,Object? duration = freezed,}) {
  return _then(PendingFile(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as UploadSource,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingFile].
extension PendingFilePatterns on PendingFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingFile value)  $default,){
final _that = this;
switch (_that) {
case _PendingFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingFile value)?  $default,){
final _that = this;
switch (_that) {
case _PendingFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String fileName,  int sizeBytes,  UploadSource source,  Duration? duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingFile() when $default != null:
return $default(_that.path,_that.fileName,_that.sizeBytes,_that.source,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String fileName,  int sizeBytes,  UploadSource source,  Duration? duration)  $default,) {final _that = this;
switch (_that) {
case _PendingFile():
return $default(_that.path,_that.fileName,_that.sizeBytes,_that.source,_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String fileName,  int sizeBytes,  UploadSource source,  Duration? duration)?  $default,) {final _that = this;
switch (_that) {
case _PendingFile() when $default != null:
return $default(_that.path,_that.fileName,_that.sizeBytes,_that.source,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class _PendingFile extends PendingFile {
  const _PendingFile({required this.path, required this.fileName, required this.sizeBytes, required this.source, this.duration}): super._();
  

@override final  String path;
/// With its extension; the backend reads the type from it.
@override final  String fileName;
@override final  int sizeBytes;
@override final  UploadSource source;
/// Known for recordings; for a picked file the server measures it.
@override final  Duration? duration;

/// Create a copy of PendingFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingFileCopyWith<_PendingFile> get copyWith => __$PendingFileCopyWithImpl<_PendingFile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingFile&&(identical(other.path, path) || other.path == path)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.source, source) || other.source == source)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode {
    return Object.hash(runtimeType,path,fileName,sizeBytes,source,duration);
}

@override
String toString() {
    return 'PendingFile(path: $path, fileName: $fileName, sizeBytes: $sizeBytes, source: $source, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$PendingFileCopyWith<$Res> implements $PendingFileCopyWith<$Res> {
  factory _$PendingFileCopyWith(_PendingFile value, $Res Function(_PendingFile) _then) = __$PendingFileCopyWithImpl;
@override @useResult
$Res call({
 String path, String fileName, int sizeBytes, UploadSource source, Duration? duration
});




}
/// @nodoc
class __$PendingFileCopyWithImpl<$Res>
    implements _$PendingFileCopyWith<$Res> {
  __$PendingFileCopyWithImpl(this._self, this._then);

  final _PendingFile _self;
  final $Res Function(_PendingFile) _then;

/// Create a copy of PendingFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? fileName = null,Object? sizeBytes = null,Object? source = null,Object? duration = freezed,}) {
  return _then(_PendingFile(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as UploadSource,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

/// @nodoc
mixin _$UploadResult {

 String get mediaId; Job? get job;/// The file is stored but the job did not start (no minutes, a
/// limit, no network). Retry starts the job only.
 Failure? get startFailure;
/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadResultCopyWith<UploadResult> get copyWith => _$UploadResultCopyWithImpl<UploadResult>(this as UploadResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UploadResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadResult&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.job, _this.job) || other.job == _this.job)&&(identical(other.startFailure, _this.startFailure) || other.startFailure == _this.startFailure));
}


@override
int get hashCode {
  final _this = this as UploadResult;
  return Object.hash(runtimeType,_this.mediaId,_this.job,_this.startFailure);
}

@override
String toString() {
  final _this = this as UploadResult;
  return 'UploadResult(mediaId: ${_this.mediaId}, job: ${_this.job}, startFailure: ${_this.startFailure})';
}


}

/// @nodoc
abstract mixin class $UploadResultCopyWith<$Res>  {
  factory $UploadResultCopyWith(UploadResult value, $Res Function(UploadResult) _then) = _$UploadResultCopyWithImpl;
@useResult
$Res call({
 String mediaId, Job? job, Failure? startFailure
});


$JobCopyWith<$Res>? get job;$FailureCopyWith<$Res>? get startFailure;

}
/// @nodoc
class _$UploadResultCopyWithImpl<$Res>
    implements $UploadResultCopyWith<$Res> {
  _$UploadResultCopyWithImpl(this._self, this._then);

  final UploadResult _self;
  final $Res Function(UploadResult) _then;

/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaId = null,Object? job = freezed,Object? startFailure = freezed,}) {
  return _then(UploadResult(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job?,startFailure: freezed == startFailure ? _self.startFailure : startFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get startFailure {
    if (_self.startFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.startFailure!, (value) {
    return _then(_self.copyWith(startFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [UploadResult].
extension UploadResultPatterns on UploadResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadResult value)  $default,){
final _that = this;
switch (_that) {
case _UploadResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadResult value)?  $default,){
final _that = this;
switch (_that) {
case _UploadResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mediaId,  Job? job,  Failure? startFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadResult() when $default != null:
return $default(_that.mediaId,_that.job,_that.startFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mediaId,  Job? job,  Failure? startFailure)  $default,) {final _that = this;
switch (_that) {
case _UploadResult():
return $default(_that.mediaId,_that.job,_that.startFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mediaId,  Job? job,  Failure? startFailure)?  $default,) {final _that = this;
switch (_that) {
case _UploadResult() when $default != null:
return $default(_that.mediaId,_that.job,_that.startFailure);case _:
  return null;

}
}

}

/// @nodoc


class _UploadResult implements UploadResult {
  const _UploadResult({required this.mediaId, this.job, this.startFailure});
  

@override final  String mediaId;
@override final  Job? job;
/// The file is stored but the job did not start (no minutes, a
/// limit, no network). Retry starts the job only.
@override final  Failure? startFailure;

/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadResultCopyWith<_UploadResult> get copyWith => __$UploadResultCopyWithImpl<_UploadResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadResult&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.job, job) || other.job == job)&&(identical(other.startFailure, startFailure) || other.startFailure == startFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mediaId,job,startFailure);
}

@override
String toString() {
    return 'UploadResult(mediaId: $mediaId, job: $job, startFailure: $startFailure)';
}


}

/// @nodoc
abstract mixin class _$UploadResultCopyWith<$Res> implements $UploadResultCopyWith<$Res> {
  factory _$UploadResultCopyWith(_UploadResult value, $Res Function(_UploadResult) _then) = __$UploadResultCopyWithImpl;
@override @useResult
$Res call({
 String mediaId, Job? job, Failure? startFailure
});


@override $JobCopyWith<$Res>? get job;@override $FailureCopyWith<$Res>? get startFailure;

}
/// @nodoc
class __$UploadResultCopyWithImpl<$Res>
    implements _$UploadResultCopyWith<$Res> {
  __$UploadResultCopyWithImpl(this._self, this._then);

  final _UploadResult _self;
  final $Res Function(_UploadResult) _then;

/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaId = null,Object? job = freezed,Object? startFailure = freezed,}) {
  return _then(_UploadResult(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job?,startFailure: freezed == startFailure ? _self.startFailure : startFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get startFailure {
    if (_self.startFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.startFailure!, (value) {
    return _then(_self.copyWith(startFailure: value));
  });
}
}

// dart format on
