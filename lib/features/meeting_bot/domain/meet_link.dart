/// The Meet link the backend accepts (`pkg/meetlink.Parse`), canonical:
/// http(s), host `meet.google.com`, path exactly `abc-defg-hij`; query and
/// a trailing slash are dropped. Null for anything else, so the form says
/// so before a request is made.
String? canonicalMeetUrl(String raw) {
  final uri = Uri.tryParse(raw.trim());
  if (uri == null || !(uri.scheme == 'https' || uri.scheme == 'http')) {
    return null;
  }
  if (uri.host.toLowerCase() != 'meet.google.com') return null;
  final path = _trimSlashes(uri.path);
  if (!_meetCode.hasMatch(path)) return null;
  return 'https://meet.google.com/$path';
}

final RegExp _meetCode = RegExp(r'^[a-z]{3}-[a-z]{4}-[a-z]{3}$');

String _trimSlashes(String s) {
  var start = 0;
  var end = s.length;
  while (start < end && s[start] == '/') {
    start++;
  }
  while (end > start && s[end - 1] == '/') {
    end--;
  }
  return s.substring(start, end);
}
