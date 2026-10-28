/// `models.NormalizeTags` in the backend, so the sheet refuses what the
/// server would: lower case, inner spaces collapsed, at most [maxLength]
/// characters, no comma, duplicates dropped, at most [maxTags] per file.
abstract final class TagRules {
  static const int maxTags = 10;
  static const int maxLength = 32;

  /// One tag as the server stores it, or null if the server would refuse
  /// it. Length is counted in characters (runes), as Go counts it.
  static String? normalize(String raw) {
    final tag = raw.trim().split(RegExp(r'\s+')).join(' ').toLowerCase();
    if (tag.isEmpty || tag.runes.length > maxLength || tag.contains(',')) {
      return null;
    }
    return tag;
  }
}

/// `models.MaxFolderName`; counted in characters.
abstract final class FolderRules {
  static const int maxName = 80;

  static String? normalize(String raw) {
    final name = raw.trim();
    return name.isEmpty || name.runes.length > maxName ? null : name;
  }
}
