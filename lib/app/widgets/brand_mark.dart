import 'package:flutter/material.dart';

import '../core/core.dart';
import 'plane_icon.dart';

/// The rounded gradient logo tile with the plane glyph.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 112, this.glow = true});

  final double size;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppGradients.brandMark,
        borderRadius: BorderRadius.circular(size * 0.3),
        border: Border.all(color: AppColors.white(0.35), width: 1.5),
        boxShadow: glow
            ? <BoxShadow>[
                BoxShadow(
                  color: AppColors.alpha(AppColors.primary, 0.55),
                  blurRadius: 50,
                  offset: const Offset(0, 20),
                ),
                BoxShadow(
                  color: AppColors.alpha(AppColors.primaryLight, 0.14),
                  spreadRadius: size * 0.125,
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: PlaneIcon(size: size * 0.5, angle: PlaneIcon.diagonal),
    );
  }
}
