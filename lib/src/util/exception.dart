class MissingPluginImplementException implements Exception {
  MissingPluginImplementException([this.message]);

  final String? message;

  @override
  String toString() => 'MissingPluginImplementException($message)';
}