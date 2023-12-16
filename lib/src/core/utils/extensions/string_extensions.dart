class StringExtensions {
  StringExtensions._();

  /// Example: your name => Your name
  static String? capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  static String removeAllWhitespace(String value) {
    return value.replaceAll(' ', '');
  }
}
