import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/routes/app_routes.dart';

class OnboardingItem {
  const OnboardingItem({required this.asset, required this.title, required this.body});

  final String asset;
  final String title;
  final String body;
}

class OnboardingController extends GetxController {
  static const List<OnboardingItem> items = <OnboardingItem>[
    OnboardingItem(
      asset: AppAssets.onboarding1,
      title: AppStrings.onb1Title,
      body: AppStrings.onb1Body,
    ),
    OnboardingItem(
      asset: AppAssets.onboarding2,
      title: AppStrings.onb2Title,
      body: AppStrings.onb2Body,
    ),
    OnboardingItem(
      asset: AppAssets.onboarding3,
      title: AppStrings.onb3Title,
      body: AppStrings.onb3Body,
    ),
  ];

  final PageController pageController = PageController();
  final RxInt page = 0.obs;

  bool get isLast => page.value == items.length - 1;

  void onPageChanged(int index) => page.value = index;

  void next() {
    if (isLast) {
      finish();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void finish() => Get.offAllNamed<void>(AppRoutes.home);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
