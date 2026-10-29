// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiMessage {

 String get id; AiRole get role; AiMessageStatus get status; String get content;/// A fixed sentence from the server when the answer did not come.
 String? get error; DateTime? get createdAt;/// Shown before the server confirmed it (optimistic bubble).
 bool get local;
/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiMessageCopyWith<AiMessage> get copyWith => _$AiMessageCopyWithImpl<AiMessage>(this as AiMessage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AiMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.local, _this.local) || other.local == _this.local));
}


@override
int get hashCode {
  final _this = this as AiMessage;
  return Object.hash(runtimeType,_this.id,_this.role,_this.status,_this.content,_this.error,_this.createdAt,_this.local);
}

@override
String toString() {
  final _this = this as AiMessage;
  return 'AiMessage(id: ${_this.id}, role: ${_this.role}, status: ${_this.status}, content: ${_this.content}, error: ${_this.error}, createdAt: ${_this.createdAt}, local: ${_this.local})';
}


}

/// @nodoc
abstract mixin class $AiMessageCopyWith<$Res>  {
  factory $AiMessageCopyWith(AiMessage value, $Res Function(AiMessage) _then) = _$AiMessageCopyWithImpl;
@useResult
$Res call({
 String id, AiRole role, AiMessageStatus status, String content, String? error, DateTime? createdAt, bool local
});




}
/// @nodoc
class _$AiMessageCopyWithImpl<$Res>
    implements $AiMessageCopyWith<$Res> {
  _$AiMessageCopyWithImpl(this._self, this._then);

  final AiMessage _self;
  final $Res Function(AiMessage) _then;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? status = null,Object? content = null,Object? error = freezed,Object? createdAt = freezed,Object? local = null,}) {
  return _then(AiMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AiRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiMessageStatus,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AiMessage].
extension AiMessagePatterns on AiMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiMessage value)  $default,){
final _that = this;
switch (_that) {
case _AiMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiMessage value)?  $default,){
final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  AiRole role,  AiMessageStatus status,  String content,  String? error,  DateTime? createdAt,  bool local)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
return $default(_that.id,_that.role,_that.status,_that.content,_that.error,_that.createdAt,_that.local);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  AiRole role,  AiMessageStatus status,  String content,  String? error,  DateTime? createdAt,  bool local)  $default,) {final _that = this;
switch (_that) {
case _AiMessage():
return $default(_that.id,_that.role,_that.status,_that.content,_that.error,_that.createdAt,_that.local);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  AiRole role,  AiMessageStatus status,  String content,  String? error,  DateTime? createdAt,  bool local)?  $default,) {final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
return $default(_that.id,_that.role,_that.status,_that.content,_that.error,_that.createdAt,_that.local);case _:
  return null;

}
}

}

/// @nodoc


class _AiMessage extends AiMessage {
  const _AiMessage({required this.id, required this.role, required this.status, this.content = '', this.error, this.createdAt, this.local = false}): super._();
  

@override final  String id;
@override final  AiRole role;
@override final  AiMessageStatus status;
@override@JsonKey() final  String content;
/// A fixed sentence from the server when the answer did not come.
@override final  String? error;
@override final  DateTime? createdAt;
/// Shown before the server confirmed it (optimistic bubble).
@override@JsonKey() final  bool local;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiMessageCopyWith<_AiMessage> get copyWith => __$AiMessageCopyWithImpl<_AiMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.content, content) || other.content == content)&&(identical(other.error, error) || other.error == error)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.local, local) || other.local == local));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,role,status,content,error,createdAt,local);
}

@override
String toString() {
    return 'AiMessage(id: $id, role: $role, status: $status, content: $content, error: $error, createdAt: $createdAt, local: $local)';
}


}

/// @nodoc
abstract mixin class _$AiMessageCopyWith<$Res> implements $AiMessageCopyWith<$Res> {
  factory _$AiMessageCopyWith(_AiMessage value, $Res Function(_AiMessage) _then) = __$AiMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, AiRole role, AiMessageStatus status, String content, String? error, DateTime? createdAt, bool local
});




}
/// @nodoc
class __$AiMessageCopyWithImpl<$Res>
    implements _$AiMessageCopyWith<$Res> {
  __$AiMessageCopyWithImpl(this._self, this._then);

  final _AiMessage _self;
  final $Res Function(_AiMessage) _then;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? status = null,Object? content = null,Object? error = freezed,Object? createdAt = freezed,Object? local = null,}) {
  return _then(_AiMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AiRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiMessageStatus,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$AiChat {

 List<AiMessage> get items; bool get pending;
/// Create a copy of AiChat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiChatCopyWith<AiChat> get copyWith => _$AiChatCopyWithImpl<AiChat>(this as AiChat, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AiChat;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiChat&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.pending, _this.pending) || other.pending == _this.pending));
}


@override
int get hashCode {
  final _this = this as AiChat;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.pending);
}

@override
String toString() {
  final _this = this as AiChat;
  return 'AiChat(items: ${_this.items}, pending: ${_this.pending})';
}


}

/// @nodoc
abstract mixin class $AiChatCopyWith<$Res>  {
  factory $AiChatCopyWith(AiChat value, $Res Function(AiChat) _then) = _$AiChatCopyWithImpl;
@useResult
$Res call({
 List<AiMessage> items, bool pending
});




}
/// @nodoc
class _$AiChatCopyWithImpl<$Res>
    implements $AiChatCopyWith<$Res> {
  _$AiChatCopyWithImpl(this._self, this._then);

  final AiChat _self;
  final $Res Function(AiChat) _then;

/// Create a copy of AiChat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? pending = null,}) {
  return _then(AiChat(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AiMessage>,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AiChat].
extension AiChatPatterns on AiChat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiChat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiChat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiChat value)  $default,){
final _that = this;
switch (_that) {
case _AiChat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiChat value)?  $default,){
final _that = this;
switch (_that) {
case _AiChat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AiMessage> items,  bool pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiChat() when $default != null:
return $default(_that.items,_that.pending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AiMessage> items,  bool pending)  $default,) {final _that = this;
switch (_that) {
case _AiChat():
return $default(_that.items,_that.pending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AiMessage> items,  bool pending)?  $default,) {final _that = this;
switch (_that) {
case _AiChat() when $default != null:
return $default(_that.items,_that.pending);case _:
  return null;

}
}

}

/// @nodoc


class _AiChat implements AiChat {
  const _AiChat({ List<AiMessage> items = const <AiMessage>[], this.pending = false}): _items = items;
  

 final  List<AiMessage> _items;
@override@JsonKey() List<AiMessage> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  bool pending;

/// Create a copy of AiChat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiChatCopyWith<_AiChat> get copyWith => __$AiChatCopyWithImpl<_AiChat>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiChat&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.pending, pending) || other.pending == pending));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),pending);
}

@override
String toString() {
    return 'AiChat(items: $items, pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$AiChatCopyWith<$Res> implements $AiChatCopyWith<$Res> {
  factory _$AiChatCopyWith(_AiChat value, $Res Function(_AiChat) _then) = __$AiChatCopyWithImpl;
@override @useResult
$Res call({
 List<AiMessage> items, bool pending
});




}
/// @nodoc
class __$AiChatCopyWithImpl<$Res>
    implements _$AiChatCopyWith<$Res> {
  __$AiChatCopyWithImpl(this._self, this._then);

  final _AiChat _self;
  final $Res Function(_AiChat) _then;

/// Create a copy of AiChat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? pending = null,}) {
  return _then(_AiChat(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AiMessage>,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$AiExchange {

 AiMessage get question; AiMessage get answer;
/// Create a copy of AiExchange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiExchangeCopyWith<AiExchange> get copyWith => _$AiExchangeCopyWithImpl<AiExchange>(this as AiExchange, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AiExchange;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiExchange&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.answer, _this.answer) || other.answer == _this.answer));
}


@override
int get hashCode {
  final _this = this as AiExchange;
  return Object.hash(runtimeType,_this.question,_this.answer);
}

@override
String toString() {
  final _this = this as AiExchange;
  return 'AiExchange(question: ${_this.question}, answer: ${_this.answer})';
}


}

/// @nodoc
abstract mixin class $AiExchangeCopyWith<$Res>  {
  factory $AiExchangeCopyWith(AiExchange value, $Res Function(AiExchange) _then) = _$AiExchangeCopyWithImpl;
@useResult
$Res call({
 AiMessage question, AiMessage answer
});


$AiMessageCopyWith<$Res> get question;$AiMessageCopyWith<$Res> get answer;

}
/// @nodoc
class _$AiExchangeCopyWithImpl<$Res>
    implements $AiExchangeCopyWith<$Res> {
  _$AiExchangeCopyWithImpl(this._self, this._then);

  final AiExchange _self;
  final $Res Function(AiExchange) _then;

/// Create a copy of AiExchange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? answer = null,}) {
  return _then(AiExchange(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as AiMessage,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as AiMessage,
  ));
}
/// Create a copy of AiExchange
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiMessageCopyWith<$Res> get question {
  
  return $AiMessageCopyWith<$Res>(_self.question, (value) {
    return _then(_self.copyWith(question: value));
  });
}/// Create a copy of AiExchange
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiMessageCopyWith<$Res> get answer {
  
  return $AiMessageCopyWith<$Res>(_self.answer, (value) {
    return _then(_self.copyWith(answer: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiExchange].
extension AiExchangePatterns on AiExchange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiExchange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiExchange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiExchange value)  $default,){
final _that = this;
switch (_that) {
case _AiExchange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiExchange value)?  $default,){
final _that = this;
switch (_that) {
case _AiExchange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiMessage question,  AiMessage answer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiExchange() when $default != null:
return $default(_that.question,_that.answer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiMessage question,  AiMessage answer)  $default,) {final _that = this;
switch (_that) {
case _AiExchange():
return $default(_that.question,_that.answer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiMessage question,  AiMessage answer)?  $default,) {final _that = this;
switch (_that) {
case _AiExchange() when $default != null:
return $default(_that.question,_that.answer);case _:
  return null;

}
}

}

/// @nodoc


class _AiExchange implements AiExchange {
  const _AiExchange({required this.question, required this.answer});
  

@override final  AiMessage question;
@override final  AiMessage answer;

/// Create a copy of AiExchange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiExchangeCopyWith<_AiExchange> get copyWith => __$AiExchangeCopyWithImpl<_AiExchange>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiExchange&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}


@override
int get hashCode {
    return Object.hash(runtimeType,question,answer);
}

@override
String toString() {
    return 'AiExchange(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$AiExchangeCopyWith<$Res> implements $AiExchangeCopyWith<$Res> {
  factory _$AiExchangeCopyWith(_AiExchange value, $Res Function(_AiExchange) _then) = __$AiExchangeCopyWithImpl;
@override @useResult
$Res call({
 AiMessage question, AiMessage answer
});


@override $AiMessageCopyWith<$Res> get question;@override $AiMessageCopyWith<$Res> get answer;

}
/// @nodoc
class __$AiExchangeCopyWithImpl<$Res>
    implements _$AiExchangeCopyWith<$Res> {
  __$AiExchangeCopyWithImpl(this._self, this._then);

  final _AiExchange _self;
  final $Res Function(_AiExchange) _then;

/// Create a copy of AiExchange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? answer = null,}) {
  return _then(_AiExchange(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as AiMessage,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as AiMessage,
  ));
}

/// Create a copy of AiExchange
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiMessageCopyWith<$Res> get question {
  
  return $AiMessageCopyWith<$Res>(_self.question, (value) {
    return _then(_self.copyWith(question: value));
  });
}/// Create a copy of AiExchange
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiMessageCopyWith<$Res> get answer {
  
  return $AiMessageCopyWith<$Res>(_self.answer, (value) {
    return _then(_self.copyWith(answer: value));
  });
}
}

// dart format on
