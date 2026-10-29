// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workspace_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkspaceListModel {

@JsonKey(name: 'items') List<WorkspaceModel> get items;
/// Create a copy of WorkspaceListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkspaceListModelCopyWith<WorkspaceListModel> get copyWith => _$WorkspaceListModelCopyWithImpl<WorkspaceListModel>(this as WorkspaceListModel, _$identity);

  /// Serializes this WorkspaceListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkspaceListModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkspaceListModel&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkspaceListModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as WorkspaceListModel;
  return 'WorkspaceListModel(items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $WorkspaceListModelCopyWith<$Res>  {
  factory $WorkspaceListModelCopyWith(WorkspaceListModel value, $Res Function(WorkspaceListModel) _then) = _$WorkspaceListModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'items') List<WorkspaceModel> items
});




}
/// @nodoc
class _$WorkspaceListModelCopyWithImpl<$Res>
    implements $WorkspaceListModelCopyWith<$Res> {
  _$WorkspaceListModelCopyWithImpl(this._self, this._then);

  final WorkspaceListModel _self;
  final $Res Function(WorkspaceListModel) _then;

/// Create a copy of WorkspaceListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(WorkspaceListModel(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<WorkspaceModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkspaceListModel].
extension WorkspaceListModelPatterns on WorkspaceListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkspaceListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkspaceListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkspaceListModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkspaceListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkspaceListModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkspaceListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<WorkspaceModel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkspaceListModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'items')  List<WorkspaceModel> items)  $default,) {final _that = this;
switch (_that) {
case _WorkspaceListModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'items')  List<WorkspaceModel> items)?  $default,) {final _that = this;
switch (_that) {
case _WorkspaceListModel() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkspaceListModel implements WorkspaceListModel {
  const _WorkspaceListModel({@JsonKey(name: 'items')  List<WorkspaceModel> items = const <WorkspaceModel>[]}): _items = items;
  factory _WorkspaceListModel.fromJson(Map<String, dynamic> json) => _$WorkspaceListModelFromJson(json);

 final  List<WorkspaceModel> _items;
@override@JsonKey(name: 'items') List<WorkspaceModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of WorkspaceListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkspaceListModelCopyWith<_WorkspaceListModel> get copyWith => __$WorkspaceListModelCopyWithImpl<_WorkspaceListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkspaceListModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkspaceListModel&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'WorkspaceListModel(items: $items)';
}


}

/// @nodoc
abstract mixin class _$WorkspaceListModelCopyWith<$Res> implements $WorkspaceListModelCopyWith<$Res> {
  factory _$WorkspaceListModelCopyWith(_WorkspaceListModel value, $Res Function(_WorkspaceListModel) _then) = __$WorkspaceListModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'items') List<WorkspaceModel> items
});




}
/// @nodoc
class __$WorkspaceListModelCopyWithImpl<$Res>
    implements _$WorkspaceListModelCopyWith<$Res> {
  __$WorkspaceListModelCopyWithImpl(this._self, this._then);

  final _WorkspaceListModel _self;
  final $Res Function(_WorkspaceListModel) _then;

/// Create a copy of WorkspaceListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_WorkspaceListModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<WorkspaceModel>,
  ));
}


}

// dart format on
