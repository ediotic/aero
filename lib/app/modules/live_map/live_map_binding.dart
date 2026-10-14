import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'live_map_controller.dart';

class LiveMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveMapController>(
      () => LiveMapController(Get.find<StatusRepository>()),
    );
  }
}
