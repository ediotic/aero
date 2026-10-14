import 'package:flutter/material.dart';

import '../core/core.dart';

/// Rounded square with an icon inside, the building block of list rows.
class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.size = AppDimens.iconTile,
    this.background = AppColors.primarySoft,
    this.color = AppColors.primary,
    this.gradient,
  });

  final IconData icon;
  final double size;
  final Color background;
  final Color color;

  /// When set, replaces [background] (used by lounge and food tiles).
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: gradient == null ? background : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(size * 0.33),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: color, size: size * 0.52),
    );
  }
}
