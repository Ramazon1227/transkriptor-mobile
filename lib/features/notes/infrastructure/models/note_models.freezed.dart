// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteSummaryModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'title') String get title;@JsonKey(name: 'excerpt') String get excerpt;@JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) NoteSourceKind get sourceKind;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of NoteSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteSummaryModelCopyWith<NoteSummaryModel> get copyWith => _$NoteSummaryModelCopyWithImpl<NoteSummaryModel>(this as NoteSummaryModel, _$identity);

  /// Serializes this NoteSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NoteSummaryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteSummaryModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.excerpt, _this.excerpt) || other.excerpt == _this.excerpt)&&(identical(other.sourceKind, _this.sourceKind) || other.sourceKind == _this.sourceKind)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NoteSummaryModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.excerpt,_this.sourceKind,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as NoteSummaryModel;
  return 'NoteSummaryModel(id: ${_this.id}, title: ${_this.title}, excerpt: ${_this.excerpt}, sourceKind: ${_this.sourceKind}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $NoteSummaryModelCopyWith<$Res>  {
  factory $NoteSummaryModelCopyWith(NoteSummaryModel value, $Res Function(NoteSummaryModel) _then) = _$NoteSummaryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'title') String title,@JsonKey(name: 'excerpt') String excerpt,@JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) NoteSourceKind sourceKind,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class _$NoteSummaryModelCopyWithImpl<$Res>
    implements $NoteSummaryModelCopyWith<$Res> {
  _$NoteSummaryModelCopyWithImpl(this._self, this._then);

  final NoteSummaryModel _self;
  final $Res Function(NoteSummaryModel) _then;

/// Create a copy of NoteSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? excerpt = null,Object? sourceKind = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(NoteSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,excerpt: null == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as String,sourceKind: null == sourceKind ? _self.sourceKind : sourceKind // ignore: cast_nullable_to_non_nullable
as NoteSourceKind,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteSummaryModel].
extension NoteSummaryModelPatterns on NoteSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _NoteSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoteSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'excerpt')  String excerpt, @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown)  NoteSourceKind sourceKind, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteSummaryModel() when $default != null:
return $default(_that.id,_that.title,_that.excerpt,_that.sourceKind,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'excerpt')  String excerpt, @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown)  NoteSourceKind sourceKind, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _NoteSummaryModel():
return $default(_that.id,_that.title,_that.excerpt,_that.sourceKind,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'excerpt')  String excerpt, @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown)  NoteSourceKind sourceKind, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _NoteSummaryModel() when $default != null:
return $default(_that.id,_that.title,_that.excerpt,_that.sourceKind,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteSummaryModel extends NoteSummaryModel {
  const _NoteSummaryModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'title') this.title = '', @JsonKey(name: 'excerpt') this.excerpt = '', @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) this.sourceKind = NoteSourceKind.unknown, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): super._();
  factory _NoteSummaryModel.fromJson(Map<String, dynamic> json) => _$NoteSummaryModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'excerpt') final  String excerpt;
@override@JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) final  NoteSourceKind sourceKind;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of NoteSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteSummaryModelCopyWith<_NoteSummaryModel> get copyWith => __$NoteSummaryModelCopyWithImpl<_NoteSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&(identical(other.sourceKind, sourceKind) || other.sourceKind == sourceKind)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,excerpt,sourceKind,createdAt,updatedAt);
}

@override
String toString() {
    return 'NoteSummaryModel(id: $id, title: $title, excerpt: $excerpt, sourceKind: $sourceKind, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NoteSummaryModelCopyWith<$Res> implements $NoteSummaryModelCopyWith<$Res> {
  factory _$NoteSummaryModelCopyWith(_NoteSummaryModel value, $Res Function(_NoteSummaryModel) _then) = __$NoteSummaryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'title') String title,@JsonKey(name: 'excerpt') String excerpt,@JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) NoteSourceKind sourceKind,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class __$NoteSummaryModelCopyWithImpl<$Res>
    implements _$NoteSummaryModelCopyWith<$Res> {
  __$NoteSummaryModelCopyWithImpl(this._self, this._then);

  final _NoteSummaryModel _self;
  final $Res Function(_NoteSummaryModel) _then;

/// Create a copy of NoteSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? excerpt = null,Object? sourceKind = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_NoteSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,excerpt: null == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as String,sourceKind: null == sourceKind ? _self.sourceKind : sourceKind // ignore: cast_nullable_to_non_nullable
as NoteSourceKind,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NoteListModel {

@JsonKey(name: 'items') List<NoteSummaryModel> get items;@JsonKey(name: 'next_cursor') String? get nextCursor;
/// Create a copy of NoteListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteListModelCopyWith<NoteListModel> get copyWith => _$NoteListModelCopyWithImpl<NoteListModel>(this as NoteListModel, _$identity);

  /// Serializes this NoteListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NoteListModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteListModel&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NoteListModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.nextCursor);
}

@override
String toString() {
  final _this = this as NoteListModel;
  return 'NoteListModel(items: ${_this.items}, nextCursor: ${_this.nextCursor})';
}


}

/// @nodoc
abstract mixin class $NoteListModelCopyWith<$Res>  {
  factory $NoteListModelCopyWith(NoteListModel value, $Res Function(NoteListModel) _then) = _$NoteListModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'items') List<NoteSummaryModel> items,@JsonKey(name: 'next_cursor') String? nextCursor
});




}
/// @nodoc
class _$NoteListModelCopyWithImpl<$Res>
    implements $NoteListModelCopyWith<$Res> {
  _$NoteListModelCopyWithImpl(this._self, this._then);

  final NoteListModel _self;
  final $Res Function(NoteListModel) _then;

/// Create a copy of NoteListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(NoteListModel(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<NoteSummaryModel>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteListModel].
extension NoteListModelPatterns on NoteListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteListModel value)  $default,){
final _that = this;
switch (_that) {
case _NoteListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteListModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoteListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<NoteSummaryModel> items, @JsonKey(name: 'next_cursor')  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteListModel() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<NoteSummaryModel> items, @JsonKey(name: 'next_cursor')  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _NoteListModel():
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'items')  List<NoteSummaryModel> items, @JsonKey(name: 'next_cursor')  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _NoteListModel() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteListModel extends NoteListModel {
  const _NoteListModel({@JsonKey(name: 'items')  List<NoteSummaryModel> items = const <NoteSummaryModel>[], @JsonKey(name: 'next_cursor') this.nextCursor}): _items = items,super._();
  factory _NoteListModel.fromJson(Map<String, dynamic> json) => _$NoteListModelFromJson(json);

 final  List<NoteSummaryModel> _items;
@override@JsonKey(name: 'items') List<NoteSummaryModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'next_cursor') final  String? nextCursor;

/// Create a copy of NoteListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteListModelCopyWith<_NoteListModel> get copyWith => __$NoteListModelCopyWithImpl<_NoteListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteListModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteListModel&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);
}

@override
String toString() {
    return 'NoteListModel(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$NoteListModelCopyWith<$Res> implements $NoteListModelCopyWith<$Res> {
  factory _$NoteListModelCopyWith(_NoteListModel value, $Res Function(_NoteListModel) _then) = __$NoteListModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'items') List<NoteSummaryModel> items,@JsonKey(name: 'next_cursor') String? nextCursor
});




}
/// @nodoc
class __$NoteListModelCopyWithImpl<$Res>
    implements _$NoteListModelCopyWith<$Res> {
  __$NoteListModelCopyWithImpl(this._self, this._then);

  final _NoteListModel _self;
  final $Res Function(_NoteListModel) _then;

/// Create a copy of NoteListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_NoteListModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<NoteSummaryModel>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NoteOriginModel {

@JsonKey(name: 'transcript_id') String get transcriptId;@JsonKey(name: 'title') String get title;@JsonKey(name: 'available') bool get available;
/// Create a copy of NoteOriginModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteOriginModelCopyWith<NoteOriginModel> get copyWith => _$NoteOriginModelCopyWithImpl<NoteOriginModel>(this as NoteOriginModel, _$identity);

  /// Serializes this NoteOriginModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NoteOriginModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteOriginModel&&(identical(other.transcriptId, _this.transcriptId) || other.transcriptId == _this.transcriptId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.available, _this.available) || other.available == _this.available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NoteOriginModel;
  return Object.hash(runtimeType,_this.transcriptId,_this.title,_this.available);
}

@override
String toString() {
  final _this = this as NoteOriginModel;
  return 'NoteOriginModel(transcriptId: ${_this.transcriptId}, title: ${_this.title}, available: ${_this.available})';
}


}

/// @nodoc
abstract mixin class $NoteOriginModelCopyWith<$Res>  {
  factory $NoteOriginModelCopyWith(NoteOriginModel value, $Res Function(NoteOriginModel) _then) = _$NoteOriginModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'transcript_id') String transcriptId,@JsonKey(name: 'title') String title,@JsonKey(name: 'available') bool available
});




}
/// @nodoc
class _$NoteOriginModelCopyWithImpl<$Res>
    implements $NoteOriginModelCopyWith<$Res> {
  _$NoteOriginModelCopyWithImpl(this._self, this._then);

  final NoteOriginModel _self;
  final $Res Function(NoteOriginModel) _then;

/// Create a copy of NoteOriginModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transcriptId = null,Object? title = null,Object? available = null,}) {
  return _then(NoteOriginModel(
transcriptId: null == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteOriginModel].
extension NoteOriginModelPatterns on NoteOriginModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteOriginModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteOriginModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteOriginModel value)  $default,){
final _that = this;
switch (_that) {
case _NoteOriginModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteOriginModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoteOriginModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'transcript_id')  String transcriptId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'available')  bool available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteOriginModel() when $default != null:
return $default(_that.transcriptId,_that.title,_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'transcript_id')  String transcriptId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'available')  bool available)  $default,) {final _that = this;
switch (_that) {
case _NoteOriginModel():
return $default(_that.transcriptId,_that.title,_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'transcript_id')  String transcriptId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'available')  bool available)?  $default,) {final _that = this;
switch (_that) {
case _NoteOriginModel() when $default != null:
return $default(_that.transcriptId,_that.title,_that.available);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteOriginModel implements NoteOriginModel {
  const _NoteOriginModel({@JsonKey(name: 'transcript_id') this.transcriptId = '', @JsonKey(name: 'title') this.title = '', @JsonKey(name: 'available') this.available = false});
  factory _NoteOriginModel.fromJson(Map<String, dynamic> json) => _$NoteOriginModelFromJson(json);

@override@JsonKey(name: 'transcript_id') final  String transcriptId;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'available') final  bool available;

/// Create a copy of NoteOriginModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteOriginModelCopyWith<_NoteOriginModel> get copyWith => __$NoteOriginModelCopyWithImpl<_NoteOriginModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteOriginModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteOriginModel&&(identical(other.transcriptId, transcriptId) || other.transcriptId == transcriptId)&&(identical(other.title, title) || other.title == title)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,transcriptId,title,available);
}

@override
String toString() {
    return 'NoteOriginModel(transcriptId: $transcriptId, title: $title, available: $available)';
}


}

/// @nodoc
abstract mixin class _$NoteOriginModelCopyWith<$Res> implements $NoteOriginModelCopyWith<$Res> {
  factory _$NoteOriginModelCopyWith(_NoteOriginModel value, $Res Function(_NoteOriginModel) _then) = __$NoteOriginModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'transcript_id') String transcriptId,@JsonKey(name: 'title') String title,@JsonKey(name: 'available') bool available
});




}
/// @nodoc
class __$NoteOriginModelCopyWithImpl<$Res>
    implements _$NoteOriginModelCopyWith<$Res> {
  __$NoteOriginModelCopyWithImpl(this._self, this._then);

  final _NoteOriginModel _self;
  final $Res Function(_NoteOriginModel) _then;

/// Create a copy of NoteOriginModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transcriptId = null,Object? title = null,Object? available = null,}) {
  return _then(_NoteOriginModel(
transcriptId: null == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NoteModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'title') String get title;@JsonKey(name: 'body') Map<String, dynamic>? get body;@JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) NoteSourceKind get sourceKind;@JsonKey(name: 'source') NoteOriginModel? get source;@JsonKey(name: 'revision') int get revision;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteModelCopyWith<NoteModel> get copyWith => _$NoteModelCopyWithImpl<NoteModel>(this as NoteModel, _$identity);

  /// Serializes this NoteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NoteModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&const DeepCollectionEquality().equals(other.body, _this.body)&&(identical(other.sourceKind, _this.sourceKind) || other.sourceKind == _this.sourceKind)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.revision, _this.revision) || other.revision == _this.revision)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NoteModel;
  return Object.hash(runtimeType,_this.id,_this.title,const DeepCollectionEquality().hash(_this.body),_this.sourceKind,_this.source,_this.revision,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as NoteModel;
  return 'NoteModel(id: ${_this.id}, title: ${_this.title}, body: ${_this.body}, sourceKind: ${_this.sourceKind}, source: ${_this.source}, revision: ${_this.revision}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $NoteModelCopyWith<$Res>  {
  factory $NoteModelCopyWith(NoteModel value, $Res Function(NoteModel) _then) = _$NoteModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'title') String title,@JsonKey(name: 'body') Map<String, dynamic>? body,@JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) NoteSourceKind sourceKind,@JsonKey(name: 'source') NoteOriginModel? source,@JsonKey(name: 'revision') int revision,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});


$NoteOriginModelCopyWith<$Res>? get source;

}
/// @nodoc
class _$NoteModelCopyWithImpl<$Res>
    implements $NoteModelCopyWith<$Res> {
  _$NoteModelCopyWithImpl(this._self, this._then);

  final NoteModel _self;
  final $Res Function(NoteModel) _then;

/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = freezed,Object? sourceKind = null,Object? source = freezed,Object? revision = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(NoteModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,sourceKind: null == sourceKind ? _self.sourceKind : sourceKind // ignore: cast_nullable_to_non_nullable
as NoteSourceKind,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as NoteOriginModel?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteOriginModelCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $NoteOriginModelCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [NoteModel].
extension NoteModelPatterns on NoteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteModel value)  $default,){
final _that = this;
switch (_that) {
case _NoteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'body')  Map<String, dynamic>? body, @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown)  NoteSourceKind sourceKind, @JsonKey(name: 'source')  NoteOriginModel? source, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.sourceKind,_that.source,_that.revision,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'body')  Map<String, dynamic>? body, @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown)  NoteSourceKind sourceKind, @JsonKey(name: 'source')  NoteOriginModel? source, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _NoteModel():
return $default(_that.id,_that.title,_that.body,_that.sourceKind,_that.source,_that.revision,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'body')  Map<String, dynamic>? body, @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown)  NoteSourceKind sourceKind, @JsonKey(name: 'source')  NoteOriginModel? source, @JsonKey(name: 'revision')  int revision, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _NoteModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.sourceKind,_that.source,_that.revision,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteModel extends NoteModel {
  const _NoteModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'title') this.title = '', @JsonKey(name: 'body')  Map<String, dynamic>? body, @JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) this.sourceKind = NoteSourceKind.unknown, @JsonKey(name: 'source') this.source, @JsonKey(name: 'revision') this.revision = 0, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): _body = body,super._();
  factory _NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'title') final  String title;
 final  Map<String, dynamic>? _body;
@override@JsonKey(name: 'body') Map<String, dynamic>? get body {
  final value = _body;
  if (value == null) return null;
  if (_body is EqualUnmodifiableMapView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) final  NoteSourceKind sourceKind;
@override@JsonKey(name: 'source') final  NoteOriginModel? source;
@override@JsonKey(name: 'revision') final  int revision;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteModelCopyWith<_NoteModel> get copyWith => __$NoteModelCopyWithImpl<_NoteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.body, _body)&&(identical(other.sourceKind, sourceKind) || other.sourceKind == sourceKind)&&(identical(other.source, source) || other.source == source)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_body),sourceKind,source,revision,createdAt,updatedAt);
}

@override
String toString() {
    return 'NoteModel(id: $id, title: $title, body: $body, sourceKind: $sourceKind, source: $source, revision: $revision, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NoteModelCopyWith<$Res> implements $NoteModelCopyWith<$Res> {
  factory _$NoteModelCopyWith(_NoteModel value, $Res Function(_NoteModel) _then) = __$NoteModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'title') String title,@JsonKey(name: 'body') Map<String, dynamic>? body,@JsonKey(name: 'source_kind', unknownEnumValue: NoteSourceKind.unknown) NoteSourceKind sourceKind,@JsonKey(name: 'source') NoteOriginModel? source,@JsonKey(name: 'revision') int revision,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});


@override $NoteOriginModelCopyWith<$Res>? get source;

}
/// @nodoc
class __$NoteModelCopyWithImpl<$Res>
    implements _$NoteModelCopyWith<$Res> {
  __$NoteModelCopyWithImpl(this._self, this._then);

  final _NoteModel _self;
  final $Res Function(_NoteModel) _then;

/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = freezed,Object? sourceKind = null,Object? source = freezed,Object? revision = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_NoteModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,sourceKind: null == sourceKind ? _self.sourceKind : sourceKind // ignore: cast_nullable_to_non_nullable
as NoteSourceKind,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as NoteOriginModel?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteOriginModelCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $NoteOriginModelCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

// dart format on
