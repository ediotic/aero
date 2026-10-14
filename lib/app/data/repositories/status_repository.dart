import '../../core/network/api_endpoints.dart';
import '../../core/utils/json_utils.dart';
import '../mock/mock_data.dart';
import '../models/flight_status_info.dart';
import '../models/live_flight.dart';
import 'base_repository.dart';

class StatusRepository extends BaseRepository {
  StatusRepository(super.api);

  /// [query] can be a flight number ("AV 624") or a route ("DEL BOM").
  Future<List<FlightStatusInfo>> getStatuses({String query = ''}) async {
    if (useMock) {
      await mockDelay();
      final String q = query.trim().toLowerCase();
      if (q.isEmpty) return MockData.statuses;
      return MockData.statuses.where((FlightStatusInfo s) {
        final String haystack =
            '${s.flightNo} ${s.fromCode} ${s.toCode} ${s.airlineName}'.toLowerCase();
        return haystack.contains(q);
      }).toList();
    }
    final response = await api.get(
      ApiEndpoints.flightStatus,
      query: <String, dynamic>{'q': query},
    );
    return jsonList(response.data).map(FlightStatusInfo.fromJson).toList();
  }

  Future<LiveFlight> getLiveFlight(String flightNo) async {
    if (useMock) {
      await mockDelay();
      return MockData.liveFlight;
    }
    final response = await api.get(ApiEndpoints.liveFlight(flightNo));
    return LiveFlight.fromJson(jsonMap(response.data));
  }
}
