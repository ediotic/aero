import '../../core/network/api_endpoints.dart';
import '../../core/utils/json_utils.dart';
import '../mock/mock_data.dart';
import '../models/flight.dart';
import '../models/home_content.dart';
import '../models/search_query.dart';
import 'base_repository.dart';

class FlightRepository extends BaseRepository {
  FlightRepository(super.api);

  Future<List<Flight>> searchFlights(SearchQuery query) async {
    if (useMock) {
      await mockDelay();
      return MockData.flights;
    }
    final response = await api.get(ApiEndpoints.searchFlights, query: query.toJson());
    return jsonList(response.data).map(Flight.fromJson).toList();
  }

  /// Seat ids that are already booked, e.g. ["12A", "14C"].
  Future<List<String>> getTakenSeats(String flightId) async {
    if (useMock) {
      await mockDelay();
      return MockData.takenSeats;
    }
    final response = await api.get(ApiEndpoints.flightSeats(flightId));
    final dynamic raw = response.data is Map ? response.data['taken'] : response.data;
    return (raw as List<dynamic>).cast<String>();
  }

  Future<List<Destination>> getDestinations() async {
    if (useMock) {
      await mockDelay();
      return MockData.destinations;
    }
    final response = await api.get(ApiEndpoints.destinations);
    return jsonList(response.data).map(Destination.fromJson).toList();
  }

  Future<List<Offer>> getOffers() async {
    if (useMock) {
      await mockDelay();
      return MockData.offers;
    }
    final response = await api.get(ApiEndpoints.offers);
    return jsonList(response.data).map(Offer.fromJson).toList();
  }
}
