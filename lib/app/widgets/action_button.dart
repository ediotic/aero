import 'package:flutter/material.dart';

import '../core/core.dart';

/// Secondary pill button: soft, outlined or danger styles.
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.background = AppColors.background,
    this.foreground = AppColors.ink,
    this.borderColor,
    this.height = 48,
    this.fontSize = 13,
  });

  /// Pale red button for destructive actions.
  const ActionButton.danger({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.height = 48,
    this.fontSize = 13,
  })  : background = AppColors.dangerSofter,
        foreground = AppColors.danger,
        borderColor = null;

  /// White outlined button.
  const ActionButton.outlined({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.height = 48,
    this.fontSize = 13,
  })  : background = Colors.transparent,
        foreground = AppColors.ink,
        borderColor = AppColors.border;

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color background;
  final Color foreground;
  final Color? borderColor;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(height / 2);
    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: borderColor == null
            ? BorderSide.none
            : BorderSide(color: borderColor!, width: 1.5),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, color: foreground, size: 16),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body(fontSize, weight: FontWeight.w700, color: foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
