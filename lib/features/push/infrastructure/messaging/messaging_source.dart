import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/firebase_config.dart';

/// Firebase Messaging behind a small surface, so the facade is testable
/// and nothing touches Firebase in a build without its settings.
abstract interface class MessagingSource {
  bool get enabled;

  /// True when the person allowed notifications.
  Future<bool> requestPermission();
  Future<String?> token();
  Stream<String> get tokenRefresh;
  Future<void> deleteToken();

  /// `data` of tapped notifications, the launching one first.
  Stream<Map<String, dynamic>> get opened;

  /// `data` of notifications received in the foreground.
  Stream<Map<String, dynamic>> get foreground;
}

// getToken / onTokenRefresh / deleteToken are deprecated in
// firebase_messaging 17 in favour of register() / onRegistered, which hand
// out a Firebase Installation ID for FCM's newer direct-send. The backend
// sends through HTTP v1 `message.token`, which takes the registration
// token these still return; move both sides together when switching.
// ignore_for_file: deprecated_member_use

@LazySingleton(as: MessagingSource)
class FirebaseMessagingSource implements MessagingSource {
  FirebaseMessagingSource() : _options = FirebaseConfig.options;

  final FirebaseOptions? _options;
  Future<FirebaseMessaging>? _ready;

  @override
  bool get enabled => _options != null;

  /// Firebase starts on first use, not at app start: a build without
  /// settings never loads it.
  Future<FirebaseMessaging> _messaging() => _ready ??= () async {
    await Firebase.initializeApp(options: _options);
    return FirebaseMessaging.instance;
  }();

  @override
  Future<bool> requestPermission() async {
    final settings = await (await _messaging()).requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  @override
  Future<String?> token() async {
    final messaging = await _messaging();
    return await messaging.getToken();
  }

  @override
  Stream<String> get tokenRefresh => _after((m) => m.onTokenRefresh);

  @override
  Future<void> deleteToken() async {
    final messaging = await _messaging();
    await messaging.deleteToken();
  }

  @override
  Stream<Map<String, dynamic>> get opened => _after((m) async* {
    final initial = await m.getInitialMessage();
    if (initial != null) yield initial.data;
    yield* FirebaseMessaging.onMessageOpenedApp.map((r) => r.data);
  });

  @override
  Stream<Map<String, dynamic>> get foreground =>
      _after((_) => FirebaseMessaging.onMessage.map((r) => r.data));

  Stream<T> _after<T>(Stream<T> Function(FirebaseMessaging m) stream) async* {
    if (!enabled) return;
    yield* stream(await _messaging());
  }
}
