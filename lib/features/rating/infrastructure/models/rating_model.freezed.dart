// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RatingModel {

@JsonKey(name: 'score') int get score;@JsonKey(name: 'note') String get note;
/// Create a copy of RatingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingModelCopyWith<RatingModel> get copyWith => _$RatingModelCopyWithImpl<RatingModel>(this as RatingModel, _$identity);

  /// Serializes this RatingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RatingModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingModel&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RatingModel;
  return Object.hash(runtimeType,_this.score,_this.note);
}

@override
String toString() {
  final _this = this as RatingModel;
  return 'RatingModel(score: ${_this.score}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $RatingModelCopyWith<$Res>  {
  factory $RatingModelCopyWith(RatingModel value, $Res Function(RatingModel) _then) = _$RatingModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'score') int score,@JsonKey(name: 'note') String note
});




}
/// @nodoc
class _$RatingModelCopyWithImpl<$Res>
    implements $RatingModelCopyWith<$Res> {
  _$RatingModelCopyWithImpl(this._self, this._then);

  final RatingModel _self;
  final $Res Function(RatingModel) _then;

/// Create a copy of RatingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? note = null,}) {
  return _then(RatingModel(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RatingModel].
extension RatingModelPatterns on RatingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingModel value)  $default,){
final _that = this;
switch (_that) {
case _RatingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingModel value)?  $default,){
final _that = this;
switch (_that) {
case _RatingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'score')  int score, @JsonKey(name: 'note')  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingModel() when $default != null:
return $default(_that.score,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'score')  int score, @JsonKey(name: 'note')  String note)  $default,) {final _that = this;
switch (_that) {
case _RatingModel():
return $default(_that.score,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'score')  int score, @JsonKey(name: 'note')  String note)?  $default,) {final _that = this;
switch (_that) {
case _RatingModel() when $default != null:
return $default(_that.score,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatingModel extends RatingModel {
  const _RatingModel({@JsonKey(name: 'score') this.score = 0, @JsonKey(name: 'note') this.note = ''}): super._();
  factory _RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);

@override@JsonKey(name: 'score') final  int score;
@override@JsonKey(name: 'note') final  String note;

/// Create a copy of RatingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingModelCopyWith<_RatingModel> get copyWith => __$RatingModelCopyWithImpl<_RatingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingModel&&(identical(other.score, score) || other.score == score)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,score,note);
}

@override
String toString() {
    return 'RatingModel(score: $score, note: $note)';
}


}

/// @nodoc
abstract mixin class _$RatingModelCopyWith<$Res> implements $RatingModelCopyWith<$Res> {
  factory _$RatingModelCopyWith(_RatingModel value, $Res Function(_RatingModel) _then) = __$RatingModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'score') int score,@JsonKey(name: 'note') String note
});




}
/// @nodoc
class __$RatingModelCopyWithImpl<$Res>
    implements _$RatingModelCopyWith<$Res> {
  __$RatingModelCopyWithImpl(this._self, this._then);

  final _RatingModel _self;
  final $Res Function(_RatingModel) _then;

/// Create a copy of RatingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? note = null,}) {
  return _then(_RatingModel(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RatingEnvelopeModel {

@JsonKey(name: 'rating') RatingModel? get rating;
/// Create a copy of RatingEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingEnvelopeModelCopyWith<RatingEnvelopeModel> get copyWith => _$RatingEnvelopeModelCopyWithImpl<RatingEnvelopeModel>(this as RatingEnvelopeModel, _$identity);

  /// Serializes this RatingEnvelopeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RatingEnvelopeModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingEnvelopeModel&&(identical(other.rating, _this.rating) || other.rating == _this.rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RatingEnvelopeModel;
  return Object.hash(runtimeType,_this.rating);
}

@override
String toString() {
  final _this = this as RatingEnvelopeModel;
  return 'RatingEnvelopeModel(rating: ${_this.rating})';
}


}

/// @nodoc
abstract mixin class $RatingEnvelopeModelCopyWith<$Res>  {
  factory $RatingEnvelopeModelCopyWith(RatingEnvelopeModel value, $Res Function(RatingEnvelopeModel) _then) = _$RatingEnvelopeModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'rating') RatingModel? rating
});


$RatingModelCopyWith<$Res>? get rating;

}
/// @nodoc
class _$RatingEnvelopeModelCopyWithImpl<$Res>
    implements $RatingEnvelopeModelCopyWith<$Res> {
  _$RatingEnvelopeModelCopyWithImpl(this._self, this._then);

  final RatingEnvelopeModel _self;
  final $Res Function(RatingEnvelopeModel) _then;

/// Create a copy of RatingEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = freezed,}) {
  return _then(RatingEnvelopeModel(
rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RatingModel?,
  ));
}
/// Create a copy of RatingEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RatingModelCopyWith<$Res>? get rating {
    if (_self.rating == null) {
    return null;
  }

  return $RatingModelCopyWith<$Res>(_self.rating!, (value) {
    return _then(_self.copyWith(rating: value));
  });
}
}


/// Adds pattern-matching-related methods to [RatingEnvelopeModel].
extension RatingEnvelopeModelPatterns on RatingEnvelopeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingEnvelopeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingEnvelopeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingEnvelopeModel value)  $default,){
final _that = this;
switch (_that) {
case _RatingEnvelopeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingEnvelopeModel value)?  $default,){
final _that = this;
switch (_that) {
case _RatingEnvelopeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'rating')  RatingModel? rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingEnvelopeModel() when $default != null:
return $default(_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'rating')  RatingModel? rating)  $default,) {final _that = this;
switch (_that) {
case _RatingEnvelopeModel():
return $default(_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'rating')  RatingModel? rating)?  $default,) {final _that = this;
switch (_that) {
case _RatingEnvelopeModel() when $default != null:
return $default(_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatingEnvelopeModel implements RatingEnvelopeModel {
  const _RatingEnvelopeModel({@JsonKey(name: 'rating') this.rating});
  factory _RatingEnvelopeModel.fromJson(Map<String, dynamic> json) => _$RatingEnvelopeModelFromJson(json);

@override@JsonKey(name: 'rating') final  RatingModel? rating;

/// Create a copy of RatingEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingEnvelopeModelCopyWith<_RatingEnvelopeModel> get copyWith => __$RatingEnvelopeModelCopyWithImpl<_RatingEnvelopeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingEnvelopeModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingEnvelopeModel&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,rating);
}

@override
String toString() {
    return 'RatingEnvelopeModel(rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$RatingEnvelopeModelCopyWith<$Res> implements $RatingEnvelopeModelCopyWith<$Res> {
  factory _$RatingEnvelopeModelCopyWith(_RatingEnvelopeModel value, $Res Function(_RatingEnvelopeModel) _then) = __$RatingEnvelopeModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'rating') RatingModel? rating
});


@override $RatingModelCopyWith<$Res>? get rating;

}
/// @nodoc
class __$RatingEnvelopeModelCopyWithImpl<$Res>
    implements _$RatingEnvelopeModelCopyWith<$Res> {
  __$RatingEnvelopeModelCopyWithImpl(this._self, this._then);

  final _RatingEnvelopeModel _self;
  final $Res Function(_RatingEnvelopeModel) _then;

/// Create a copy of RatingEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = freezed,}) {
  return _then(_RatingEnvelopeModel(
rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RatingModel?,
  ));
}

/// Create a copy of RatingEnvelopeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RatingModelCopyWith<$Res>? get rating {
    if (_self.rating == null) {
    return null;
  }

  return $RatingModelCopyWith<$Res>(_self.rating!, (value) {
    return _then(_self.copyWith(rating: value));
  });
}
}

// dart format on
