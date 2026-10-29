// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'segment_id') String get segmentId;@JsonKey(name: 'author_id') String? get authorId;@JsonKey(name: 'author_name') String get authorName;@JsonKey(name: 'body') String get body;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentModelCopyWith<CommentModel> get copyWith => _$CommentModelCopyWithImpl<CommentModel>(this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CommentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.segmentId, _this.segmentId) || other.segmentId == _this.segmentId)&&(identical(other.authorId, _this.authorId) || other.authorId == _this.authorId)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CommentModel;
  return Object.hash(runtimeType,_this.id,_this.segmentId,_this.authorId,_this.authorName,_this.body,_this.createdAt);
}

@override
String toString() {
  final _this = this as CommentModel;
  return 'CommentModel(id: ${_this.id}, segmentId: ${_this.segmentId}, authorId: ${_this.authorId}, authorName: ${_this.authorName}, body: ${_this.body}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res>  {
  factory $CommentModelCopyWith(CommentModel value, $Res Function(CommentModel) _then) = _$CommentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'segment_id') String segmentId,@JsonKey(name: 'author_id') String? authorId,@JsonKey(name: 'author_name') String authorName,@JsonKey(name: 'body') String body,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$CommentModelCopyWithImpl<$Res>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? segmentId = null,Object? authorId = freezed,Object? authorName = null,Object? body = null,Object? createdAt = freezed,}) {
  return _then(CommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentModel].
extension CommentModelPatterns on CommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'segment_id')  String segmentId, @JsonKey(name: 'author_id')  String? authorId, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'body')  String body, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.segmentId,_that.authorId,_that.authorName,_that.body,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'segment_id')  String segmentId, @JsonKey(name: 'author_id')  String? authorId, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'body')  String body, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CommentModel():
return $default(_that.id,_that.segmentId,_that.authorId,_that.authorName,_that.body,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'segment_id')  String segmentId, @JsonKey(name: 'author_id')  String? authorId, @JsonKey(name: 'author_name')  String authorName, @JsonKey(name: 'body')  String body, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.segmentId,_that.authorId,_that.authorName,_that.body,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentModel extends CommentModel {
  const _CommentModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'segment_id') this.segmentId = '', @JsonKey(name: 'author_id') this.authorId, @JsonKey(name: 'author_name') this.authorName = '', @JsonKey(name: 'body') this.body = '', @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'segment_id') final  String segmentId;
@override@JsonKey(name: 'author_id') final  String? authorId;
@override@JsonKey(name: 'author_name') final  String authorName;
@override@JsonKey(name: 'body') final  String body;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentModelCopyWith<_CommentModel> get copyWith => __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.segmentId, segmentId) || other.segmentId == segmentId)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,segmentId,authorId,authorName,body,createdAt);
}

@override
String toString() {
    return 'CommentModel(id: $id, segmentId: $segmentId, authorId: $authorId, authorName: $authorName, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res> implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(_CommentModel value, $Res Function(_CommentModel) _then) = __$CommentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'segment_id') String segmentId,@JsonKey(name: 'author_id') String? authorId,@JsonKey(name: 'author_name') String authorName,@JsonKey(name: 'body') String body,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? segmentId = null,Object? authorId = freezed,Object? authorName = null,Object? body = null,Object? createdAt = freezed,}) {
  return _then(_CommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CommentListModel {

@JsonKey(name: 'items') List<CommentModel> get items;
/// Create a copy of CommentListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentListModelCopyWith<CommentListModel> get copyWith => _$CommentListModelCopyWithImpl<CommentListModel>(this as CommentListModel, _$identity);

  /// Serializes this CommentListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CommentListModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentListModel&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CommentListModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as CommentListModel;
  return 'CommentListModel(items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $CommentListModelCopyWith<$Res>  {
  factory $CommentListModelCopyWith(CommentListModel value, $Res Function(CommentListModel) _then) = _$CommentListModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'items') List<CommentModel> items
});




}
/// @nodoc
class _$CommentListModelCopyWithImpl<$Res>
    implements $CommentListModelCopyWith<$Res> {
  _$CommentListModelCopyWithImpl(this._self, this._then);

  final CommentListModel _self;
  final $Res Function(CommentListModel) _then;

/// Create a copy of CommentListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(CommentListModel(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CommentModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentListModel].
extension CommentListModelPatterns on CommentListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentListModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentListModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<CommentModel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentListModel() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<CommentModel> items)  $default,) {final _that = this;
switch (_that) {
case _CommentListModel():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'items')  List<CommentModel> items)?  $default,) {final _that = this;
switch (_that) {
case _CommentListModel() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentListModel implements CommentListModel {
  const _CommentListModel({@JsonKey(name: 'items')  List<CommentModel> items = const <CommentModel>[]}): _items = items;
  factory _CommentListModel.fromJson(Map<String, dynamic> json) => _$CommentListModelFromJson(json);

 final  List<CommentModel> _items;
@override@JsonKey(name: 'items') List<CommentModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CommentListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentListModelCopyWith<_CommentListModel> get copyWith => __$CommentListModelCopyWithImpl<_CommentListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentListModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentListModel&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'CommentListModel(items: $items)';
}


}

/// @nodoc
abstract mixin class _$CommentListModelCopyWith<$Res> implements $CommentListModelCopyWith<$Res> {
  factory _$CommentListModelCopyWith(_CommentListModel value, $Res Function(_CommentListModel) _then) = __$CommentListModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'items') List<CommentModel> items
});




}
/// @nodoc
class __$CommentListModelCopyWithImpl<$Res>
    implements _$CommentListModelCopyWith<$Res> {
  __$CommentListModelCopyWithImpl(this._self, this._then);

  final _CommentListModel _self;
  final $Res Function(_CommentListModel) _then;

/// Create a copy of CommentListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_CommentListModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CommentModel>,
  ));
}


}


/// @nodoc
mixin _$CommentEnvelopeModel {

@JsonKey(name: 'comment') CommentModel get comment;
/// Create a copy of CommentEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentEnvelopeModelCopyWith<CommentEnvelopeModel> get copyWith => _$CommentEnvelopeModelCopyWithImpl<CommentEnvelopeModel>(this as CommentEnvelopeModel, _$identity);

  /// Serializes this CommentEnvelopeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CommentEnvelopeModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentEnvelopeModel&&(identical(other.comment, _this.comment) || other.comment == _this.comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CommentEnvelopeModel;
  return Object.hash(runtimeType,_this.comment);
}

@override
String toString() {
  final _this = this as CommentEnvelopeModel;
  return 'CommentEnvelopeModel(comment: ${_this.comment})';
}


}

/// @nodoc
abstract mixin class $CommentEnvelopeModelCopyWith<$Res>  {
  factory $CommentEnvelopeModelCopyWith(CommentEnvelopeModel value, $Res Function(CommentEnvelopeModel) _then) = _$CommentEnvelopeModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'comment') CommentModel comment
});


$CommentModelCopyWith<$Res> get comment;

}
/// @nodoc
class _$CommentEnvelopeModelCopyWithImpl<$Res>
    implements $CommentEnvelopeModelCopyWith<$Res> {
  _$CommentEnvelopeModelCopyWithImpl(this._self, this._then);

  final CommentEnvelopeModel _self;
  final $Res Function(CommentEnvelopeModel) _then;

/// Create a copy of CommentEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? comment = null,}) {
  return _then(CommentEnvelopeModel(
comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as CommentModel,
  ));
}
/// Create a copy of CommentEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentModelCopyWith<$Res> get comment {
  
  return $CommentModelCopyWith<$Res>(_self.comment, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommentEnvelopeModel].
extension CommentEnvelopeModelPatterns on CommentEnvelopeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentEnvelopeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentEnvelopeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentEnvelopeModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentEnvelopeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentEnvelopeModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentEnvelopeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'comment')  CommentModel comment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentEnvelopeModel() when $default != null:
return $default(_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'comment')  CommentModel comment)  $default,) {final _that = this;
switch (_that) {
case _CommentEnvelopeModel():
return $default(_that.comment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'comment')  CommentModel comment)?  $default,) {final _that = this;
switch (_that) {
case _CommentEnvelopeModel() when $default != null:
return $default(_that.comment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentEnvelopeModel implements CommentEnvelopeModel {
  const _CommentEnvelopeModel({@JsonKey(name: 'comment') required this.comment});
  factory _CommentEnvelopeModel.fromJson(Map<String, dynamic> json) => _$CommentEnvelopeModelFromJson(json);

@override@JsonKey(name: 'comment') final  CommentModel comment;

/// Create a copy of CommentEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentEnvelopeModelCopyWith<_CommentEnvelopeModel> get copyWith => __$CommentEnvelopeModelCopyWithImpl<_CommentEnvelopeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentEnvelopeModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentEnvelopeModel&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,comment);
}

@override
String toString() {
    return 'CommentEnvelopeModel(comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$CommentEnvelopeModelCopyWith<$Res> implements $CommentEnvelopeModelCopyWith<$Res> {
  factory _$CommentEnvelopeModelCopyWith(_CommentEnvelopeModel value, $Res Function(_CommentEnvelopeModel) _then) = __$CommentEnvelopeModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'comment') CommentModel comment
});


@override $CommentModelCopyWith<$Res> get comment;

}
/// @nodoc
class __$CommentEnvelopeModelCopyWithImpl<$Res>
    implements _$CommentEnvelopeModelCopyWith<$Res> {
  __$CommentEnvelopeModelCopyWithImpl(this._self, this._then);

  final _CommentEnvelopeModel _self;
  final $Res Function(_CommentEnvelopeModel) _then;

/// Create a copy of CommentEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? comment = null,}) {
  return _then(_CommentEnvelopeModel(
comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as CommentModel,
  ));
}

/// Create a copy of CommentEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentModelCopyWith<$Res> get comment {
  
  return $CommentModelCopyWith<$Res>(_self.comment, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}

// dart format on
