// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Flashcard {

 String get front; String get back;/// The sentence as it was said.
 String get source;
/// Create a copy of Flashcard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardCopyWith<Flashcard> get copyWith => _$FlashcardCopyWithImpl<Flashcard>(this as Flashcard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Flashcard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Flashcard&&(identical(other.front, _this.front) || other.front == _this.front)&&(identical(other.back, _this.back) || other.back == _this.back)&&(identical(other.source, _this.source) || other.source == _this.source));
}


@override
int get hashCode {
  final _this = this as Flashcard;
  return Object.hash(runtimeType,_this.front,_this.back,_this.source);
}

@override
String toString() {
  final _this = this as Flashcard;
  return 'Flashcard(front: ${_this.front}, back: ${_this.back}, source: ${_this.source})';
}


}

/// @nodoc
abstract mixin class $FlashcardCopyWith<$Res>  {
  factory $FlashcardCopyWith(Flashcard value, $Res Function(Flashcard) _then) = _$FlashcardCopyWithImpl;
@useResult
$Res call({
 String front, String back, String source
});




}
/// @nodoc
class _$FlashcardCopyWithImpl<$Res>
    implements $FlashcardCopyWith<$Res> {
  _$FlashcardCopyWithImpl(this._self, this._then);

  final Flashcard _self;
  final $Res Function(Flashcard) _then;

/// Create a copy of Flashcard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? front = null,Object? back = null,Object? source = null,}) {
  return _then(Flashcard(
front: null == front ? _self.front : front // ignore: cast_nullable_to_non_nullable
as String,back: null == back ? _self.back : back // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Flashcard].
extension FlashcardPatterns on Flashcard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Flashcard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Flashcard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Flashcard value)  $default,){
final _that = this;
switch (_that) {
case _Flashcard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Flashcard value)?  $default,){
final _that = this;
switch (_that) {
case _Flashcard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String front,  String back,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Flashcard() when $default != null:
return $default(_that.front,_that.back,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String front,  String back,  String source)  $default,) {final _that = this;
switch (_that) {
case _Flashcard():
return $default(_that.front,_that.back,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String front,  String back,  String source)?  $default,) {final _that = this;
switch (_that) {
case _Flashcard() when $default != null:
return $default(_that.front,_that.back,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _Flashcard implements Flashcard {
  const _Flashcard({required this.front, required this.back, required this.source});
  

@override final  String front;
@override final  String back;
/// The sentence as it was said.
@override final  String source;

/// Create a copy of Flashcard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashcardCopyWith<_Flashcard> get copyWith => __$FlashcardCopyWithImpl<_Flashcard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Flashcard&&(identical(other.front, front) || other.front == front)&&(identical(other.back, back) || other.back == back)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode {
    return Object.hash(runtimeType,front,back,source);
}

@override
String toString() {
    return 'Flashcard(front: $front, back: $back, source: $source)';
}


}

/// @nodoc
abstract mixin class _$FlashcardCopyWith<$Res> implements $FlashcardCopyWith<$Res> {
  factory _$FlashcardCopyWith(_Flashcard value, $Res Function(_Flashcard) _then) = __$FlashcardCopyWithImpl;
@override @useResult
$Res call({
 String front, String back, String source
});




}
/// @nodoc
class __$FlashcardCopyWithImpl<$Res>
    implements _$FlashcardCopyWith<$Res> {
  __$FlashcardCopyWithImpl(this._self, this._then);

  final _Flashcard _self;
  final $Res Function(_Flashcard) _then;

/// Create a copy of Flashcard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? front = null,Object? back = null,Object? source = null,}) {
  return _then(_Flashcard(
front: null == front ? _self.front : front // ignore: cast_nullable_to_non_nullable
as String,back: null == back ? _self.back : back // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$QuizQuestion {

 QuizQuestionType get type; String get prompt; int get correctIndex; String get source; List<String> get options;
/// Create a copy of QuizQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizQuestionCopyWith<QuizQuestion> get copyWith => _$QuizQuestionCopyWithImpl<QuizQuestion>(this as QuizQuestion, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuizQuestion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizQuestion&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.correctIndex, _this.correctIndex) || other.correctIndex == _this.correctIndex)&&(identical(other.source, _this.source) || other.source == _this.source)&&const DeepCollectionEquality().equals(other.options, _this.options));
}


@override
int get hashCode {
  final _this = this as QuizQuestion;
  return Object.hash(runtimeType,_this.type,_this.prompt,_this.correctIndex,_this.source,const DeepCollectionEquality().hash(_this.options));
}

@override
String toString() {
  final _this = this as QuizQuestion;
  return 'QuizQuestion(type: ${_this.type}, prompt: ${_this.prompt}, correctIndex: ${_this.correctIndex}, source: ${_this.source}, options: ${_this.options})';
}


}

/// @nodoc
abstract mixin class $QuizQuestionCopyWith<$Res>  {
  factory $QuizQuestionCopyWith(QuizQuestion value, $Res Function(QuizQuestion) _then) = _$QuizQuestionCopyWithImpl;
@useResult
$Res call({
 QuizQuestionType type, String prompt, int correctIndex, String source, List<String> options
});




}
/// @nodoc
class _$QuizQuestionCopyWithImpl<$Res>
    implements $QuizQuestionCopyWith<$Res> {
  _$QuizQuestionCopyWithImpl(this._self, this._then);

  final QuizQuestion _self;
  final $Res Function(QuizQuestion) _then;

/// Create a copy of QuizQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? prompt = null,Object? correctIndex = null,Object? source = null,Object? options = null,}) {
  return _then(QuizQuestion(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuizQuestionType,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizQuestion].
extension QuizQuestionPatterns on QuizQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizQuestion value)  $default,){
final _that = this;
switch (_that) {
case _QuizQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _QuizQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuizQuestionType type,  String prompt,  int correctIndex,  String source,  List<String> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizQuestion() when $default != null:
return $default(_that.type,_that.prompt,_that.correctIndex,_that.source,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuizQuestionType type,  String prompt,  int correctIndex,  String source,  List<String> options)  $default,) {final _that = this;
switch (_that) {
case _QuizQuestion():
return $default(_that.type,_that.prompt,_that.correctIndex,_that.source,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuizQuestionType type,  String prompt,  int correctIndex,  String source,  List<String> options)?  $default,) {final _that = this;
switch (_that) {
case _QuizQuestion() when $default != null:
return $default(_that.type,_that.prompt,_that.correctIndex,_that.source,_that.options);case _:
  return null;

}
}

}

/// @nodoc


class _QuizQuestion extends QuizQuestion {
  const _QuizQuestion({required this.type, required this.prompt, required this.correctIndex, required this.source,  List<String> options = const <String>[]}): _options = options,super._();
  

@override final  QuizQuestionType type;
@override final  String prompt;
@override final  int correctIndex;
@override final  String source;
 final  List<String> _options;
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of QuizQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizQuestionCopyWith<_QuizQuestion> get copyWith => __$QuizQuestionCopyWithImpl<_QuizQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizQuestion&&(identical(other.type, type) || other.type == type)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.options, _options));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,prompt,correctIndex,source,const DeepCollectionEquality().hash(_options));
}

@override
String toString() {
    return 'QuizQuestion(type: $type, prompt: $prompt, correctIndex: $correctIndex, source: $source, options: $options)';
}


}

/// @nodoc
abstract mixin class _$QuizQuestionCopyWith<$Res> implements $QuizQuestionCopyWith<$Res> {
  factory _$QuizQuestionCopyWith(_QuizQuestion value, $Res Function(_QuizQuestion) _then) = __$QuizQuestionCopyWithImpl;
@override @useResult
$Res call({
 QuizQuestionType type, String prompt, int correctIndex, String source, List<String> options
});




}
/// @nodoc
class __$QuizQuestionCopyWithImpl<$Res>
    implements _$QuizQuestionCopyWith<$Res> {
  __$QuizQuestionCopyWithImpl(this._self, this._then);

  final _QuizQuestion _self;
  final $Res Function(_QuizQuestion) _then;

/// Create a copy of QuizQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? prompt = null,Object? correctIndex = null,Object? source = null,Object? options = null,}) {
  return _then(_QuizQuestion(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuizQuestionType,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$FlashcardSet {

 String get id; LearnDifficulty get difficulty; DateTime get createdAt; List<Flashcard> get cards;
/// Create a copy of FlashcardSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardSetCopyWith<FlashcardSet> get copyWith => _$FlashcardSetCopyWithImpl<FlashcardSet>(this as FlashcardSet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FlashcardSet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashcardSet&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&const DeepCollectionEquality().equals(other.cards, _this.cards));
}


@override
int get hashCode {
  final _this = this as FlashcardSet;
  return Object.hash(runtimeType,_this.id,_this.difficulty,_this.createdAt,const DeepCollectionEquality().hash(_this.cards));
}

@override
String toString() {
  final _this = this as FlashcardSet;
  return 'FlashcardSet(id: ${_this.id}, difficulty: ${_this.difficulty}, createdAt: ${_this.createdAt}, cards: ${_this.cards})';
}


}

/// @nodoc
abstract mixin class $FlashcardSetCopyWith<$Res>  {
  factory $FlashcardSetCopyWith(FlashcardSet value, $Res Function(FlashcardSet) _then) = _$FlashcardSetCopyWithImpl;
@useResult
$Res call({
 String id, LearnDifficulty difficulty, DateTime createdAt, List<Flashcard> cards
});




}
/// @nodoc
class _$FlashcardSetCopyWithImpl<$Res>
    implements $FlashcardSetCopyWith<$Res> {
  _$FlashcardSetCopyWithImpl(this._self, this._then);

  final FlashcardSet _self;
  final $Res Function(FlashcardSet) _then;

/// Create a copy of FlashcardSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? difficulty = null,Object? createdAt = null,Object? cards = null,}) {
  return _then(FlashcardSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as LearnDifficulty,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<Flashcard>,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashcardSet].
extension FlashcardSetPatterns on FlashcardSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashcardSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashcardSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashcardSet value)  $default,){
final _that = this;
switch (_that) {
case _FlashcardSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashcardSet value)?  $default,){
final _that = this;
switch (_that) {
case _FlashcardSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LearnDifficulty difficulty,  DateTime createdAt,  List<Flashcard> cards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashcardSet() when $default != null:
return $default(_that.id,_that.difficulty,_that.createdAt,_that.cards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LearnDifficulty difficulty,  DateTime createdAt,  List<Flashcard> cards)  $default,) {final _that = this;
switch (_that) {
case _FlashcardSet():
return $default(_that.id,_that.difficulty,_that.createdAt,_that.cards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LearnDifficulty difficulty,  DateTime createdAt,  List<Flashcard> cards)?  $default,) {final _that = this;
switch (_that) {
case _FlashcardSet() when $default != null:
return $default(_that.id,_that.difficulty,_that.createdAt,_that.cards);case _:
  return null;

}
}

}

/// @nodoc


class _FlashcardSet implements FlashcardSet {
  const _FlashcardSet({required this.id, required this.difficulty, required this.createdAt,  List<Flashcard> cards = const <Flashcard>[]}): _cards = cards;
  

@override final  String id;
@override final  LearnDifficulty difficulty;
@override final  DateTime createdAt;
 final  List<Flashcard> _cards;
@override@JsonKey() List<Flashcard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of FlashcardSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashcardSetCopyWith<_FlashcardSet> get copyWith => __$FlashcardSetCopyWithImpl<_FlashcardSet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashcardSet&&(identical(other.id, id) || other.id == id)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.cards, _cards));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,difficulty,createdAt,const DeepCollectionEquality().hash(_cards));
}

@override
String toString() {
    return 'FlashcardSet(id: $id, difficulty: $difficulty, createdAt: $createdAt, cards: $cards)';
}


}

/// @nodoc
abstract mixin class _$FlashcardSetCopyWith<$Res> implements $FlashcardSetCopyWith<$Res> {
  factory _$FlashcardSetCopyWith(_FlashcardSet value, $Res Function(_FlashcardSet) _then) = __$FlashcardSetCopyWithImpl;
@override @useResult
$Res call({
 String id, LearnDifficulty difficulty, DateTime createdAt, List<Flashcard> cards
});




}
/// @nodoc
class __$FlashcardSetCopyWithImpl<$Res>
    implements _$FlashcardSetCopyWith<$Res> {
  __$FlashcardSetCopyWithImpl(this._self, this._then);

  final _FlashcardSet _self;
  final $Res Function(_FlashcardSet) _then;

/// Create a copy of FlashcardSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? difficulty = null,Object? createdAt = null,Object? cards = null,}) {
  return _then(_FlashcardSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as LearnDifficulty,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<Flashcard>,
  ));
}


}

/// @nodoc
mixin _$QuizSet {

 String get id; LearnDifficulty get difficulty; DateTime get createdAt; List<QuizQuestionType> get types; List<QuizQuestion> get questions;
/// Create a copy of QuizSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizSetCopyWith<QuizSet> get copyWith => _$QuizSetCopyWithImpl<QuizSet>(this as QuizSet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuizSet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizSet&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&const DeepCollectionEquality().equals(other.types, _this.types)&&const DeepCollectionEquality().equals(other.questions, _this.questions));
}


@override
int get hashCode {
  final _this = this as QuizSet;
  return Object.hash(runtimeType,_this.id,_this.difficulty,_this.createdAt,const DeepCollectionEquality().hash(_this.types),const DeepCollectionEquality().hash(_this.questions));
}

@override
String toString() {
  final _this = this as QuizSet;
  return 'QuizSet(id: ${_this.id}, difficulty: ${_this.difficulty}, createdAt: ${_this.createdAt}, types: ${_this.types}, questions: ${_this.questions})';
}


}

/// @nodoc
abstract mixin class $QuizSetCopyWith<$Res>  {
  factory $QuizSetCopyWith(QuizSet value, $Res Function(QuizSet) _then) = _$QuizSetCopyWithImpl;
@useResult
$Res call({
 String id, LearnDifficulty difficulty, DateTime createdAt, List<QuizQuestionType> types, List<QuizQuestion> questions
});




}
/// @nodoc
class _$QuizSetCopyWithImpl<$Res>
    implements $QuizSetCopyWith<$Res> {
  _$QuizSetCopyWithImpl(this._self, this._then);

  final QuizSet _self;
  final $Res Function(QuizSet) _then;

/// Create a copy of QuizSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? difficulty = null,Object? createdAt = null,Object? types = null,Object? questions = null,}) {
  return _then(QuizSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as LearnDifficulty,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<QuizQuestionType>,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuizQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizSet].
extension QuizSetPatterns on QuizSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizSet value)  $default,){
final _that = this;
switch (_that) {
case _QuizSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizSet value)?  $default,){
final _that = this;
switch (_that) {
case _QuizSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LearnDifficulty difficulty,  DateTime createdAt,  List<QuizQuestionType> types,  List<QuizQuestion> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizSet() when $default != null:
return $default(_that.id,_that.difficulty,_that.createdAt,_that.types,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LearnDifficulty difficulty,  DateTime createdAt,  List<QuizQuestionType> types,  List<QuizQuestion> questions)  $default,) {final _that = this;
switch (_that) {
case _QuizSet():
return $default(_that.id,_that.difficulty,_that.createdAt,_that.types,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LearnDifficulty difficulty,  DateTime createdAt,  List<QuizQuestionType> types,  List<QuizQuestion> questions)?  $default,) {final _that = this;
switch (_that) {
case _QuizSet() when $default != null:
return $default(_that.id,_that.difficulty,_that.createdAt,_that.types,_that.questions);case _:
  return null;

}
}

}

/// @nodoc


class _QuizSet implements QuizSet {
  const _QuizSet({required this.id, required this.difficulty, required this.createdAt,  List<QuizQuestionType> types = const <QuizQuestionType>[],  List<QuizQuestion> questions = const <QuizQuestion>[]}): _types = types,_questions = questions;
  

@override final  String id;
@override final  LearnDifficulty difficulty;
@override final  DateTime createdAt;
 final  List<QuizQuestionType> _types;
@override@JsonKey() List<QuizQuestionType> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

 final  List<QuizQuestion> _questions;
@override@JsonKey() List<QuizQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of QuizSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizSetCopyWith<_QuizSet> get copyWith => __$QuizSetCopyWithImpl<_QuizSet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizSet&&(identical(other.id, id) || other.id == id)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.types, _types)&&const DeepCollectionEquality().equals(other.questions, _questions));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,difficulty,createdAt,const DeepCollectionEquality().hash(_types),const DeepCollectionEquality().hash(_questions));
}

@override
String toString() {
    return 'QuizSet(id: $id, difficulty: $difficulty, createdAt: $createdAt, types: $types, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$QuizSetCopyWith<$Res> implements $QuizSetCopyWith<$Res> {
  factory _$QuizSetCopyWith(_QuizSet value, $Res Function(_QuizSet) _then) = __$QuizSetCopyWithImpl;
@override @useResult
$Res call({
 String id, LearnDifficulty difficulty, DateTime createdAt, List<QuizQuestionType> types, List<QuizQuestion> questions
});




}
/// @nodoc
class __$QuizSetCopyWithImpl<$Res>
    implements _$QuizSetCopyWith<$Res> {
  __$QuizSetCopyWithImpl(this._self, this._then);

  final _QuizSet _self;
  final $Res Function(_QuizSet) _then;

/// Create a copy of QuizSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? difficulty = null,Object? createdAt = null,Object? types = null,Object? questions = null,}) {
  return _then(_QuizSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as LearnDifficulty,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<QuizQuestionType>,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuizQuestion>,
  ));
}


}

/// @nodoc
mixin _$LearnSets {

 List<FlashcardSet> get flashcards; List<QuizSet> get quizzes;
/// Create a copy of LearnSets
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnSetsCopyWith<LearnSets> get copyWith => _$LearnSetsCopyWithImpl<LearnSets>(this as LearnSets, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LearnSets;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnSets&&const DeepCollectionEquality().equals(other.flashcards, _this.flashcards)&&const DeepCollectionEquality().equals(other.quizzes, _this.quizzes));
}


@override
int get hashCode {
  final _this = this as LearnSets;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.flashcards),const DeepCollectionEquality().hash(_this.quizzes));
}

@override
String toString() {
  final _this = this as LearnSets;
  return 'LearnSets(flashcards: ${_this.flashcards}, quizzes: ${_this.quizzes})';
}


}

/// @nodoc
abstract mixin class $LearnSetsCopyWith<$Res>  {
  factory $LearnSetsCopyWith(LearnSets value, $Res Function(LearnSets) _then) = _$LearnSetsCopyWithImpl;
@useResult
$Res call({
 List<FlashcardSet> flashcards, List<QuizSet> quizzes
});




}
/// @nodoc
class _$LearnSetsCopyWithImpl<$Res>
    implements $LearnSetsCopyWith<$Res> {
  _$LearnSetsCopyWithImpl(this._self, this._then);

  final LearnSets _self;
  final $Res Function(LearnSets) _then;

/// Create a copy of LearnSets
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flashcards = null,Object? quizzes = null,}) {
  return _then(LearnSets(
flashcards: null == flashcards ? _self.flashcards : flashcards // ignore: cast_nullable_to_non_nullable
as List<FlashcardSet>,quizzes: null == quizzes ? _self.quizzes : quizzes // ignore: cast_nullable_to_non_nullable
as List<QuizSet>,
  ));
}

}


/// Adds pattern-matching-related methods to [LearnSets].
extension LearnSetsPatterns on LearnSets {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearnSets value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearnSets() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearnSets value)  $default,){
final _that = this;
switch (_that) {
case _LearnSets():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearnSets value)?  $default,){
final _that = this;
switch (_that) {
case _LearnSets() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FlashcardSet> flashcards,  List<QuizSet> quizzes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearnSets() when $default != null:
return $default(_that.flashcards,_that.quizzes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FlashcardSet> flashcards,  List<QuizSet> quizzes)  $default,) {final _that = this;
switch (_that) {
case _LearnSets():
return $default(_that.flashcards,_that.quizzes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FlashcardSet> flashcards,  List<QuizSet> quizzes)?  $default,) {final _that = this;
switch (_that) {
case _LearnSets() when $default != null:
return $default(_that.flashcards,_that.quizzes);case _:
  return null;

}
}

}

/// @nodoc


class _LearnSets extends LearnSets {
  const _LearnSets({ List<FlashcardSet> flashcards = const <FlashcardSet>[],  List<QuizSet> quizzes = const <QuizSet>[]}): _flashcards = flashcards,_quizzes = quizzes,super._();
  

 final  List<FlashcardSet> _flashcards;
@override@JsonKey() List<FlashcardSet> get flashcards {
  if (_flashcards is EqualUnmodifiableListView) return _flashcards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flashcards);
}

 final  List<QuizSet> _quizzes;
@override@JsonKey() List<QuizSet> get quizzes {
  if (_quizzes is EqualUnmodifiableListView) return _quizzes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quizzes);
}


/// Create a copy of LearnSets
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearnSetsCopyWith<_LearnSets> get copyWith => __$LearnSetsCopyWithImpl<_LearnSets>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearnSets&&const DeepCollectionEquality().equals(other.flashcards, _flashcards)&&const DeepCollectionEquality().equals(other.quizzes, _quizzes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_flashcards),const DeepCollectionEquality().hash(_quizzes));
}

@override
String toString() {
    return 'LearnSets(flashcards: $flashcards, quizzes: $quizzes)';
}


}

/// @nodoc
abstract mixin class _$LearnSetsCopyWith<$Res> implements $LearnSetsCopyWith<$Res> {
  factory _$LearnSetsCopyWith(_LearnSets value, $Res Function(_LearnSets) _then) = __$LearnSetsCopyWithImpl;
@override @useResult
$Res call({
 List<FlashcardSet> flashcards, List<QuizSet> quizzes
});




}
/// @nodoc
class __$LearnSetsCopyWithImpl<$Res>
    implements _$LearnSetsCopyWith<$Res> {
  __$LearnSetsCopyWithImpl(this._self, this._then);

  final _LearnSets _self;
  final $Res Function(_LearnSets) _then;

/// Create a copy of LearnSets
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flashcards = null,Object? quizzes = null,}) {
  return _then(_LearnSets(
flashcards: null == flashcards ? _self._flashcards : flashcards // ignore: cast_nullable_to_non_nullable
as List<FlashcardSet>,quizzes: null == quizzes ? _self._quizzes : quizzes // ignore: cast_nullable_to_non_nullable
as List<QuizSet>,
  ));
}


}

// dart format on
