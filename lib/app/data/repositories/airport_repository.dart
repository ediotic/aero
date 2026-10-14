import '../../core/network/api_endpoints.dart';
import '../../core/utils/json_utils.dart';
import '../mock/mock_data.dart';
import '../models/airport_guide.dart';
import 'base_repository.dart';

class AirportRepository extends BaseRepository {
  AirportRepository(super.api);

  Future<AirportGuide> getGuide(String airportCode) async {
    if (useMock) {
      await mockDelay();
      return MockData.airportGuide;
    }
    final response = await api.get(ApiEndpoints.airportGuide(airportCode));
    return AirportGuide.fromJson(jsonMap(response.data));
  }
}
