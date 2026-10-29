// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dictation_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DictationEvent {

 String get text;
/// Create a copy of DictationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DictationEventCopyWith<DictationEvent> get copyWith => _$DictationEventCopyWithImpl<DictationEvent>(this as DictationEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DictationEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DictationEvent&&(identical(other.text, _this.text) || other.text == _this.text));
}


@override
int get hashCode {
  final _this = this as DictationEvent;
  return Object.hash(runtimeType,_this.text);
}

@override
String toString() {
  final _this = this as DictationEvent;
  return 'DictationEvent(text: ${_this.text})';
}


}

/// @nodoc
abstract mixin class $DictationEventCopyWith<$Res>  {
  factory $DictationEventCopyWith(DictationEvent value, $Res Function(DictationEvent) _then) = _$DictationEventCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$DictationEventCopyWithImpl<$Res>
    implements $DictationEventCopyWith<$Res> {
  _$DictationEventCopyWithImpl(this._self, this._then);

  final DictationEvent _self;
  final $Res Function(DictationEvent) _then;

/// Create a copy of DictationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DictationEvent].
extension DictationEventPatterns on DictationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DictationPartial value)?  partial,TResult Function( DictationFinal value)?  finalText,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DictationPartial() when partial != null:
return partial(_that);case DictationFinal() when finalText != null:
return finalText(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DictationPartial value)  partial,required TResult Function( DictationFinal value)  finalText,}){
final _that = this;
switch (_that) {
case DictationPartial():
return partial(_that);case DictationFinal():
return finalText(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DictationPartial value)?  partial,TResult? Function( DictationFinal value)?  finalText,}){
final _that = this;
switch (_that) {
case DictationPartial() when partial != null:
return partial(_that);case DictationFinal() when finalText != null:
return finalText(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  partial,TResult Function( String text)?  finalText,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DictationPartial() when partial != null:
return partial(_that.text);case DictationFinal() when finalText != null:
return finalText(_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  partial,required TResult Function( String text)  finalText,}) {final _that = this;
switch (_that) {
case DictationPartial():
return partial(_that.text);case DictationFinal():
return finalText(_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  partial,TResult? Function( String text)?  finalText,}) {final _that = this;
switch (_that) {
case DictationPartial() when partial != null:
return partial(_that.text);case DictationFinal() when finalText != null:
return finalText(_that.text);case _:
  return null;

}
}

}

/// @nodoc


class DictationPartial implements DictationEvent {
  const DictationPartial(this.text);
  

@override final  String text;

/// Create a copy of DictationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DictationPartialCopyWith<DictationPartial> get copyWith => _$DictationPartialCopyWithImpl<DictationPartial>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DictationPartial&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text);
}

@override
String toString() {
    return 'DictationEvent.partial(text: $text)';
}


}

/// @nodoc
abstract mixin class $DictationPartialCopyWith<$Res> implements $DictationEventCopyWith<$Res> {
  factory $DictationPartialCopyWith(DictationPartial value, $Res Function(DictationPartial) _then) = _$DictationPartialCopyWithImpl;
@override @useResult
$Res call({
 String text
});




}
/// @nodoc
class _$DictationPartialCopyWithImpl<$Res>
    implements $DictationPartialCopyWith<$Res> {
  _$DictationPartialCopyWithImpl(this._self, this._then);

  final DictationPartial _self;
  final $Res Function(DictationPartial) _then;

/// Create a copy of DictationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(DictationPartial(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DictationFinal implements DictationEvent {
  const DictationFinal(this.text);
  

@override final  String text;

/// Create a copy of DictationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DictationFinalCopyWith<DictationFinal> get copyWith => _$DictationFinalCopyWithImpl<DictationFinal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DictationFinal&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text);
}

@override
String toString() {
    return 'DictationEvent.finalText(text: $text)';
}


}

/// @nodoc
abstract mixin class $DictationFinalCopyWith<$Res> implements $DictationEventCopyWith<$Res> {
  factory $DictationFinalCopyWith(DictationFinal value, $Res Function(DictationFinal) _then) = _$DictationFinalCopyWithImpl;
@override @useResult
$Res call({
 String text
});




}
/// @nodoc
class _$DictationFinalCopyWithImpl<$Res>
    implements $DictationFinalCopyWith<$Res> {
  _$DictationFinalCopyWithImpl(this._self, this._then);

  final DictationFinal _self;
  final $Res Function(DictationFinal) _then;

/// Create a copy of DictationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(DictationFinal(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
