import 'dart:async';

import 'package:get/get.dart';

import 'package:aerova_app/app/routes/app_routes.dart';

class SplashController extends GetxController {
  Timer? _timer;

  @override
  void onReady() {
    super.onReady();
    _timer = Timer(const Duration(milliseconds: 2600), goNext);
  }

  /// Called by the timer or when the user taps the screen.
  void goNext() {
    _timer?.cancel();
    if (Get.currentRoute == AppRoutes.splash) {
      Get.offNamed<void>(AppRoutes.onboarding);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
