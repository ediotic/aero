import 'package:flutter/material.dart';

import '../core/core.dart';

/// Centered spinner for lists that are still loading.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.height = 240});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}

/// Message shown when a list has nothing to display.
class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.message, this.icon = Icons.inbox_outlined});

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 40, color: AppColors.mutedLight),
          const SizedBox(height: 12),
          Text(message, style: AppTextStyles.body(14, color: AppColors.muted)),
        ],
      ),
    );
  }
}
