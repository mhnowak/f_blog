class Env {
  static const String env =
      String.fromEnvironment('ENV', defaultValue: 'DEBUG');

  static bool get isDebug => env == 'DEBUG';
}
