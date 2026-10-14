import 'package:flutter/material.dart';

import '../core/core.dart';

/// Circle with the airline's two-letter code on its brand colour.
class AirlineLogo extends StatelessWidget {
  const AirlineLogo({super.key, required this.code, this.size = 38});

  final String code;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: AppColors.airline(code), shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        code,
        style: AppTextStyles.body(size * 0.34, weight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}
