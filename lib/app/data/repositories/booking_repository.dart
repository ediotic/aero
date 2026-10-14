import '../../core/network/api_endpoints.dart';
import '../../core/utils/json_utils.dart';
import '../mock/mock_data.dart';
import '../models/booking.dart';
import '../models/trip.dart';
import 'base_repository.dart';

class BookingRepository extends BaseRepository {
  BookingRepository(super.api);

  /// Pays for the draft and returns the confirmed booking.
  Future<Booking> createBooking(BookingDraft draft, PaymentMethod method) async {
    if (useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 1400));
      return Booking(
        pnr: 'AX7K2P',
        draft: draft,
        gate: '12',
        terminal: draft.flight.fromTerminal,
        boardingTime: '05:35',
        group: '2',
      );
    }
    final response = await api.post(ApiEndpoints.bookings, body: draft.toJson(method));
    return Booking.fromJson(jsonMap(response.data), draft);
  }

  Future<List<Trip>> getTrips() async {
    if (useMock) {
      await mockDelay();
      return MockData.trips;
    }
    final response = await api.get(ApiEndpoints.trips);
    return jsonList(response.data).map(Trip.fromJson).toList();
  }

  Future<void> cancelTrip(String pnr) async {
    if (useMock) {
      await mockDelay();
      return;
    }
    await api.post(ApiEndpoints.cancelTrip(pnr));
  }
}
