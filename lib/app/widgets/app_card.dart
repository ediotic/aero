import 'package:flutter/material.dart';

import '../core/core.dart';

/// White rounded card with the standard soft shadow.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = AppDimens.cardRadius,
    this.color = AppColors.surface,
    this.onTap,
    this.shadows,
    this.borderColor,
    this.borderWidth = 1.5,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;
  final VoidCallback? onTap;
  final List<BoxShadow>? shadows;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(radius);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: borderColor == null ? null : Border.all(color: borderColor!, width: borderWidth),
        boxShadow: shadows ?? AppShadows.card,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
