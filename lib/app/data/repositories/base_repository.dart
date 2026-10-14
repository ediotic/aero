import '../../core/constants/app_config.dart';
import '../../core/network/api_client.dart';

/// Shared by every repository: holds the Dio client and the mock delay.
abstract class BaseRepository {
  BaseRepository(this.api);

  final ApiClient api;

  bool get useMock => AppConfig.useMock;

  Future<void> mockDelay() => Future<void>.delayed(AppConfig.mockLatency);
}
