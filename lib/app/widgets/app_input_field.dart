import 'package:flutter/material.dart';

import '../core/core.dart';

/// Borderless text field inside a rounded container.
class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.fillColor = AppColors.background,
    this.borderColor = AppColors.border,
    this.height = 50,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String hint;
  final IconData? prefixIcon;
  final Color fillColor;
  final Color? borderColor;
  final double height;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(height / 2.6),
        border: borderColor == null ? null : Border.all(color: borderColor!, width: 1.5),
      ),
      child: Row(
        children: <Widget>[
          if (prefixIcon != null) ...<Widget>[
            Icon(prefixIcon, color: AppColors.muted, size: 20),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: AppTextStyles.body(14),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                hintText: hint,
                hintStyle: AppTextStyles.body(14, color: AppColors.muted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
