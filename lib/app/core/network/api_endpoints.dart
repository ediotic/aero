/// Every REST path used by the app.
class ApiEndpoints {
  ApiEndpoints._();

  static const String searchFlights = '/flights/search';
  static String flightSeats(String flightId) => '/flights/$flightId/seats';
  static const String destinations = '/destinations';
  static const String offers = '/offers';

  static const String bookings = '/bookings';
  static const String trips = '/trips';
  static String cancelTrip(String pnr) => '/trips/$pnr/cancel';

  static const String flightStatus = '/flights/status';
  static String liveFlight(String flightNo) => '/flights/$flightNo/live';

  static const String notifications = '/notifications';
  static const String markNotificationsRead = '/notifications/read';

  static String airportGuide(String code) => '/airports/$code/guide';
  static const String profile = '/me';
}
