import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<FlightRepository>(), Get.find<ProfileRepository>()),
    );
  }
}
