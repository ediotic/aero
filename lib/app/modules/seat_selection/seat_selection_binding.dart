import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'seat_selection_controller.dart';

class SeatSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeatSelectionController>(
      () => SeatSelectionController(Get.find<FlightRepository>()),
    );
  }
}
