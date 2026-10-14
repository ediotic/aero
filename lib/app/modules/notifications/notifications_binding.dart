import 'package:get/get.dart';

import 'package:aerova_app/app/data/data.dart';

import 'notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(
      () => NotificationsController(Get.find<NotificationRepository>()),
    );
  }
}
