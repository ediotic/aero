import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/core.dart';

/// The plane glyph. With `angle: 0` it points up; angles are in radians and
/// rotate clockwise.
class PlaneIcon extends StatelessWidget {
  const PlaneIcon({
    super.key,
    this.size = 24,
    this.color = Colors.white,
    this.angle = 0,
  });

  /// Pointing right (used on route lines).
  static const double right = math.pi / 2;

  /// Pointing up and to the right (used on the nav button and brand mark).
  static const double diagonal = math.pi / 4;

  final double size;
  final Color color;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: SvgPicture.asset(
        AppAssets.plane,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
