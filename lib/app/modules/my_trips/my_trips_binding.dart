import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'my_trips_controller.dart';

class MyTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTripsController>(
      () => MyTripsController(Get.find<BookingRepository>()),
    );
  }
}
