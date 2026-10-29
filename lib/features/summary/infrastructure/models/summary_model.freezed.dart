// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SummaryModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'transcript_id') String get transcriptId;@JsonKey(name: 'template_id') String? get templateId;@JsonKey(name: 'title') String get title;@JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown) SummaryStatusModel get status;@JsonKey(name: 'body') Object? get body;@JsonKey(name: 'error') String get error;@JsonKey(name: 'revision') int get revision;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of SummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryModelCopyWith<SummaryModel> get copyWith => _$SummaryModelCopyWithImpl<SummaryModel>(this as SummaryModel, _$identity);

  /// Serializes this SummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SummaryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.transcriptId, _this.transcriptId) || other.transcriptId == _this.transcriptId)&&(identical(other.templateId, _this.templateId) || other.templateId == _this.templateId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.body, _this.body)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.revision, _this.revision) || other.revision == _this.revision)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SummaryModel;
  return Object.hash(runtimeType,_this.id,_this.transcriptId,_this.templateId,_this.title,_this.status,const DeepCollectionEquality().hash(_this.body),_this.error,_this.revision,_this.updatedAt);
}

@override
String toString() {
  final _this = this as SummaryModel;
  return 'SummaryModel(id: ${_this.id}, transcriptId: ${_this.transcriptId}, templateId: ${_this.templateId}, title: ${_this.title}, status: ${_this.status}, body: ${_this.body}, error: ${_this.error}, revision: ${_this.revision}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $SummaryModelCopyWith<$Res>  {
  factory $SummaryModelCopyWith(SummaryModel value, $Res Function(SummaryModel) _then) = _$SummaryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'transcript_id') String transcriptId,@JsonKey(name: 'template_id') String? templateId,@JsonKey(name: 'title') String title,@JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown) SummaryStatusModel status,@JsonKey(name: 'body') Object? body,@JsonKey(name: 'error') String error,@JsonKey(name: 'revision') int revision,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$SummaryModelCopyWithImpl<$Res>
    implements $SummaryModelCopyWith<$Res> {
  _$SummaryModelCopyWithImpl(this._self, this._then);

  final SummaryModel _self;
  final $Res Function(SummaryModel) _then;

/// Create a copy of SummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transcriptId = null,Object? templateId = freezed,Object? title = null,Object? status = null,Object? body = freezed,Object? error = null,Object? revision = null,Object? updatedAt = freezed,}) {
  return _then(SummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transcriptId: null == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SummaryStatusModel,body: freezed == body ? _self.body : body ,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SummaryModel].
extension SummaryModelPatterns on SummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _SummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'transcript_id')  String transcriptId, @JsonKey(name: 'template_id')  String? templateId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown)  SummaryStatusModel status, @JsonKey(name: 'body')  Object? body, @JsonKey(name: 'error')  String error, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryModel() when $default != null:
return $default(_that.id,_that.transcriptId,_that.templateId,_that.title,_that.status,_that.body,_that.error,_that.revision,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'transcript_id')  String transcriptId, @JsonKey(name: 'template_id')  String? templateId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown)  SummaryStatusModel status, @JsonKey(name: 'body')  Object? body, @JsonKey(name: 'error')  String error, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SummaryModel():
return $default(_that.id,_that.transcriptId,_that.templateId,_that.title,_that.status,_that.body,_that.error,_that.revision,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'transcript_id')  String transcriptId, @JsonKey(name: 'template_id')  String? templateId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown)  SummaryStatusModel status, @JsonKey(name: 'body')  Object? body, @JsonKey(name: 'error')  String error, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SummaryModel() when $default != null:
return $default(_that.id,_that.transcriptId,_that.templateId,_that.title,_that.status,_that.body,_that.error,_that.revision,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SummaryModel extends SummaryModel {
  const _SummaryModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'transcript_id') this.transcriptId = '', @JsonKey(name: 'template_id') this.templateId, @JsonKey(name: 'title') this.title = '', @JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown) this.status = SummaryStatusModel.unknown, @JsonKey(name: 'body') this.body, @JsonKey(name: 'error') this.error = '', @JsonKey(name: 'revision') this.revision = 0, @JsonKey(name: 'updated_at') this.updatedAt}): super._();
  factory _SummaryModel.fromJson(Map<String, dynamic> json) => _$SummaryModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'transcript_id') final  String transcriptId;
@override@JsonKey(name: 'template_id') final  String? templateId;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown) final  SummaryStatusModel status;
@override@JsonKey(name: 'body') final  Object? body;
@override@JsonKey(name: 'error') final  String error;
@override@JsonKey(name: 'revision') final  int revision;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of SummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryModelCopyWith<_SummaryModel> get copyWith => __$SummaryModelCopyWithImpl<_SummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.transcriptId, transcriptId) || other.transcriptId == transcriptId)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.body, body)&&(identical(other.error, error) || other.error == error)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,transcriptId,templateId,title,status,const DeepCollectionEquality().hash(body),error,revision,updatedAt);
}

@override
String toString() {
    return 'SummaryModel(id: $id, transcriptId: $transcriptId, templateId: $templateId, title: $title, status: $status, body: $body, error: $error, revision: $revision, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SummaryModelCopyWith<$Res> implements $SummaryModelCopyWith<$Res> {
  factory _$SummaryModelCopyWith(_SummaryModel value, $Res Function(_SummaryModel) _then) = __$SummaryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'transcript_id') String transcriptId,@JsonKey(name: 'template_id') String? templateId,@JsonKey(name: 'title') String title,@JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown) SummaryStatusModel status,@JsonKey(name: 'body') Object? body,@JsonKey(name: 'error') String error,@JsonKey(name: 'revision') int revision,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$SummaryModelCopyWithImpl<$Res>
    implements _$SummaryModelCopyWith<$Res> {
  __$SummaryModelCopyWithImpl(this._self, this._then);

  final _SummaryModel _self;
  final $Res Function(_SummaryModel) _then;

/// Create a copy of SummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transcriptId = null,Object? templateId = freezed,Object? title = null,Object? status = null,Object? body = freezed,Object? error = null,Object? revision = null,Object? updatedAt = freezed,}) {
  return _then(_SummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transcriptId: null == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SummaryStatusModel,body: freezed == body ? _self.body : body ,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
