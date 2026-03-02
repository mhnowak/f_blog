class Env {
  static const String env =
      String.fromEnvironment('ENV', defaultValue: 'DEBUG');

  static const String base = String.fromEnvironment('BASE', defaultValue: '/');

  static bool get isDebug => env == 'DEBUG';
}
