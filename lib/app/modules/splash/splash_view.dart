import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: GestureDetector(
          onTap: controller.goNext,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(gradient: AppGradients.splash),
            child: Stack(
              children: <Widget>[
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0, -0.32),
                        radius: 0.85,
                        colors: <Color>[Color(0xE65B35E8), Color(0x005B35E8)],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: SvgPicture.asset(
                    AppAssets.splashOrbits,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      const Spacer(flex: 3),
                      const BrandMark(),
                      const SizedBox(height: 34),
                      Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Text(
                          AppStrings.appName,
                          style: AppTextStyles.display(
                            42,
                            weight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 9,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        AppStrings.tagline,
                        style: AppTextStyles.body(
                          14,
                          color: AppColors.white(0.78),
                          letterSpacing: 3,
                        ),
                      ),
                      const Spacer(flex: 4),
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 2400),
                        builder: (BuildContext context, double value, Widget? _) {
                          return Container(
                            width: 132,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.white(0.18),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: value,
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: <Color>[AppColors.primary, AppColors.primaryGlow],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppStrings.tapToContinue,
                        style: AppTextStyles.body(
                          14,
                          weight: FontWeight.w600,
                          color: AppColors.white(0.88),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppStrings.splashFooter,
                        style: AppTextStyles.body(12, color: AppColors.white(0.62)),
                      ),
                      const SizedBox(height: 20),
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
