import 'package:flutter/material.dart';

import '../core/core.dart';

/// Round icon button. Defaults to the frosted style used on gradient headers.
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = AppDimens.circleButton,
    this.iconColor = Colors.white,
    this.background,
    this.tooltip,
    this.badge = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color iconColor;
  final Color? background;
  final String? tooltip;

  /// Shows the small amber dot, used for unread notifications.
  final bool badge;

  @override
  Widget build(BuildContext context) {
    final Widget button = GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: background ?? AppColors.white(0.16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(icon, color: iconColor, size: size * 0.5),
            if (badge)
              Positioned(
                right: size * 0.25,
                top: size * 0.25,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.amber,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryDeep, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
