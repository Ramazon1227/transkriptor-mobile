/// Backend envelope: `{"status": ..., "description": ..., "data": ...}`.
///
/// Returns `data` as a map, or throws [FormatException] — which
/// `runRequest` turns into `Failure.parsing()` — when the body does not
/// have that shape.
Map<String, dynamic> envelopeData(Object? body) {
  if (body is Map<String, dynamic>) {
    final data = body['data'];
    if (data is Map<String, dynamic>) return data;
  }
  throw const FormatException('response has no data object');
}
