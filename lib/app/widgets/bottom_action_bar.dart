import 'package:flutter/material.dart';

import '../core/core.dart';

/// White bar pinned to the bottom with rounded top corners (price + button).
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double inset = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + inset),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimens.sheetRadius)),
        boxShadow: AppShadows.bar,
      ),
      child: child,
    );
  }
}
