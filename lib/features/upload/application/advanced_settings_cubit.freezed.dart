// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advanced_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdvancedSettingsState {

/// What «Saqlash» hands back; the page's choice until then.
 AdvancedOptions get draft;/// Where the file may go: the workspaces the person can write to.
 List<Workspace> get workspaces;/// A file of this upload already reached the server with its
/// destination; workspace and folder cannot change.
 bool get destinationLocked;/// Local files that can be played to mark speakers; empty for a link.
 List<HintSource> get sources;/// The file whose hints are shown.
 String? get sourceKey; AdvancedSection? get open; AdvancedLoad get foldersStatus; List<Folder> get folders; AdvancedLoad get glossariesStatus; List<Glossary> get glossaries; AdvancedLoad get balanceStatus; int? get balanceSeconds;/// Why the last «Qoʻshish» was refused; cleared by the next try.
 AdvancedProblem? get hintProblem;
/// Create a copy of AdvancedSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdvancedSettingsStateCopyWith<AdvancedSettingsState> get copyWith => _$AdvancedSettingsStateCopyWithImpl<AdvancedSettingsState>(this as AdvancedSettingsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AdvancedSettingsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdvancedSettingsState&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&const DeepCollectionEquality().equals(other.workspaces, _this.workspaces)&&(identical(other.destinationLocked, _this.destinationLocked) || other.destinationLocked == _this.destinationLocked)&&const DeepCollectionEquality().equals(other.sources, _this.sources)&&(identical(other.sourceKey, _this.sourceKey) || other.sourceKey == _this.sourceKey)&&(identical(other.open, _this.open) || other.open == _this.open)&&(identical(other.foldersStatus, _this.foldersStatus) || other.foldersStatus == _this.foldersStatus)&&const DeepCollectionEquality().equals(other.folders, _this.folders)&&(identical(other.glossariesStatus, _this.glossariesStatus) || other.glossariesStatus == _this.glossariesStatus)&&const DeepCollectionEquality().equals(other.glossaries, _this.glossaries)&&(identical(other.balanceStatus, _this.balanceStatus) || other.balanceStatus == _this.balanceStatus)&&(identical(other.balanceSeconds, _this.balanceSeconds) || other.balanceSeconds == _this.balanceSeconds)&&(identical(other.hintProblem, _this.hintProblem) || other.hintProblem == _this.hintProblem));
}


@override
int get hashCode {
  final _this = this as AdvancedSettingsState;
  return Object.hash(runtimeType,_this.draft,const DeepCollectionEquality().hash(_this.workspaces),_this.destinationLocked,const DeepCollectionEquality().hash(_this.sources),_this.sourceKey,_this.open,_this.foldersStatus,const DeepCollectionEquality().hash(_this.folders),_this.glossariesStatus,const DeepCollectionEquality().hash(_this.glossaries),_this.balanceStatus,_this.balanceSeconds,_this.hintProblem);
}

@override
String toString() {
  final _this = this as AdvancedSettingsState;
  return 'AdvancedSettingsState(draft: ${_this.draft}, workspaces: ${_this.workspaces}, destinationLocked: ${_this.destinationLocked}, sources: ${_this.sources}, sourceKey: ${_this.sourceKey}, open: ${_this.open}, foldersStatus: ${_this.foldersStatus}, folders: ${_this.folders}, glossariesStatus: ${_this.glossariesStatus}, glossaries: ${_this.glossaries}, balanceStatus: ${_this.balanceStatus}, balanceSeconds: ${_this.balanceSeconds}, hintProblem: ${_this.hintProblem})';
}


}

/// @nodoc
abstract mixin class $AdvancedSettingsStateCopyWith<$Res>  {
  factory $AdvancedSettingsStateCopyWith(AdvancedSettingsState value, $Res Function(AdvancedSettingsState) _then) = _$AdvancedSettingsStateCopyWithImpl;
@useResult
$Res call({
 AdvancedOptions draft, List<Workspace> workspaces, bool destinationLocked, List<HintSource> sources, String? sourceKey, AdvancedSection? open, AdvancedLoad foldersStatus, List<Folder> folders, AdvancedLoad glossariesStatus, List<Glossary> glossaries, AdvancedLoad balanceStatus, int? balanceSeconds, AdvancedProblem? hintProblem
});


$AdvancedOptionsCopyWith<$Res> get draft;

}
/// @nodoc
class _$AdvancedSettingsStateCopyWithImpl<$Res>
    implements $AdvancedSettingsStateCopyWith<$Res> {
  _$AdvancedSettingsStateCopyWithImpl(this._self, this._then);

  final AdvancedSettingsState _self;
  final $Res Function(AdvancedSettingsState) _then;

/// Create a copy of AdvancedSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draft = null,Object? workspaces = null,Object? destinationLocked = null,Object? sources = null,Object? sourceKey = freezed,Object? open = freezed,Object? foldersStatus = null,Object? folders = null,Object? glossariesStatus = null,Object? glossaries = null,Object? balanceStatus = null,Object? balanceSeconds = freezed,Object? hintProblem = freezed,}) {
  return _then(AdvancedSettingsState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as AdvancedOptions,workspaces: null == workspaces ? _self.workspaces : workspaces // ignore: cast_nullable_to_non_nullable
as List<Workspace>,destinationLocked: null == destinationLocked ? _self.destinationLocked : destinationLocked // ignore: cast_nullable_to_non_nullable
as bool,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<HintSource>,sourceKey: freezed == sourceKey ? _self.sourceKey : sourceKey // ignore: cast_nullable_to_non_nullable
as String?,open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as AdvancedSection?,foldersStatus: null == foldersStatus ? _self.foldersStatus : foldersStatus // ignore: cast_nullable_to_non_nullable
as AdvancedLoad,folders: null == folders ? _self.folders : folders // ignore: cast_nullable_to_non_nullable
as List<Folder>,glossariesStatus: null == glossariesStatus ? _self.glossariesStatus : glossariesStatus // ignore: cast_nullable_to_non_nullable
as AdvancedLoad,glossaries: null == glossaries ? _self.glossaries : glossaries // ignore: cast_nullable_to_non_nullable
as List<Glossary>,balanceStatus: null == balanceStatus ? _self.balanceStatus : balanceStatus // ignore: cast_nullable_to_non_nullable
as AdvancedLoad,balanceSeconds: freezed == balanceSeconds ? _self.balanceSeconds : balanceSeconds // ignore: cast_nullable_to_non_nullable
as int?,hintProblem: freezed == hintProblem ? _self.hintProblem : hintProblem // ignore: cast_nullable_to_non_nullable
as AdvancedProblem?,
  ));
}
/// Create a copy of AdvancedSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdvancedOptionsCopyWith<$Res> get draft {
  
  return $AdvancedOptionsCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdvancedSettingsState].
extension AdvancedSettingsStatePatterns on AdvancedSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdvancedSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdvancedSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdvancedSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _AdvancedSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdvancedSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _AdvancedSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AdvancedOptions draft,  List<Workspace> workspaces,  bool destinationLocked,  List<HintSource> sources,  String? sourceKey,  AdvancedSection? open,  AdvancedLoad foldersStatus,  List<Folder> folders,  AdvancedLoad glossariesStatus,  List<Glossary> glossaries,  AdvancedLoad balanceStatus,  int? balanceSeconds,  AdvancedProblem? hintProblem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdvancedSettingsState() when $default != null:
return $default(_that.draft,_that.workspaces,_that.destinationLocked,_that.sources,_that.sourceKey,_that.open,_that.foldersStatus,_that.folders,_that.glossariesStatus,_that.glossaries,_that.balanceStatus,_that.balanceSeconds,_that.hintProblem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AdvancedOptions draft,  List<Workspace> workspaces,  bool destinationLocked,  List<HintSource> sources,  String? sourceKey,  AdvancedSection? open,  AdvancedLoad foldersStatus,  List<Folder> folders,  AdvancedLoad glossariesStatus,  List<Glossary> glossaries,  AdvancedLoad balanceStatus,  int? balanceSeconds,  AdvancedProblem? hintProblem)  $default,) {final _that = this;
switch (_that) {
case _AdvancedSettingsState():
return $default(_that.draft,_that.workspaces,_that.destinationLocked,_that.sources,_that.sourceKey,_that.open,_that.foldersStatus,_that.folders,_that.glossariesStatus,_that.glossaries,_that.balanceStatus,_that.balanceSeconds,_that.hintProblem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AdvancedOptions draft,  List<Workspace> workspaces,  bool destinationLocked,  List<HintSource> sources,  String? sourceKey,  AdvancedSection? open,  AdvancedLoad foldersStatus,  List<Folder> folders,  AdvancedLoad glossariesStatus,  List<Glossary> glossaries,  AdvancedLoad balanceStatus,  int? balanceSeconds,  AdvancedProblem? hintProblem)?  $default,) {final _that = this;
switch (_that) {
case _AdvancedSettingsState() when $default != null:
return $default(_that.draft,_that.workspaces,_that.destinationLocked,_that.sources,_that.sourceKey,_that.open,_that.foldersStatus,_that.folders,_that.glossariesStatus,_that.glossaries,_that.balanceStatus,_that.balanceSeconds,_that.hintProblem);case _:
  return null;

}
}

}

/// @nodoc


class _AdvancedSettingsState extends AdvancedSettingsState {
  const _AdvancedSettingsState({required this.draft,  List<Workspace> workspaces = const <Workspace>[], this.destinationLocked = false,  List<HintSource> sources = const <HintSource>[], this.sourceKey, this.open, this.foldersStatus = AdvancedLoad.initial,  List<Folder> folders = const <Folder>[], this.glossariesStatus = AdvancedLoad.initial,  List<Glossary> glossaries = const <Glossary>[], this.balanceStatus = AdvancedLoad.initial, this.balanceSeconds, this.hintProblem}): _workspaces = workspaces,_sources = sources,_folders = folders,_glossaries = glossaries,super._();
  

/// What «Saqlash» hands back; the page's choice until then.
@override final  AdvancedOptions draft;
/// Where the file may go: the workspaces the person can write to.
 final  List<Workspace> _workspaces;
/// Where the file may go: the workspaces the person can write to.
@override@JsonKey() List<Workspace> get workspaces {
  if (_workspaces is EqualUnmodifiableListView) return _workspaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workspaces);
}

/// A file of this upload already reached the server with its
/// destination; workspace and folder cannot change.
@override@JsonKey() final  bool destinationLocked;
/// Local files that can be played to mark speakers; empty for a link.
 final  List<HintSource> _sources;
/// Local files that can be played to mark speakers; empty for a link.
@override@JsonKey() List<HintSource> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

/// The file whose hints are shown.
@override final  String? sourceKey;
@override final  AdvancedSection? open;
@override@JsonKey() final  AdvancedLoad foldersStatus;
 final  List<Folder> _folders;
@override@JsonKey() List<Folder> get folders {
  if (_folders is EqualUnmodifiableListView) return _folders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_folders);
}

@override@JsonKey() final  AdvancedLoad glossariesStatus;
 final  List<Glossary> _glossaries;
@override@JsonKey() List<Glossary> get glossaries {
  if (_glossaries is EqualUnmodifiableListView) return _glossaries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_glossaries);
}

@override@JsonKey() final  AdvancedLoad balanceStatus;
@override final  int? balanceSeconds;
/// Why the last «Qoʻshish» was refused; cleared by the next try.
@override final  AdvancedProblem? hintProblem;

/// Create a copy of AdvancedSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdvancedSettingsStateCopyWith<_AdvancedSettingsState> get copyWith => __$AdvancedSettingsStateCopyWithImpl<_AdvancedSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdvancedSettingsState&&(identical(other.draft, draft) || other.draft == draft)&&const DeepCollectionEquality().equals(other.workspaces, _workspaces)&&(identical(other.destinationLocked, destinationLocked) || other.destinationLocked == destinationLocked)&&const DeepCollectionEquality().equals(other.sources, _sources)&&(identical(other.sourceKey, sourceKey) || other.sourceKey == sourceKey)&&(identical(other.open, open) || other.open == open)&&(identical(other.foldersStatus, foldersStatus) || other.foldersStatus == foldersStatus)&&const DeepCollectionEquality().equals(other.folders, _folders)&&(identical(other.glossariesStatus, glossariesStatus) || other.glossariesStatus == glossariesStatus)&&const DeepCollectionEquality().equals(other.glossaries, _glossaries)&&(identical(other.balanceStatus, balanceStatus) || other.balanceStatus == balanceStatus)&&(identical(other.balanceSeconds, balanceSeconds) || other.balanceSeconds == balanceSeconds)&&(identical(other.hintProblem, hintProblem) || other.hintProblem == hintProblem));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draft,const DeepCollectionEquality().hash(_workspaces),destinationLocked,const DeepCollectionEquality().hash(_sources),sourceKey,open,foldersStatus,const DeepCollectionEquality().hash(_folders),glossariesStatus,const DeepCollectionEquality().hash(_glossaries),balanceStatus,balanceSeconds,hintProblem);
}

@override
String toString() {
    return 'AdvancedSettingsState(draft: $draft, workspaces: $workspaces, destinationLocked: $destinationLocked, sources: $sources, sourceKey: $sourceKey, open: $open, foldersStatus: $foldersStatus, folders: $folders, glossariesStatus: $glossariesStatus, glossaries: $glossaries, balanceStatus: $balanceStatus, balanceSeconds: $balanceSeconds, hintProblem: $hintProblem)';
}


}

/// @nodoc
abstract mixin class _$AdvancedSettingsStateCopyWith<$Res> implements $AdvancedSettingsStateCopyWith<$Res> {
  factory _$AdvancedSettingsStateCopyWith(_AdvancedSettingsState value, $Res Function(_AdvancedSettingsState) _then) = __$AdvancedSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 AdvancedOptions draft, List<Workspace> workspaces, bool destinationLocked, List<HintSource> sources, String? sourceKey, AdvancedSection? open, AdvancedLoad foldersStatus, List<Folder> folders, AdvancedLoad glossariesStatus, List<Glossary> glossaries, AdvancedLoad balanceStatus, int? balanceSeconds, AdvancedProblem? hintProblem
});


@override $AdvancedOptionsCopyWith<$Res> get draft;

}
/// @nodoc
class __$AdvancedSettingsStateCopyWithImpl<$Res>
    implements _$AdvancedSettingsStateCopyWith<$Res> {
  __$AdvancedSettingsStateCopyWithImpl(this._self, this._then);

  final _AdvancedSettingsState _self;
  final $Res Function(_AdvancedSettingsState) _then;

/// Create a copy of AdvancedSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? workspaces = null,Object? destinationLocked = null,Object? sources = null,Object? sourceKey = freezed,Object? open = freezed,Object? foldersStatus = null,Object? folders = null,Object? glossariesStatus = null,Object? glossaries = null,Object? balanceStatus = null,Object? balanceSeconds = freezed,Object? hintProblem = freezed,}) {
  return _then(_AdvancedSettingsState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as AdvancedOptions,workspaces: null == workspaces ? _self._workspaces : workspaces // ignore: cast_nullable_to_non_nullable
as List<Workspace>,destinationLocked: null == destinationLocked ? _self.destinationLocked : destinationLocked // ignore: cast_nullable_to_non_nullable
as bool,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<HintSource>,sourceKey: freezed == sourceKey ? _self.sourceKey : sourceKey // ignore: cast_nullable_to_non_nullable
as String?,open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as AdvancedSection?,foldersStatus: null == foldersStatus ? _self.foldersStatus : foldersStatus // ignore: cast_nullable_to_non_nullable
as AdvancedLoad,folders: null == folders ? _self._folders : folders // ignore: cast_nullable_to_non_nullable
as List<Folder>,glossariesStatus: null == glossariesStatus ? _self.glossariesStatus : glossariesStatus // ignore: cast_nullable_to_non_nullable
as AdvancedLoad,glossaries: null == glossaries ? _self._glossaries : glossaries // ignore: cast_nullable_to_non_nullable
as List<Glossary>,balanceStatus: null == balanceStatus ? _self.balanceStatus : balanceStatus // ignore: cast_nullable_to_non_nullable
as AdvancedLoad,balanceSeconds: freezed == balanceSeconds ? _self.balanceSeconds : balanceSeconds // ignore: cast_nullable_to_non_nullable
as int?,hintProblem: freezed == hintProblem ? _self.hintProblem : hintProblem // ignore: cast_nullable_to_non_nullable
as AdvancedProblem?,
  ));
}

/// Create a copy of AdvancedSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdvancedOptionsCopyWith<$Res> get draft {
  
  return $AdvancedOptionsCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
