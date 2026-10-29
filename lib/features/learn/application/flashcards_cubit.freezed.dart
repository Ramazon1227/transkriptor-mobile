// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashcards_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlashcardsState {

 List<Flashcard> get cards; int get index;/// The back (the answer) is showing.
 bool get flipped;/// Card indexes marked «Bilaman» / «Takrorlash»; a card is in at most
/// one of them.
 Set<int> get known; Set<int> get repeat;/// Past the last card: the result screen.
 bool get finished;
/// Create a copy of FlashcardsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardsStateCopyWith<FlashcardsState> get copyWith => _$FlashcardsStateCopyWithImpl<FlashcardsState>(this as FlashcardsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FlashcardsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashcardsState&&const DeepCollectionEquality().equals(other.cards, _this.cards)&&(identical(other.index, _this.index) || other.index == _this.index)&&(identical(other.flipped, _this.flipped) || other.flipped == _this.flipped)&&const DeepCollectionEquality().equals(other.known, _this.known)&&const DeepCollectionEquality().equals(other.repeat, _this.repeat)&&(identical(other.finished, _this.finished) || other.finished == _this.finished));
}


@override
int get hashCode {
  final _this = this as FlashcardsState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.cards),_this.index,_this.flipped,const DeepCollectionEquality().hash(_this.known),const DeepCollectionEquality().hash(_this.repeat),_this.finished);
}

@override
String toString() {
  final _this = this as FlashcardsState;
  return 'FlashcardsState(cards: ${_this.cards}, index: ${_this.index}, flipped: ${_this.flipped}, known: ${_this.known}, repeat: ${_this.repeat}, finished: ${_this.finished})';
}


}

/// @nodoc
abstract mixin class $FlashcardsStateCopyWith<$Res>  {
  factory $FlashcardsStateCopyWith(FlashcardsState value, $Res Function(FlashcardsState) _then) = _$FlashcardsStateCopyWithImpl;
@useResult
$Res call({
 List<Flashcard> cards, int index, bool flipped, Set<int> known, Set<int> repeat, bool finished
});




}
/// @nodoc
class _$FlashcardsStateCopyWithImpl<$Res>
    implements $FlashcardsStateCopyWith<$Res> {
  _$FlashcardsStateCopyWithImpl(this._self, this._then);

  final FlashcardsState _self;
  final $Res Function(FlashcardsState) _then;

/// Create a copy of FlashcardsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cards = null,Object? index = null,Object? flipped = null,Object? known = null,Object? repeat = null,Object? finished = null,}) {
  return _then(FlashcardsState(
cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<Flashcard>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,flipped: null == flipped ? _self.flipped : flipped // ignore: cast_nullable_to_non_nullable
as bool,known: null == known ? _self.known : known // ignore: cast_nullable_to_non_nullable
as Set<int>,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as Set<int>,finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashcardsState].
extension FlashcardsStatePatterns on FlashcardsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashcardsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashcardsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashcardsState value)  $default,){
final _that = this;
switch (_that) {
case _FlashcardsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashcardsState value)?  $default,){
final _that = this;
switch (_that) {
case _FlashcardsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Flashcard> cards,  int index,  bool flipped,  Set<int> known,  Set<int> repeat,  bool finished)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashcardsState() when $default != null:
return $default(_that.cards,_that.index,_that.flipped,_that.known,_that.repeat,_that.finished);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Flashcard> cards,  int index,  bool flipped,  Set<int> known,  Set<int> repeat,  bool finished)  $default,) {final _that = this;
switch (_that) {
case _FlashcardsState():
return $default(_that.cards,_that.index,_that.flipped,_that.known,_that.repeat,_that.finished);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Flashcard> cards,  int index,  bool flipped,  Set<int> known,  Set<int> repeat,  bool finished)?  $default,) {final _that = this;
switch (_that) {
case _FlashcardsState() when $default != null:
return $default(_that.cards,_that.index,_that.flipped,_that.known,_that.repeat,_that.finished);case _:
  return null;

}
}

}

/// @nodoc


class _FlashcardsState extends FlashcardsState {
  const _FlashcardsState({ List<Flashcard> cards = const <Flashcard>[], this.index = 0, this.flipped = false,  Set<int> known = const <int>{},  Set<int> repeat = const <int>{}, this.finished = false}): _cards = cards,_known = known,_repeat = repeat,super._();
  

 final  List<Flashcard> _cards;
@override@JsonKey() List<Flashcard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override@JsonKey() final  int index;
/// The back (the answer) is showing.
@override@JsonKey() final  bool flipped;
/// Card indexes marked «Bilaman» / «Takrorlash»; a card is in at most
/// one of them.
 final  Set<int> _known;
/// Card indexes marked «Bilaman» / «Takrorlash»; a card is in at most
/// one of them.
@override@JsonKey() Set<int> get known {
  if (_known is EqualUnmodifiableSetView) return _known;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_known);
}

 final  Set<int> _repeat;
@override@JsonKey() Set<int> get repeat {
  if (_repeat is EqualUnmodifiableSetView) return _repeat;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_repeat);
}

/// Past the last card: the result screen.
@override@JsonKey() final  bool finished;

/// Create a copy of FlashcardsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashcardsStateCopyWith<_FlashcardsState> get copyWith => __$FlashcardsStateCopyWithImpl<_FlashcardsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashcardsState&&const DeepCollectionEquality().equals(other.cards, _cards)&&(identical(other.index, index) || other.index == index)&&(identical(other.flipped, flipped) || other.flipped == flipped)&&const DeepCollectionEquality().equals(other.known, _known)&&const DeepCollectionEquality().equals(other.repeat, _repeat)&&(identical(other.finished, finished) || other.finished == finished));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards),index,flipped,const DeepCollectionEquality().hash(_known),const DeepCollectionEquality().hash(_repeat),finished);
}

@override
String toString() {
    return 'FlashcardsState(cards: $cards, index: $index, flipped: $flipped, known: $known, repeat: $repeat, finished: $finished)';
}


}

/// @nodoc
abstract mixin class _$FlashcardsStateCopyWith<$Res> implements $FlashcardsStateCopyWith<$Res> {
  factory _$FlashcardsStateCopyWith(_FlashcardsState value, $Res Function(_FlashcardsState) _then) = __$FlashcardsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Flashcard> cards, int index, bool flipped, Set<int> known, Set<int> repeat, bool finished
});




}
/// @nodoc
class __$FlashcardsStateCopyWithImpl<$Res>
    implements _$FlashcardsStateCopyWith<$Res> {
  __$FlashcardsStateCopyWithImpl(this._self, this._then);

  final _FlashcardsState _self;
  final $Res Function(_FlashcardsState) _then;

/// Create a copy of FlashcardsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cards = null,Object? index = null,Object? flipped = null,Object? known = null,Object? repeat = null,Object? finished = null,}) {
  return _then(_FlashcardsState(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<Flashcard>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,flipped: null == flipped ? _self.flipped : flipped // ignore: cast_nullable_to_non_nullable
as bool,known: null == known ? _self._known : known // ignore: cast_nullable_to_non_nullable
as Set<int>,repeat: null == repeat ? _self._repeat : repeat // ignore: cast_nullable_to_non_nullable
as Set<int>,finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
