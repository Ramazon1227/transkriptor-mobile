// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SummaryState {

 TemplatesStatus get templatesStatus; SummaryTemplateLibrary? get library; Failure? get templatesFailure;/// Null: the default template.
 SummaryTemplate? get template; SummaryStatus get status; Summary? get summary; Failure? get failure; NoteSaveStatus get noteStatus; Failure? get noteFailure;/// A star toggle failed and was undone.
 Failure? get favoriteFailure;
/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryStateCopyWith<SummaryState> get copyWith => _$SummaryStateCopyWithImpl<SummaryState>(this as SummaryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SummaryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryState&&(identical(other.templatesStatus, _this.templatesStatus) || other.templatesStatus == _this.templatesStatus)&&(identical(other.library, _this.library) || other.library == _this.library)&&(identical(other.templatesFailure, _this.templatesFailure) || other.templatesFailure == _this.templatesFailure)&&(identical(other.template, _this.template) || other.template == _this.template)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.noteStatus, _this.noteStatus) || other.noteStatus == _this.noteStatus)&&(identical(other.noteFailure, _this.noteFailure) || other.noteFailure == _this.noteFailure)&&(identical(other.favoriteFailure, _this.favoriteFailure) || other.favoriteFailure == _this.favoriteFailure));
}


@override
int get hashCode {
  final _this = this as SummaryState;
  return Object.hash(runtimeType,_this.templatesStatus,_this.library,_this.templatesFailure,_this.template,_this.status,_this.summary,_this.failure,_this.noteStatus,_this.noteFailure,_this.favoriteFailure);
}

@override
String toString() {
  final _this = this as SummaryState;
  return 'SummaryState(templatesStatus: ${_this.templatesStatus}, library: ${_this.library}, templatesFailure: ${_this.templatesFailure}, template: ${_this.template}, status: ${_this.status}, summary: ${_this.summary}, failure: ${_this.failure}, noteStatus: ${_this.noteStatus}, noteFailure: ${_this.noteFailure}, favoriteFailure: ${_this.favoriteFailure})';
}


}

/// @nodoc
abstract mixin class $SummaryStateCopyWith<$Res>  {
  factory $SummaryStateCopyWith(SummaryState value, $Res Function(SummaryState) _then) = _$SummaryStateCopyWithImpl;
@useResult
$Res call({
 TemplatesStatus templatesStatus, SummaryTemplateLibrary? library, Failure? templatesFailure, SummaryTemplate? template, SummaryStatus status, Summary? summary, Failure? failure, NoteSaveStatus noteStatus, Failure? noteFailure, Failure? favoriteFailure
});


$SummaryTemplateLibraryCopyWith<$Res>? get library;$FailureCopyWith<$Res>? get templatesFailure;$SummaryTemplateCopyWith<$Res>? get template;$SummaryCopyWith<$Res>? get summary;$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get noteFailure;$FailureCopyWith<$Res>? get favoriteFailure;

}
/// @nodoc
class _$SummaryStateCopyWithImpl<$Res>
    implements $SummaryStateCopyWith<$Res> {
  _$SummaryStateCopyWithImpl(this._self, this._then);

  final SummaryState _self;
  final $Res Function(SummaryState) _then;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? templatesStatus = null,Object? library = freezed,Object? templatesFailure = freezed,Object? template = freezed,Object? status = null,Object? summary = freezed,Object? failure = freezed,Object? noteStatus = null,Object? noteFailure = freezed,Object? favoriteFailure = freezed,}) {
  return _then(SummaryState(
templatesStatus: null == templatesStatus ? _self.templatesStatus : templatesStatus // ignore: cast_nullable_to_non_nullable
as TemplatesStatus,library: freezed == library ? _self.library : library // ignore: cast_nullable_to_non_nullable
as SummaryTemplateLibrary?,templatesFailure: freezed == templatesFailure ? _self.templatesFailure : templatesFailure // ignore: cast_nullable_to_non_nullable
as Failure?,template: freezed == template ? _self.template : template // ignore: cast_nullable_to_non_nullable
as SummaryTemplate?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SummaryStatus,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Summary?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,noteStatus: null == noteStatus ? _self.noteStatus : noteStatus // ignore: cast_nullable_to_non_nullable
as NoteSaveStatus,noteFailure: freezed == noteFailure ? _self.noteFailure : noteFailure // ignore: cast_nullable_to_non_nullable
as Failure?,favoriteFailure: freezed == favoriteFailure ? _self.favoriteFailure : favoriteFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryTemplateLibraryCopyWith<$Res>? get library {
    if (_self.library == null) {
    return null;
  }

  return $SummaryTemplateLibraryCopyWith<$Res>(_self.library!, (value) {
    return _then(_self.copyWith(library: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get templatesFailure {
    if (_self.templatesFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.templatesFailure!, (value) {
    return _then(_self.copyWith(templatesFailure: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryTemplateCopyWith<$Res>? get template {
    if (_self.template == null) {
    return null;
  }

  return $SummaryTemplateCopyWith<$Res>(_self.template!, (value) {
    return _then(_self.copyWith(template: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $SummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of SummaryState
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
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get noteFailure {
    if (_self.noteFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.noteFailure!, (value) {
    return _then(_self.copyWith(noteFailure: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get favoriteFailure {
    if (_self.favoriteFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.favoriteFailure!, (value) {
    return _then(_self.copyWith(favoriteFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [SummaryState].
extension SummaryStatePatterns on SummaryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryState value)  $default,){
final _that = this;
switch (_that) {
case _SummaryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryState value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TemplatesStatus templatesStatus,  SummaryTemplateLibrary? library,  Failure? templatesFailure,  SummaryTemplate? template,  SummaryStatus status,  Summary? summary,  Failure? failure,  NoteSaveStatus noteStatus,  Failure? noteFailure,  Failure? favoriteFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryState() when $default != null:
return $default(_that.templatesStatus,_that.library,_that.templatesFailure,_that.template,_that.status,_that.summary,_that.failure,_that.noteStatus,_that.noteFailure,_that.favoriteFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TemplatesStatus templatesStatus,  SummaryTemplateLibrary? library,  Failure? templatesFailure,  SummaryTemplate? template,  SummaryStatus status,  Summary? summary,  Failure? failure,  NoteSaveStatus noteStatus,  Failure? noteFailure,  Failure? favoriteFailure)  $default,) {final _that = this;
switch (_that) {
case _SummaryState():
return $default(_that.templatesStatus,_that.library,_that.templatesFailure,_that.template,_that.status,_that.summary,_that.failure,_that.noteStatus,_that.noteFailure,_that.favoriteFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TemplatesStatus templatesStatus,  SummaryTemplateLibrary? library,  Failure? templatesFailure,  SummaryTemplate? template,  SummaryStatus status,  Summary? summary,  Failure? failure,  NoteSaveStatus noteStatus,  Failure? noteFailure,  Failure? favoriteFailure)?  $default,) {final _that = this;
switch (_that) {
case _SummaryState() when $default != null:
return $default(_that.templatesStatus,_that.library,_that.templatesFailure,_that.template,_that.status,_that.summary,_that.failure,_that.noteStatus,_that.noteFailure,_that.favoriteFailure);case _:
  return null;

}
}

}

/// @nodoc


class _SummaryState implements SummaryState {
  const _SummaryState({this.templatesStatus = TemplatesStatus.initial, this.library, this.templatesFailure, this.template, this.status = SummaryStatus.idle, this.summary, this.failure, this.noteStatus = NoteSaveStatus.idle, this.noteFailure, this.favoriteFailure});
  

@override@JsonKey() final  TemplatesStatus templatesStatus;
@override final  SummaryTemplateLibrary? library;
@override final  Failure? templatesFailure;
/// Null: the default template.
@override final  SummaryTemplate? template;
@override@JsonKey() final  SummaryStatus status;
@override final  Summary? summary;
@override final  Failure? failure;
@override@JsonKey() final  NoteSaveStatus noteStatus;
@override final  Failure? noteFailure;
/// A star toggle failed and was undone.
@override final  Failure? favoriteFailure;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryStateCopyWith<_SummaryState> get copyWith => __$SummaryStateCopyWithImpl<_SummaryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryState&&(identical(other.templatesStatus, templatesStatus) || other.templatesStatus == templatesStatus)&&(identical(other.library, library) || other.library == library)&&(identical(other.templatesFailure, templatesFailure) || other.templatesFailure == templatesFailure)&&(identical(other.template, template) || other.template == template)&&(identical(other.status, status) || other.status == status)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.noteStatus, noteStatus) || other.noteStatus == noteStatus)&&(identical(other.noteFailure, noteFailure) || other.noteFailure == noteFailure)&&(identical(other.favoriteFailure, favoriteFailure) || other.favoriteFailure == favoriteFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,templatesStatus,library,templatesFailure,template,status,summary,failure,noteStatus,noteFailure,favoriteFailure);
}

@override
String toString() {
    return 'SummaryState(templatesStatus: $templatesStatus, library: $library, templatesFailure: $templatesFailure, template: $template, status: $status, summary: $summary, failure: $failure, noteStatus: $noteStatus, noteFailure: $noteFailure, favoriteFailure: $favoriteFailure)';
}


}

/// @nodoc
abstract mixin class _$SummaryStateCopyWith<$Res> implements $SummaryStateCopyWith<$Res> {
  factory _$SummaryStateCopyWith(_SummaryState value, $Res Function(_SummaryState) _then) = __$SummaryStateCopyWithImpl;
@override @useResult
$Res call({
 TemplatesStatus templatesStatus, SummaryTemplateLibrary? library, Failure? templatesFailure, SummaryTemplate? template, SummaryStatus status, Summary? summary, Failure? failure, NoteSaveStatus noteStatus, Failure? noteFailure, Failure? favoriteFailure
});


@override $SummaryTemplateLibraryCopyWith<$Res>? get library;@override $FailureCopyWith<$Res>? get templatesFailure;@override $SummaryTemplateCopyWith<$Res>? get template;@override $SummaryCopyWith<$Res>? get summary;@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get noteFailure;@override $FailureCopyWith<$Res>? get favoriteFailure;

}
/// @nodoc
class __$SummaryStateCopyWithImpl<$Res>
    implements _$SummaryStateCopyWith<$Res> {
  __$SummaryStateCopyWithImpl(this._self, this._then);

  final _SummaryState _self;
  final $Res Function(_SummaryState) _then;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? templatesStatus = null,Object? library = freezed,Object? templatesFailure = freezed,Object? template = freezed,Object? status = null,Object? summary = freezed,Object? failure = freezed,Object? noteStatus = null,Object? noteFailure = freezed,Object? favoriteFailure = freezed,}) {
  return _then(_SummaryState(
templatesStatus: null == templatesStatus ? _self.templatesStatus : templatesStatus // ignore: cast_nullable_to_non_nullable
as TemplatesStatus,library: freezed == library ? _self.library : library // ignore: cast_nullable_to_non_nullable
as SummaryTemplateLibrary?,templatesFailure: freezed == templatesFailure ? _self.templatesFailure : templatesFailure // ignore: cast_nullable_to_non_nullable
as Failure?,template: freezed == template ? _self.template : template // ignore: cast_nullable_to_non_nullable
as SummaryTemplate?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SummaryStatus,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Summary?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,noteStatus: null == noteStatus ? _self.noteStatus : noteStatus // ignore: cast_nullable_to_non_nullable
as NoteSaveStatus,noteFailure: freezed == noteFailure ? _self.noteFailure : noteFailure // ignore: cast_nullable_to_non_nullable
as Failure?,favoriteFailure: freezed == favoriteFailure ? _self.favoriteFailure : favoriteFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryTemplateLibraryCopyWith<$Res>? get library {
    if (_self.library == null) {
    return null;
  }

  return $SummaryTemplateLibraryCopyWith<$Res>(_self.library!, (value) {
    return _then(_self.copyWith(library: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get templatesFailure {
    if (_self.templatesFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.templatesFailure!, (value) {
    return _then(_self.copyWith(templatesFailure: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryTemplateCopyWith<$Res>? get template {
    if (_self.template == null) {
    return null;
  }

  return $SummaryTemplateCopyWith<$Res>(_self.template!, (value) {
    return _then(_self.copyWith(template: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $SummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of SummaryState
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
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get noteFailure {
    if (_self.noteFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.noteFailure!, (value) {
    return _then(_self.copyWith(noteFailure: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get favoriteFailure {
    if (_self.favoriteFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.favoriteFailure!, (value) {
    return _then(_self.copyWith(favoriteFailure: value));
  });
}
}

// dart format on
