import 'package:flutter/material.dart';

import '../core/core.dart';

/// Primary call-to-action with the brand gradient.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.leadingIcon,
    this.trailingIcon,
    this.height = AppDimens.buttonHeight,
    this.fontSize = 16,
    this.gradient = AppGradients.button,
    this.shadowColor = AppColors.primary,
    this.width,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double height;
  final double fontSize;
  final Gradient gradient;
  final Color shadowColor;
  final double? width;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(height / 2);
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: radius,
          boxShadow: AppShadows.glow(shadowColor),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: radius,
            onTap: loading ? null : onTap,
            child: Center(
              child: loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (leadingIcon != null) ...<Widget>[
                          Icon(leadingIcon, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          label,
                          style: AppTextStyles.body(
                            fontSize,
                            weight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        if (trailingIcon != null) ...<Widget>[
                          const SizedBox(width: 10),
                          Icon(trailingIcon, color: Colors.white, size: 20),
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
