import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find<ProfileRepository>()),
    );
  }
}
