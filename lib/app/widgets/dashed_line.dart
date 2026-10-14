import 'package:flutter/material.dart';

import '../core/core.dart';
import 'plane_icon.dart';

/// Horizontal dashed line. Must be given a bounded width (put it in an
/// Expanded, a Column or a SizedBox).
class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    this.color = AppColors.dash,
    this.thickness = 2,
    this.dashWidth = 4,
    this.dashGap = 5,
  });

  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashGap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thickness,
      width: double.infinity,
      child: CustomPaint(
        painter: _DashedPainter(
          color: color,
          thickness: thickness,
          dashWidth: dashWidth,
          dashGap: dashGap,
        ),
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  _DashedPainter({
    required this.color,
    required this.thickness,
    required this.dashWidth,
    required this.dashGap,
  });

  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashGap;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;
    final double y = size.height / 2;
    double x = 0;
    while (x < size.width) {
      final double end = (x + dashWidth).clamp(0, size.width).toDouble();
      canvas.drawLine(Offset(x, y), Offset(end, y), paint);
      x += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) =>
      old.color != color ||
      old.thickness != thickness ||
      old.dashWidth != dashWidth ||
      old.dashGap != dashGap;
}

/// Dashed line with a small plane in the middle. Use inside an Expanded.
class RouteLine extends StatelessWidget {
  const RouteLine({
    super.key,
    this.lineColor = AppColors.dash,
    this.planeColor = AppColors.primary,
    this.backgroundColor = AppColors.surface,
  });

  final Color lineColor;
  final Color planeColor;

  /// Behind the plane, so the dashes do not run through it. Match the card.
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          DashedLine(color: lineColor),
          Container(
            color: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: PlaneIcon(size: 20, color: planeColor, angle: PlaneIcon.right),
          ),
        ],
      ),
    );
  }
}
