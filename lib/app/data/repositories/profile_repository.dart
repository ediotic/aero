import '../../core/network/api_endpoints.dart';
import '../../core/utils/json_utils.dart';
import '../mock/mock_data.dart';
import '../models/user_profile.dart';
import 'base_repository.dart';

class ProfileRepository extends BaseRepository {
  ProfileRepository(super.api);

  Future<UserProfile> getProfile() async {
    if (useMock) {
      await mockDelay();
      return MockData.profile;
    }
    final response = await api.get(ApiEndpoints.profile);
    return UserProfile.fromJson(jsonMap(response.data));
  }
}
