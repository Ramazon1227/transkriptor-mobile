import 'dart:async';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/push/domain/i_push_facade.dart';
import 'package:transkriptor_uz/features/push/domain/push_message.dart';
import 'package:transkriptor_uz/features/push/infrastructure/messaging/messaging_source.dart';
import 'package:transkriptor_uz/features/push/infrastructure/repositories/push_repository.dart';

@LazySingleton(as: IPushFacade)
class PushFacade implements IPushFacade {
  PushFacade(this._source, this._repository);

  final MessagingSource _source;
  final PushRepository _repository;

  /// The token the server has for this phone, for [unregister].
  String? _registered;
  StreamSubscription<String>? _refresh;

  @override
  bool get isAvailable => _source.enabled;

  static String get _platform =>
      defaultTargetPlatform == TargetPlatform.iOS ? 'IOS' : 'ANDROID';

  @override
  Future<Either<Failure, Unit>> register() async {
    if (!_source.enabled) return const Right(unit);
    final String? token;
    try {
      if (!await _source.requestPermission()) {
        return const Left(Failure.permissionDenied());
      }
      token = await _source.token();
    } on Object {
      // No Play services, no network to FCM: the app works without push.
      return const Left(Failure.unknown());
    }
    if (token == null || token.isEmpty) return const Left(Failure.unknown());
    final result = await _send(token);
    // FCM rotates tokens now and then; the server must follow.
    _refresh ??= _source.tokenRefresh.listen((t) => unawaited(_send(t)));
    return result;
  }

  Future<Either<Failure, Unit>> _send(String token) async {
    final result = await _repository.register(
      token: token,
      platform: _platform,
    );
    if (result.isRight()) _registered = token;
    return result;
  }

  @override
  Future<void> unregister() async {
    if (!_source.enabled) return;
    await _refresh?.cancel();
    _refresh = null;
    final token = _registered;
    _registered = null;
    if (token != null) await _repository.unregister(token: token);
    try {
      // The next account on this phone gets a fresh token.
      await _source.deleteToken();
    } on Object {
      // Logging out must not fail on this.
    }
  }

  @override
  Stream<PushMessage> get opened => _source.opened.expand(_message);

  @override
  Stream<PushMessage> get received => _source.foreground.expand(_message);

  static Iterable<PushMessage> _message(Map<String, dynamic> data) {
    final message = PushMessage.fromData(data);
    return message == null ? const [] : [message];
  }
}
