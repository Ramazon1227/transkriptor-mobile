// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'url_import_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UrlImportResult {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UrlImportResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UrlImportResult()';
}


}

/// @nodoc
class $UrlImportResultCopyWith<$Res>  {
$UrlImportResultCopyWith(UrlImportResult _, $Res Function(UrlImportResult) __);
}


/// Adds pattern-matching-related methods to [UrlImportResult].
extension UrlImportResultPatterns on UrlImportResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UrlImportStarted value)?  started,TResult Function( UrlImportNotAvailable value)?  notAvailable,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UrlImportStarted() when started != null:
return started(_that);case UrlImportNotAvailable() when notAvailable != null:
return notAvailable(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UrlImportStarted value)  started,required TResult Function( UrlImportNotAvailable value)  notAvailable,}){
final _that = this;
switch (_that) {
case UrlImportStarted():
return started(_that);case UrlImportNotAvailable():
return notAvailable(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UrlImportStarted value)?  started,TResult? Function( UrlImportNotAvailable value)?  notAvailable,}){
final _that = this;
switch (_that) {
case UrlImportStarted() when started != null:
return started(_that);case UrlImportNotAvailable() when notAvailable != null:
return notAvailable(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String jobId)?  started,TResult Function()?  notAvailable,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UrlImportStarted() when started != null:
return started(_that.jobId);case UrlImportNotAvailable() when notAvailable != null:
return notAvailable();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String jobId)  started,required TResult Function()  notAvailable,}) {final _that = this;
switch (_that) {
case UrlImportStarted():
return started(_that.jobId);case UrlImportNotAvailable():
return notAvailable();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String jobId)?  started,TResult? Function()?  notAvailable,}) {final _that = this;
switch (_that) {
case UrlImportStarted() when started != null:
return started(_that.jobId);case UrlImportNotAvailable() when notAvailable != null:
return notAvailable();case _:
  return null;

}
}

}

/// @nodoc


class UrlImportStarted implements UrlImportResult {
  const UrlImportStarted({required this.jobId});
  

 final  String jobId;

/// Create a copy of UrlImportResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UrlImportStartedCopyWith<UrlImportStarted> get copyWith => _$UrlImportStartedCopyWithImpl<UrlImportStarted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UrlImportStarted&&(identical(other.jobId, jobId) || other.jobId == jobId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,jobId);
}

@override
String toString() {
    return 'UrlImportResult.started(jobId: $jobId)';
}


}

/// @nodoc
abstract mixin class $UrlImportStartedCopyWith<$Res> implements $UrlImportResultCopyWith<$Res> {
  factory $UrlImportStartedCopyWith(UrlImportStarted value, $Res Function(UrlImportStarted) _then) = _$UrlImportStartedCopyWithImpl;
@useResult
$Res call({
 String jobId
});




}
/// @nodoc
class _$UrlImportStartedCopyWithImpl<$Res>
    implements $UrlImportStartedCopyWith<$Res> {
  _$UrlImportStartedCopyWithImpl(this._self, this._then);

  final UrlImportStarted _self;
  final $Res Function(UrlImportStarted) _then;

/// Create a copy of UrlImportResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? jobId = null,}) {
  return _then(UrlImportStarted(
jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UrlImportNotAvailable implements UrlImportResult {
  const UrlImportNotAvailable();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UrlImportNotAvailable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UrlImportResult.notAvailable()';
}


}




// dart format on
