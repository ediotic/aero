import 'package:get/get.dart';

import 'boarding_pass_controller.dart';

class BoardingPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardingPassController>(BoardingPassController.new);
  }
}
