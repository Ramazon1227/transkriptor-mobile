import 'package:dio/dio.dart';

/// `data.error` of the backend's NoRoute answer (`api/router.go`:
/// `apihttp.NotFound(c, "bunday endpoint yo'q")`). A handler's own 404
/// (a row that is not there or not yours) carries a different sentence,
/// so this is how a server that lacks a route is told apart from one
/// that has it and found nothing.
const String backendNoRouteError = "bunday endpoint yo'q";

/// True when [e] is a 404 for the route itself: the backend's NoRoute
/// envelope, or a 404 that is not our envelope at all (a proxy page).
bool isRouteMissing(DioException e) {
  final response = e.response;
  if (e.type != DioExceptionType.badResponse || response?.statusCode != 404) {
    return false;
  }
  final body = response?.data;
  if (body is! Map) return true;
  final data = body['data'];
  return data is Map && data['error'] == backendNoRouteError;
}
