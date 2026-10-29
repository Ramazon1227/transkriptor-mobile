// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteSummary {

 String get id;/// May be empty: the list then shows the excerpt.
 String get title; String get excerpt; NoteSourceKind get sourceKind; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of NoteSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteSummaryCopyWith<NoteSummary> get copyWith => _$NoteSummaryCopyWithImpl<NoteSummary>(this as NoteSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NoteSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.excerpt, _this.excerpt) || other.excerpt == _this.excerpt)&&(identical(other.sourceKind, _this.sourceKind) || other.sourceKind == _this.sourceKind)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as NoteSummary;
  return Object.hash(runtimeType,_this.id,_this.title,_this.excerpt,_this.sourceKind,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as NoteSummary;
  return 'NoteSummary(id: ${_this.id}, title: ${_this.title}, excerpt: ${_this.excerpt}, sourceKind: ${_this.sourceKind}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $NoteSummaryCopyWith<$Res>  {
  factory $NoteSummaryCopyWith(NoteSummary value, $Res Function(NoteSummary) _then) = _$NoteSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String title, String excerpt, NoteSourceKind sourceKind, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$NoteSummaryCopyWithImpl<$Res>
    implements $NoteSummaryCopyWith<$Res> {
  _$NoteSummaryCopyWithImpl(this._self, this._then);

  final NoteSummary _self;
  final $Res Function(NoteSummary) _then;

/// Create a copy of NoteSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? excerpt = null,Object? sourceKind = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(NoteSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,excerpt: null == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as String,sourceKind: null == sourceKind ? _self.sourceKind : sourceKind // ignore: cast_nullable_to_non_nullable
as NoteSourceKind,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteSummary].
extension NoteSummaryPatterns on NoteSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteSummary value)  $default,){
final _that = this;
switch (_that) {
case _NoteSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteSummary value)?  $default,){
final _that = this;
switch (_that) {
case _NoteSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String excerpt,  NoteSourceKind sourceKind,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteSummary() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String excerpt,  NoteSourceKind sourceKind,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _NoteSummary():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String excerpt,  NoteSourceKind sourceKind,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _NoteSummary() when $default != null:
return $default(_that.id,_that.title,_that.excerpt,_that.sourceKind,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _NoteSummary implements NoteSummary {
  const _NoteSummary({required this.id, this.title = '', this.excerpt = '', this.sourceKind = NoteSourceKind.unknown, this.createdAt, this.updatedAt});
  

@override final  String id;
/// May be empty: the list then shows the excerpt.
@override@JsonKey() final  String title;
@override@JsonKey() final  String excerpt;
@override@JsonKey() final  NoteSourceKind sourceKind;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of NoteSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteSummaryCopyWith<_NoteSummary> get copyWith => __$NoteSummaryCopyWithImpl<_NoteSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&(identical(other.sourceKind, sourceKind) || other.sourceKind == sourceKind)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,excerpt,sourceKind,createdAt,updatedAt);
}

@override
String toString() {
    return 'NoteSummary(id: $id, title: $title, excerpt: $excerpt, sourceKind: $sourceKind, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NoteSummaryCopyWith<$Res> implements $NoteSummaryCopyWith<$Res> {
  factory _$NoteSummaryCopyWith(_NoteSummary value, $Res Function(_NoteSummary) _then) = __$NoteSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String excerpt, NoteSourceKind sourceKind, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$NoteSummaryCopyWithImpl<$Res>
    implements _$NoteSummaryCopyWith<$Res> {
  __$NoteSummaryCopyWithImpl(this._self, this._then);

  final _NoteSummary _self;
  final $Res Function(_NoteSummary) _then;

/// Create a copy of NoteSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? excerpt = null,Object? sourceKind = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_NoteSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,excerpt: null == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as String,sourceKind: null == sourceKind ? _self.sourceKind : sourceKind // ignore: cast_nullable_to_non_nullable
as NoteSourceKind,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$NotesPage {

 List<NoteSummary> get items; String? get nextCursor;
/// Create a copy of NotesPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotesPageCopyWith<NotesPage> get copyWith => _$NotesPageCopyWithImpl<NotesPage>(this as NotesPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotesPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesPage&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor));
}


@override
int get hashCode {
  final _this = this as NotesPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.nextCursor);
}

@override
String toString() {
  final _this = this as NotesPage;
  return 'NotesPage(items: ${_this.items}, nextCursor: ${_this.nextCursor})';
}


}

/// @nodoc
abstract mixin class $NotesPageCopyWith<$Res>  {
  factory $NotesPageCopyWith(NotesPage value, $Res Function(NotesPage) _then) = _$NotesPageCopyWithImpl;
@useResult
$Res call({
 List<NoteSummary> items, String? nextCursor
});




}
/// @nodoc
class _$NotesPageCopyWithImpl<$Res>
    implements $NotesPageCopyWith<$Res> {
  _$NotesPageCopyWithImpl(this._self, this._then);

  final NotesPage _self;
  final $Res Function(NotesPage) _then;

/// Create a copy of NotesPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(NotesPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<NoteSummary>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotesPage].
extension NotesPagePatterns on NotesPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotesPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotesPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotesPage value)  $default,){
final _that = this;
switch (_that) {
case _NotesPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotesPage value)?  $default,){
final _that = this;
switch (_that) {
case _NotesPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NoteSummary> items,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotesPage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NoteSummary> items,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _NotesPage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NoteSummary> items,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _NotesPage() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc


class _NotesPage implements NotesPage {
  const _NotesPage({ List<NoteSummary> items = const <NoteSummary>[], this.nextCursor}): _items = items;
  

 final  List<NoteSummary> _items;
@override@JsonKey() List<NoteSummary> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;

/// Create a copy of NotesPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotesPageCopyWith<_NotesPage> get copyWith => __$NotesPageCopyWithImpl<_NotesPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotesPage&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);
}

@override
String toString() {
    return 'NotesPage(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$NotesPageCopyWith<$Res> implements $NotesPageCopyWith<$Res> {
  factory _$NotesPageCopyWith(_NotesPage value, $Res Function(_NotesPage) _then) = __$NotesPageCopyWithImpl;
@override @useResult
$Res call({
 List<NoteSummary> items, String? nextCursor
});




}
/// @nodoc
class __$NotesPageCopyWithImpl<$Res>
    implements _$NotesPageCopyWith<$Res> {
  __$NotesPageCopyWithImpl(this._self, this._then);

  final _NotesPage _self;
  final $Res Function(_NotesPage) _then;

/// Create a copy of NotesPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_NotesPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<NoteSummary>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$NoteOrigin {

 String get transcriptId; String get title; bool get available;
/// Create a copy of NoteOrigin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteOriginCopyWith<NoteOrigin> get copyWith => _$NoteOriginCopyWithImpl<NoteOrigin>(this as NoteOrigin, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NoteOrigin;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteOrigin&&(identical(other.transcriptId, _this.transcriptId) || other.transcriptId == _this.transcriptId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.available, _this.available) || other.available == _this.available));
}


@override
int get hashCode {
  final _this = this as NoteOrigin;
  return Object.hash(runtimeType,_this.transcriptId,_this.title,_this.available);
}

@override
String toString() {
  final _this = this as NoteOrigin;
  return 'NoteOrigin(transcriptId: ${_this.transcriptId}, title: ${_this.title}, available: ${_this.available})';
}


}

/// @nodoc
abstract mixin class $NoteOriginCopyWith<$Res>  {
  factory $NoteOriginCopyWith(NoteOrigin value, $Res Function(NoteOrigin) _then) = _$NoteOriginCopyWithImpl;
@useResult
$Res call({
 String transcriptId, String title, bool available
});




}
/// @nodoc
class _$NoteOriginCopyWithImpl<$Res>
    implements $NoteOriginCopyWith<$Res> {
  _$NoteOriginCopyWithImpl(this._self, this._then);

  final NoteOrigin _self;
  final $Res Function(NoteOrigin) _then;

/// Create a copy of NoteOrigin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transcriptId = null,Object? title = null,Object? available = null,}) {
  return _then(NoteOrigin(
transcriptId: null == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteOrigin].
extension NoteOriginPatterns on NoteOrigin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteOrigin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteOrigin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteOrigin value)  $default,){
final _that = this;
switch (_that) {
case _NoteOrigin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteOrigin value)?  $default,){
final _that = this;
switch (_that) {
case _NoteOrigin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transcriptId,  String title,  bool available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteOrigin() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transcriptId,  String title,  bool available)  $default,) {final _that = this;
switch (_that) {
case _NoteOrigin():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transcriptId,  String title,  bool available)?  $default,) {final _that = this;
switch (_that) {
case _NoteOrigin() when $default != null:
return $default(_that.transcriptId,_that.title,_that.available);case _:
  return null;

}
}

}

/// @nodoc


class _NoteOrigin implements NoteOrigin {
  const _NoteOrigin({required this.transcriptId, this.title = '', this.available = false});
  

@override final  String transcriptId;
@override@JsonKey() final  String title;
@override@JsonKey() final  bool available;

/// Create a copy of NoteOrigin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteOriginCopyWith<_NoteOrigin> get copyWith => __$NoteOriginCopyWithImpl<_NoteOrigin>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteOrigin&&(identical(other.transcriptId, transcriptId) || other.transcriptId == transcriptId)&&(identical(other.title, title) || other.title == title)&&(identical(other.available, available) || other.available == available));
}


@override
int get hashCode {
    return Object.hash(runtimeType,transcriptId,title,available);
}

@override
String toString() {
    return 'NoteOrigin(transcriptId: $transcriptId, title: $title, available: $available)';
}


}

/// @nodoc
abstract mixin class _$NoteOriginCopyWith<$Res> implements $NoteOriginCopyWith<$Res> {
  factory _$NoteOriginCopyWith(_NoteOrigin value, $Res Function(_NoteOrigin) _then) = __$NoteOriginCopyWithImpl;
@override @useResult
$Res call({
 String transcriptId, String title, bool available
});




}
/// @nodoc
class __$NoteOriginCopyWithImpl<$Res>
    implements _$NoteOriginCopyWith<$Res> {
  __$NoteOriginCopyWithImpl(this._self, this._then);

  final _NoteOrigin _self;
  final $Res Function(_NoteOrigin) _then;

/// Create a copy of NoteOrigin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transcriptId = null,Object? title = null,Object? available = null,}) {
  return _then(_NoteOrigin(
transcriptId: null == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Note {

 String get id; String get title; List<NoteBlock> get blocks; NoteSourceKind get sourceKind; NoteOrigin? get origin;/// Sent back with every change; a stale one is refused with 409.
 int get revision; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteCopyWith<Note> get copyWith => _$NoteCopyWithImpl<Note>(this as Note, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Note;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Note&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&const DeepCollectionEquality().equals(other.blocks, _this.blocks)&&(identical(other.sourceKind, _this.sourceKind) || other.sourceKind == _this.sourceKind)&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.revision, _this.revision) || other.revision == _this.revision)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Note;
  return Object.hash(runtimeType,_this.id,_this.title,const DeepCollectionEquality().hash(_this.blocks),_this.sourceKind,_this.origin,_this.revision,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Note;
  return 'Note(id: ${_this.id}, title: ${_this.title}, blocks: ${_this.blocks}, sourceKind: ${_this.sourceKind}, origin: ${_this.origin}, revision: ${_this.revision}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $NoteCopyWith<$Res>  {
  factory $NoteCopyWith(Note value, $Res Function(Note) _then) = _$NoteCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<NoteBlock> blocks, NoteSourceKind sourceKind, NoteOrigin? origin, int revision, DateTime? createdAt, DateTime? updatedAt
});


$NoteOriginCopyWith<$Res>? get origin;

}
/// @nodoc
class _$NoteCopyWithImpl<$Res>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._self, this._then);

  final Note _self;
  final $Res Function(Note) _then;

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? blocks = null,Object? sourceKind = null,Object? origin = freezed,Object? revision = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(Note(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<NoteBlock>,sourceKind: null == sourceKind ? _self.sourceKind : sourceKind // ignore: cast_nullable_to_non_nullable
as NoteSourceKind,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as NoteOrigin?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteOriginCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $NoteOriginCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}


/// Adds pattern-matching-related methods to [Note].
extension NotePatterns on Note {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Note value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Note() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Note value)  $default,){
final _that = this;
switch (_that) {
case _Note():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Note value)?  $default,){
final _that = this;
switch (_that) {
case _Note() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<NoteBlock> blocks,  NoteSourceKind sourceKind,  NoteOrigin? origin,  int revision,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Note() when $default != null:
return $default(_that.id,_that.title,_that.blocks,_that.sourceKind,_that.origin,_that.revision,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<NoteBlock> blocks,  NoteSourceKind sourceKind,  NoteOrigin? origin,  int revision,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Note():
return $default(_that.id,_that.title,_that.blocks,_that.sourceKind,_that.origin,_that.revision,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<NoteBlock> blocks,  NoteSourceKind sourceKind,  NoteOrigin? origin,  int revision,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Note() when $default != null:
return $default(_that.id,_that.title,_that.blocks,_that.sourceKind,_that.origin,_that.revision,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Note implements Note {
  const _Note({required this.id, this.title = '',  List<NoteBlock> blocks = const <NoteBlock>[], this.sourceKind = NoteSourceKind.unknown, this.origin, this.revision = 0, this.createdAt, this.updatedAt}): _blocks = blocks;
  

@override final  String id;
@override@JsonKey() final  String title;
 final  List<NoteBlock> _blocks;
@override@JsonKey() List<NoteBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

@override@JsonKey() final  NoteSourceKind sourceKind;
@override final  NoteOrigin? origin;
/// Sent back with every change; a stale one is refused with 409.
@override@JsonKey() final  int revision;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteCopyWith<_Note> get copyWith => __$NoteCopyWithImpl<_Note>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Note&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.blocks, _blocks)&&(identical(other.sourceKind, sourceKind) || other.sourceKind == sourceKind)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_blocks),sourceKind,origin,revision,createdAt,updatedAt);
}

@override
String toString() {
    return 'Note(id: $id, title: $title, blocks: $blocks, sourceKind: $sourceKind, origin: $origin, revision: $revision, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$NoteCopyWith(_Note value, $Res Function(_Note) _then) = __$NoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<NoteBlock> blocks, NoteSourceKind sourceKind, NoteOrigin? origin, int revision, DateTime? createdAt, DateTime? updatedAt
});


@override $NoteOriginCopyWith<$Res>? get origin;

}
/// @nodoc
class __$NoteCopyWithImpl<$Res>
    implements _$NoteCopyWith<$Res> {
  __$NoteCopyWithImpl(this._self, this._then);

  final _Note _self;
  final $Res Function(_Note) _then;

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? blocks = null,Object? sourceKind = null,Object? origin = freezed,Object? revision = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Note(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<NoteBlock>,sourceKind: null == sourceKind ? _self.sourceKind : sourceKind // ignore: cast_nullable_to_non_nullable
as NoteSourceKind,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as NoteOrigin?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Note
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteOriginCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $NoteOriginCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}

// dart format on
