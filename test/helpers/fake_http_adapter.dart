import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// One recorded request: what a repository actually sent.
class SentRequest {
  SentRequest(this.options, this.body);

  final RequestOptions options;

  /// Decoded JSON for a JSON body; null for none or a byte stream.
  final Object? body;

  int bodyBytes = 0;
}

/// Answers every request from a route table and records what was sent, so
/// repository tests check paths, query and JSON keys against the backend
/// contract without a server.
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter(this.routes);

  /// `"POST /api/v1/job"` → (status, JSON body).
  final Map<String, (int, Object?)> routes;
  final List<SentRequest> sent = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final bytes = <int>[];
    if (requestStream != null) {
      await requestStream.forEach(bytes.addAll);
    }
    Object? body;
    final isJson = (options.contentType ?? '').contains('json');
    if (isJson && bytes.isNotEmpty) body = jsonDecode(utf8.decode(bytes));
    sent.add(SentRequest(options, body)..bodyBytes = bytes.length);

    final key = '${options.method} ${options.uri.path}';
    final (status, json) = routes[key] ?? (404, {'status': 'NOT_FOUND'});
    return ResponseBody.fromString(
      jsonEncode(json),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// A Dio like the app's: a base URL and JSON by default.
Dio fakeDio(FakeHttpAdapter adapter) => Dio(
  BaseOptions(
    baseUrl: 'https://api.test',
    contentType: Headers.jsonContentType,
  ),
)..httpClientAdapter = adapter;

/// The backend envelope around [data].
Map<String, Object?> ok(Object? data) => {
  'status': 'OK',
  'description': '',
  'data': data,
};
