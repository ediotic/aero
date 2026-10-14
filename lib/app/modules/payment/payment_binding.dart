import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(
      () => PaymentController(Get.find<BookingRepository>()),
    );
  }
}
