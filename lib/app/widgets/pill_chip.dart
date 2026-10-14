import 'package:flutter/material.dart';

import '../core/core.dart';

enum PillStyle { onLight, onDark }

/// Filter or tab chip. Use [PillStyle.onDark] on gradient headers.
class PillChip extends StatelessWidget {
  const PillChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.style = PillStyle.onLight,
    this.height = 40,
    this.horizontalPadding = 18,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final PillStyle style;
  final double height;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final bool dark = style == PillStyle.onDark;
    final Color background = dark
        ? (selected ? Colors.white : Colors.transparent)
        : (selected ? AppColors.ink : AppColors.surface);
    final Color foreground = dark
        ? (selected ? AppColors.primary : Colors.white)
        : (selected ? Colors.white : AppColors.ink);
    final Color? border = selected
        ? null
        : (dark ? AppColors.white(0.45) : AppColors.border);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(height / 2),
          border: border == null ? null : Border.all(color: border, width: 1.5),
        ),
        child: Text(
          label,
          style: AppTextStyles.body(
            13,
            weight: selected ? FontWeight.w700 : FontWeight.w600,
            color: foreground,
          ),
        ),
      ),
    );
  }
}
