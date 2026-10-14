import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'airport_guide_controller.dart';

class AirportGuideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AirportGuideController>(
      () => AirportGuideController(Get.find<AirportRepository>()),
    );
  }
}
