import 'package:flutter/material.dart';

import '../core/core.dart';

/// Icon tile with a label underneath, used in the Home quick actions row.
class QuickActionItem extends StatelessWidget {
  const QuickActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 78,
        child: Column(
          children: <Widget>[
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppShadows.soft,
              ),
              child: Icon(icon, color: AppColors.primary, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(12, weight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
