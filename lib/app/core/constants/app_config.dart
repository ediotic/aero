/// App-wide configuration.
class AppConfig {
  AppConfig._();

  /// Base URL used by the Dio client.
  static const String baseUrl = 'https://api.aerova.example/v1';

  /// While true, repositories return demo data instead of calling the server.
  /// Set to false once a real backend is available.
  static const bool useMock = true;

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration mockLatency = Duration(milliseconds: 600);
}
