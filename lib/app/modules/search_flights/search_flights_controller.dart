import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';

enum FlightFilter { cheapest, fastest, nonStop, morning, refundable }

class DateOption {
  const DateOption(this.date, this.fareFrom);
  final DateTime date;
  final int fareFrom;
}

class SearchFlightsController extends GetxController {
  SearchFlightsController(this._repo);

  final FlightRepository _repo;

  late final SearchQuery query;
  final RxList<Flight> flights = <Flight>[].obs;
  final RxBool loading = true.obs;
  final RxnString error = RxnString();
  final Rx<FlightFilter> filter = FlightFilter.cheapest.obs;
  final RxInt dateIndex = 0.obs;
  late final List<DateOption> dates;

  @override
  void onInit() {
    super.onInit();
    final Object? args = Get.arguments;
    query = args is SearchQuery ? args : SearchQuery.initial();

    // Five day strip around the chosen date, never before today.
    final DateTime today = DateTime.now();
    DateTime start = query.date.subtract(const Duration(days: 2));
    if (start.isBefore(DateTime(today.year, today.month, today.day))) {
      start = today;
    }
    const List<int> fares = <int>[4299, 4399, 4299, 4899, 4599, 4150];
    dates = List<DateOption>.generate(
      5,
      (int i) => DateOption(start.add(Duration(days: i)), fares[i % fares.length]),
    );
    final int match = dates.indexWhere(
      (DateOption d) =>
          d.date.year == query.date.year &&
          d.date.month == query.date.month &&
          d.date.day == query.date.day,
    );
    dateIndex.value = match < 0 ? 0 : match;
  }

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    error.value = null;
    try {
      final SearchQuery q = query.copyWith(date: dates[dateIndex.value].date);
      flights.assignAll(await _repo.searchFlights(q));
    } on ApiException catch (e) {
      error.value = e.message;
    } catch (_) {
      error.value = AppStrings.errGeneric;
    } finally {
      loading.value = false;
    }
  }

  void selectDate(int index) {
    if (index == dateIndex.value) return;
    dateIndex.value = index;
    load();
  }

  void setFilter(FlightFilter f) => filter.value = f;

  int _minutes(String duration) {
    final RegExpMatch? h = RegExp(r'(\d+)\s*h').firstMatch(duration);
    final RegExpMatch? m = RegExp(r'(\d+)\s*m').firstMatch(duration);
    return (int.tryParse(h?.group(1) ?? '') ?? 0) * 60 + (int.tryParse(m?.group(1) ?? '') ?? 0);
  }

  List<Flight> get visibleFlights {
    final List<Flight> list = List<Flight>.of(flights);
    switch (filter.value) {
      case FlightFilter.cheapest:
        list.sort((Flight a, Flight b) => a.totalFare.compareTo(b.totalFare));
        return list;
      case FlightFilter.fastest:
        list.sort((Flight a, Flight b) => _minutes(a.duration).compareTo(_minutes(b.duration)));
        return list;
      case FlightFilter.nonStop:
        return list.where((Flight f) => f.isNonStop).toList();
      case FlightFilter.morning:
        return list.where((Flight f) {
          final int hour = int.tryParse(f.departTime.split(':').first) ?? 12;
          final bool pm = f.departTime.toUpperCase().contains('PM');
          return !pm && hour < 12;
        }).toList();
      case FlightFilter.refundable:
        return list.where((Flight f) => f.refundAmount > 0).toList();
    }
  }

  String filterLabel(FlightFilter f) {
    switch (f) {
      case FlightFilter.cheapest:
        return AppStrings.filterCheapest;
      case FlightFilter.fastest:
        return AppStrings.filterFastest;
      case FlightFilter.nonStop:
        return AppStrings.nonStop;
      case FlightFilter.morning:
        return AppStrings.filterMorning;
      case FlightFilter.refundable:
        return AppStrings.filterRefundable;
    }
  }

  void openFlight(Flight flight) =>
      Get.toNamed<void>(AppRoutes.flightDetails, arguments: flight);
}
