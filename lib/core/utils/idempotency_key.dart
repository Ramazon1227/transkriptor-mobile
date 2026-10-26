import 'dart:math';

/// 128 random bits as hex. Sent with every request that starts paid work,
/// so a retried tap cannot start the same job twice.
String newIdempotencyKey() {
  final random = Random.secure();
  return List.generate(
    16,
    (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();
}
