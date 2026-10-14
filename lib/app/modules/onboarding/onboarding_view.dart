import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: AppGradients.onboarding),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const BrandMark(size: 32, glow: false),
                          const SizedBox(width: 10),
                          Text(
                            AppStrings.appName,
                            style: AppTextStyles.display(
                              15,
                              color: Colors.white,
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: controller.finish,
                        child: Text(
                          AppStrings.skip,
                          style: AppTextStyles.body(
                            14,
                            weight: FontWeight.w600,
                            color: AppColors.white(0.86),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: OnboardingController.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _OnboardingPage(item: OnboardingController.items[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Obx(
                        () => Row(
                          children: List<Widget>.generate(
                            OnboardingController.items.length,
                            (int i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              margin: const EdgeInsets.only(right: 8),
                              width: controller.page.value == i ? 28 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: controller.page.value == i
                                    ? Colors.white
                                    : AppColors.white(0.35),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Obx(
                        () => GradientButton(
                          label: controller.page.value == OnboardingController.items.length - 1
                              ? AppStrings.getStarted
                              : AppStrings.next,
                          trailingIcon: Icons.arrow_forward_rounded,
                          height: 58,
                          fontSize: 17,
                          onTap: controller.next,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.item});

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Center(
              child: SvgPicture.asset(item.asset, fit: BoxFit.contain),
            ),
          ),
          Text(
            item.title,
            style: AppTextStyles.display(30, color: Colors.white, height: 1.2, letterSpacing: -0.5),
          ),
          const SizedBox(height: 14),
          Text(
            item.body,
            style: AppTextStyles.body(16, color: AppColors.white(0.8), height: 1.5),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
