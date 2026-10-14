import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'search_flights_controller.dart';

class SearchFlightsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchFlightsController>(
      () => SearchFlightsController(Get.find<FlightRepository>()),
    );
  }
}
