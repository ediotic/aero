import 'package:flutter/material.dart';

import '../core/core.dart';

class RadioDot extends StatelessWidget {
  const RadioDot({super.key, required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? AppColors.primary : AppColors.radioIdle;
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      alignment: Alignment.center,
      child: selected
          ? Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            )
          : null,
    );
  }
}
