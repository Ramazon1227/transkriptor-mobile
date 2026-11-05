// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advanced_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdvancedOptions {

/// Where the file lands and whose balance pays (A-2).
 String get workspaceId; String get workspaceName;/// Null: no folder («Fayllar»).
 String? get folderId; String get folderName;/// Null is Auto (A-4).
 int? get numSpeakers;/// An «Atamalar» list of [workspaceId] (A-1); null: none.
 String? get glossaryId; String get glossaryName;/// Terms for this upload only, one per line, as typed.
 String get termsText;/// Speaker hints by file key (A-3): a hint belongs to one file.
 Map<String, List<SpeakerHint>> get hints;
/// Create a copy of AdvancedOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdvancedOptionsCopyWith<AdvancedOptions> get copyWith => _$AdvancedOptionsCopyWithImpl<AdvancedOptions>(this as AdvancedOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AdvancedOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdvancedOptions&&(identical(other.workspaceId, _this.workspaceId) || other.workspaceId == _this.workspaceId)&&(identical(other.workspaceName, _this.workspaceName) || other.workspaceName == _this.workspaceName)&&(identical(other.folderId, _this.folderId) || other.folderId == _this.folderId)&&(identical(other.folderName, _this.folderName) || other.folderName == _this.folderName)&&(identical(other.numSpeakers, _this.numSpeakers) || other.numSpeakers == _this.numSpeakers)&&(identical(other.glossaryId, _this.glossaryId) || other.glossaryId == _this.glossaryId)&&(identical(other.glossaryName, _this.glossaryName) || other.glossaryName == _this.glossaryName)&&(identical(other.termsText, _this.termsText) || other.termsText == _this.termsText)&&const DeepCollectionEquality().equals(other.hints, _this.hints));
}


@override
int get hashCode {
  final _this = this as AdvancedOptions;
  return Object.hash(runtimeType,_this.workspaceId,_this.workspaceName,_this.folderId,_this.folderName,_this.numSpeakers,_this.glossaryId,_this.glossaryName,_this.termsText,const DeepCollectionEquality().hash(_this.hints));
}

@override
String toString() {
  final _this = this as AdvancedOptions;
  return 'AdvancedOptions(workspaceId: ${_this.workspaceId}, workspaceName: ${_this.workspaceName}, folderId: ${_this.folderId}, folderName: ${_this.folderName}, numSpeakers: ${_this.numSpeakers}, glossaryId: ${_this.glossaryId}, glossaryName: ${_this.glossaryName}, termsText: ${_this.termsText}, hints: ${_this.hints})';
}


}

/// @nodoc
abstract mixin class $AdvancedOptionsCopyWith<$Res>  {
  factory $AdvancedOptionsCopyWith(AdvancedOptions value, $Res Function(AdvancedOptions) _then) = _$AdvancedOptionsCopyWithImpl;
@useResult
$Res call({
 String workspaceId, String workspaceName, String? folderId, String folderName, int? numSpeakers, String? glossaryId, String glossaryName, String termsText, Map<String, List<SpeakerHint>> hints
});




}
/// @nodoc
class _$AdvancedOptionsCopyWithImpl<$Res>
    implements $AdvancedOptionsCopyWith<$Res> {
  _$AdvancedOptionsCopyWithImpl(this._self, this._then);

  final AdvancedOptions _self;
  final $Res Function(AdvancedOptions) _then;

/// Create a copy of AdvancedOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workspaceId = null,Object? workspaceName = null,Object? folderId = freezed,Object? folderName = null,Object? numSpeakers = freezed,Object? glossaryId = freezed,Object? glossaryName = null,Object? termsText = null,Object? hints = null,}) {
  return _then(AdvancedOptions(
workspaceId: null == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String,workspaceName: null == workspaceName ? _self.workspaceName : workspaceName // ignore: cast_nullable_to_non_nullable
as String,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as String?,folderName: null == folderName ? _self.folderName : folderName // ignore: cast_nullable_to_non_nullable
as String,numSpeakers: freezed == numSpeakers ? _self.numSpeakers : numSpeakers // ignore: cast_nullable_to_non_nullable
as int?,glossaryId: freezed == glossaryId ? _self.glossaryId : glossaryId // ignore: cast_nullable_to_non_nullable
as String?,glossaryName: null == glossaryName ? _self.glossaryName : glossaryName // ignore: cast_nullable_to_non_nullable
as String,termsText: null == termsText ? _self.termsText : termsText // ignore: cast_nullable_to_non_nullable
as String,hints: null == hints ? _self.hints : hints // ignore: cast_nullable_to_non_nullable
as Map<String, List<SpeakerHint>>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdvancedOptions].
extension AdvancedOptionsPatterns on AdvancedOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdvancedOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdvancedOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdvancedOptions value)  $default,){
final _that = this;
switch (_that) {
case _AdvancedOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdvancedOptions value)?  $default,){
final _that = this;
switch (_that) {
case _AdvancedOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String workspaceId,  String workspaceName,  String? folderId,  String folderName,  int? numSpeakers,  String? glossaryId,  String glossaryName,  String termsText,  Map<String, List<SpeakerHint>> hints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdvancedOptions() when $default != null:
return $default(_that.workspaceId,_that.workspaceName,_that.folderId,_that.folderName,_that.numSpeakers,_that.glossaryId,_that.glossaryName,_that.termsText,_that.hints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String workspaceId,  String workspaceName,  String? folderId,  String folderName,  int? numSpeakers,  String? glossaryId,  String glossaryName,  String termsText,  Map<String, List<SpeakerHint>> hints)  $default,) {final _that = this;
switch (_that) {
case _AdvancedOptions():
return $default(_that.workspaceId,_that.workspaceName,_that.folderId,_that.folderName,_that.numSpeakers,_that.glossaryId,_that.glossaryName,_that.termsText,_that.hints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String workspaceId,  String workspaceName,  String? folderId,  String folderName,  int? numSpeakers,  String? glossaryId,  String glossaryName,  String termsText,  Map<String, List<SpeakerHint>> hints)?  $default,) {final _that = this;
switch (_that) {
case _AdvancedOptions() when $default != null:
return $default(_that.workspaceId,_that.workspaceName,_that.folderId,_that.folderName,_that.numSpeakers,_that.glossaryId,_that.glossaryName,_that.termsText,_that.hints);case _:
  return null;

}
}

}

/// @nodoc


class _AdvancedOptions extends AdvancedOptions {
  const _AdvancedOptions({required this.workspaceId, this.workspaceName = '', this.folderId, this.folderName = '', this.numSpeakers, this.glossaryId, this.glossaryName = '', this.termsText = '',  Map<String, List<SpeakerHint>> hints = const <String, List<SpeakerHint>>{}}): _hints = hints,super._();
  

/// Where the file lands and whose balance pays (A-2).
@override final  String workspaceId;
@override@JsonKey() final  String workspaceName;
/// Null: no folder («Fayllar»).
@override final  String? folderId;
@override@JsonKey() final  String folderName;
/// Null is Auto (A-4).
@override final  int? numSpeakers;
/// An «Atamalar» list of [workspaceId] (A-1); null: none.
@override final  String? glossaryId;
@override@JsonKey() final  String glossaryName;
/// Terms for this upload only, one per line, as typed.
@override@JsonKey() final  String termsText;
/// Speaker hints by file key (A-3): a hint belongs to one file.
 final  Map<String, List<SpeakerHint>> _hints;
/// Speaker hints by file key (A-3): a hint belongs to one file.
@override@JsonKey() Map<String, List<SpeakerHint>> get hints {
  if (_hints is EqualUnmodifiableMapView) return _hints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_hints);
}


/// Create a copy of AdvancedOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdvancedOptionsCopyWith<_AdvancedOptions> get copyWith => __$AdvancedOptionsCopyWithImpl<_AdvancedOptions>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdvancedOptions&&(identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId)&&(identical(other.workspaceName, workspaceName) || other.workspaceName == workspaceName)&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.folderName, folderName) || other.folderName == folderName)&&(identical(other.numSpeakers, numSpeakers) || other.numSpeakers == numSpeakers)&&(identical(other.glossaryId, glossaryId) || other.glossaryId == glossaryId)&&(identical(other.glossaryName, glossaryName) || other.glossaryName == glossaryName)&&(identical(other.termsText, termsText) || other.termsText == termsText)&&const DeepCollectionEquality().equals(other.hints, _hints));
}


@override
int get hashCode {
    return Object.hash(runtimeType,workspaceId,workspaceName,folderId,folderName,numSpeakers,glossaryId,glossaryName,termsText,const DeepCollectionEquality().hash(_hints));
}

@override
String toString() {
    return 'AdvancedOptions(workspaceId: $workspaceId, workspaceName: $workspaceName, folderId: $folderId, folderName: $folderName, numSpeakers: $numSpeakers, glossaryId: $glossaryId, glossaryName: $glossaryName, termsText: $termsText, hints: $hints)';
}


}

/// @nodoc
abstract mixin class _$AdvancedOptionsCopyWith<$Res> implements $AdvancedOptionsCopyWith<$Res> {
  factory _$AdvancedOptionsCopyWith(_AdvancedOptions value, $Res Function(_AdvancedOptions) _then) = __$AdvancedOptionsCopyWithImpl;
@override @useResult
$Res call({
 String workspaceId, String workspaceName, String? folderId, String folderName, int? numSpeakers, String? glossaryId, String glossaryName, String termsText, Map<String, List<SpeakerHint>> hints
});




}
/// @nodoc
class __$AdvancedOptionsCopyWithImpl<$Res>
    implements _$AdvancedOptionsCopyWith<$Res> {
  __$AdvancedOptionsCopyWithImpl(this._self, this._then);

  final _AdvancedOptions _self;
  final $Res Function(_AdvancedOptions) _then;

/// Create a copy of AdvancedOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workspaceId = null,Object? workspaceName = null,Object? folderId = freezed,Object? folderName = null,Object? numSpeakers = freezed,Object? glossaryId = freezed,Object? glossaryName = null,Object? termsText = null,Object? hints = null,}) {
  return _then(_AdvancedOptions(
workspaceId: null == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String,workspaceName: null == workspaceName ? _self.workspaceName : workspaceName // ignore: cast_nullable_to_non_nullable
as String,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as String?,folderName: null == folderName ? _self.folderName : folderName // ignore: cast_nullable_to_non_nullable
as String,numSpeakers: freezed == numSpeakers ? _self.numSpeakers : numSpeakers // ignore: cast_nullable_to_non_nullable
as int?,glossaryId: freezed == glossaryId ? _self.glossaryId : glossaryId // ignore: cast_nullable_to_non_nullable
as String?,glossaryName: null == glossaryName ? _self.glossaryName : glossaryName // ignore: cast_nullable_to_non_nullable
as String,termsText: null == termsText ? _self.termsText : termsText // ignore: cast_nullable_to_non_nullable
as String,hints: null == hints ? _self._hints : hints // ignore: cast_nullable_to_non_nullable
as Map<String, List<SpeakerHint>>,
  ));
}


}

/// @nodoc
mixin _$HintSource {

 String get key; String get name; String get path;
/// Create a copy of HintSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HintSourceCopyWith<HintSource> get copyWith => _$HintSourceCopyWithImpl<HintSource>(this as HintSource, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HintSource;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HintSource&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.path, _this.path) || other.path == _this.path));
}


@override
int get hashCode {
  final _this = this as HintSource;
  return Object.hash(runtimeType,_this.key,_this.name,_this.path);
}

@override
String toString() {
  final _this = this as HintSource;
  return 'HintSource(key: ${_this.key}, name: ${_this.name}, path: ${_this.path})';
}


}

/// @nodoc
abstract mixin class $HintSourceCopyWith<$Res>  {
  factory $HintSourceCopyWith(HintSource value, $Res Function(HintSource) _then) = _$HintSourceCopyWithImpl;
@useResult
$Res call({
 String key, String name, String path
});




}
/// @nodoc
class _$HintSourceCopyWithImpl<$Res>
    implements $HintSourceCopyWith<$Res> {
  _$HintSourceCopyWithImpl(this._self, this._then);

  final HintSource _self;
  final $Res Function(HintSource) _then;

/// Create a copy of HintSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,Object? path = null,}) {
  return _then(HintSource(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HintSource].
extension HintSourcePatterns on HintSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HintSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HintSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HintSource value)  $default,){
final _that = this;
switch (_that) {
case _HintSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HintSource value)?  $default,){
final _that = this;
switch (_that) {
case _HintSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name,  String path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HintSource() when $default != null:
return $default(_that.key,_that.name,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name,  String path)  $default,) {final _that = this;
switch (_that) {
case _HintSource():
return $default(_that.key,_that.name,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name,  String path)?  $default,) {final _that = this;
switch (_that) {
case _HintSource() when $default != null:
return $default(_that.key,_that.name,_that.path);case _:
  return null;

}
}

}

/// @nodoc


class _HintSource implements HintSource {
  const _HintSource({required this.key, required this.name, required this.path});
  

@override final  String key;
@override final  String name;
@override final  String path;

/// Create a copy of HintSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HintSourceCopyWith<_HintSource> get copyWith => __$HintSourceCopyWithImpl<_HintSource>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HintSource&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode {
    return Object.hash(runtimeType,key,name,path);
}

@override
String toString() {
    return 'HintSource(key: $key, name: $name, path: $path)';
}


}

/// @nodoc
abstract mixin class _$HintSourceCopyWith<$Res> implements $HintSourceCopyWith<$Res> {
  factory _$HintSourceCopyWith(_HintSource value, $Res Function(_HintSource) _then) = __$HintSourceCopyWithImpl;
@override @useResult
$Res call({
 String key, String name, String path
});




}
/// @nodoc
class __$HintSourceCopyWithImpl<$Res>
    implements _$HintSourceCopyWith<$Res> {
  __$HintSourceCopyWithImpl(this._self, this._then);

  final _HintSource _self;
  final $Res Function(_HintSource) _then;

/// Create a copy of HintSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,Object? path = null,}) {
  return _then(_HintSource(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
