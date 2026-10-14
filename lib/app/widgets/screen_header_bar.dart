import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/core.dart';
import 'circle_icon_button.dart';

/// Back button, centred title and optional trailing widget. Sits inside the
/// gradient header of most screens.
class ScreenHeaderBar extends StatelessWidget {
  const ScreenHeaderBar({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onBack,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppDimens.screenPadding, 12, AppDimens.screenPadding, 0),
      child: Row(
        children: <Widget>[
          CircleIconButton(
            icon: Icons.chevron_left_rounded,
            tooltip: AppStrings.back,
            onTap: onBack ?? () => Get.back<void>(),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.screenTitle,
                ),
                if (subtitle != null) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body(12, color: AppColors.white(0.82)),
                  ),
                ],
              ],
            ),
          ),
          trailing ?? const SizedBox(width: AppDimens.circleButton),
        ],
      ),
    );
  }
}
