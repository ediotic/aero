import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'flight_status_controller.dart';

class FlightStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlightStatusController>(
      () => FlightStatusController(Get.find<StatusRepository>()),
    );
  }
}
