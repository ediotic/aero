import 'package:flutter/material.dart';

import '../core/core.dart';

/// "Label ........ value" row used in fare summaries.
class FareRow extends StatelessWidget {
  const FareRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: isTotal
              ? AppTextStyles.body(15, weight: FontWeight.w700)
              : AppTextStyles.body(14, color: AppColors.muted),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.display(24, color: AppColors.primary)
              : AppTextStyles.body(14, weight: FontWeight.w700),
        ),
      ],
    );
  }
}
