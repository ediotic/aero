import '../../core/network/api_endpoints.dart';
import '../../core/utils/json_utils.dart';
import '../mock/mock_data.dart';
import '../models/app_notification.dart';
import 'base_repository.dart';

class NotificationRepository extends BaseRepository {
  NotificationRepository(super.api);

  Future<List<AppNotification>> getNotifications() async {
    if (useMock) {
      await mockDelay();
      return MockData.notifications;
    }
    final response = await api.get(ApiEndpoints.notifications);
    return jsonList(response.data).map(AppNotification.fromJson).toList();
  }

  Future<void> markAllRead() async {
    if (useMock) return;
    await api.post(ApiEndpoints.markNotificationsRead);
  }
}
