import 'package:flutter/material.dart';

import '../core/core.dart';
import '../data/data.dart';

/// Small pill used for badges and statuses ("Cheapest", "On time", "Delayed").
class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    this.dotColor,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  /// Picks colours from a [BadgeTone].
  factory StatusChip.tone(String label, BadgeTone tone, {double fontSize = 11}) {
    switch (tone) {
      case BadgeTone.success:
        return StatusChip(
          label: label,
          background: AppColors.successSoft,
          foreground: AppColors.success,
          fontSize: fontSize,
        );
      case BadgeTone.primary:
        return StatusChip(
          label: label,
          background: AppColors.primarySoft,
          foreground: AppColors.primary,
          fontSize: fontSize,
        );
      case BadgeTone.warning:
        return StatusChip(
          label: label,
          background: AppColors.warningSoft,
          foreground: AppColors.warningText,
          fontSize: fontSize,
        );
      case BadgeTone.neutral:
        return StatusChip(
          label: label,
          background: AppColors.background,
          foreground: AppColors.muted,
          fontSize: fontSize,
        );
    }
  }

  /// Picks colours and the dot from a [FlightStatusType].
  factory StatusChip.flightStatus(FlightStatusType type) {
    switch (type) {
      case FlightStatusType.onTime:
        return const StatusChip(
          label: AppStrings.statusOnTime,
          background: AppColors.successSoft,
          foreground: AppColors.success,
          dotColor: AppColors.successDot,
        );
      case FlightStatusType.delayed:
        return const StatusChip(
          label: AppStrings.statusDelayed,
          background: AppColors.warningSoft,
          foreground: AppColors.warningText,
          dotColor: AppColors.warningDot,
        );
      case FlightStatusType.cancelled:
        return const StatusChip(
          label: AppStrings.statusCancelled,
          background: AppColors.dangerSoft,
          foreground: AppColors.danger,
          dotColor: AppColors.dangerDot,
        );
    }
  }

  final String label;
  final Color background;
  final Color foreground;
  final Color? dotColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimens.chipRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (dotColor != null) ...<Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTextStyles.body(fontSize, weight: FontWeight.w700, color: foreground),
          ),
        ],
      ),
    );
  }
}
