import 'package:flutter/material.dart';

import '../core/core.dart';
import '../data/data.dart';

/// One seat on the seat map. 36px square with state-based colours.
class SeatBox extends StatelessWidget {
  const SeatBox({
    super.key,
    required this.seat,
    required this.selected,
    required this.onTap,
    this.size = 36,
  });

  final Seat seat;
  final bool selected;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final bool taken = seat.state == SeatState.taken;
    final bool premium = seat.state == SeatState.premium;

    final Color fill = taken
        ? AppColors.seatTaken
        : premium
            ? AppColors.warningSofter
            : AppColors.surface;
    final Color border = premium ? AppColors.seatPremiumBorder : AppColors.border;

    return GestureDetector(
      onTap: taken ? null : onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: selected ? AppGradients.seatSelected : null,
          color: selected ? null : fill,
          borderRadius: BorderRadius.circular(10),
          border: selected ? null : Border.all(color: border, width: 1.5),
        ),
        child: taken
            ? const Icon(Icons.close_rounded, size: 16, color: AppColors.seatTakenIcon)
            : Text(
                seat.letter,
                style: AppTextStyles.body(
                  12,
                  weight: FontWeight.w700,
                  color: selected ? Colors.white : AppColors.muted,
                ),
              ),
      ),
    );
  }
}
