import 'package:flutter/material.dart';

import 'package:aerova_app/app/core/core.dart';

import 'route_geometry.dart';

/// Draws the full route dashed, the flown part solid, and the two airports.
class RoutePainter extends CustomPainter {
  const RoutePainter({required this.progress, required this.fromCode, required this.toCode});

  final double progress;
  final String fromCode;
  final String toCode;

  @override
  void paint(Canvas canvas, Size size) {
    final RouteGeometry geo = RouteGeometry(size);
    final Path full = geo.path;

    final Paint dashed = Paint()
      ..color = AppColors.white(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (final metric in full.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 8), dashed);
        d += 15;
      }
    }

    final Paint flown = Paint()
      ..shader = const LinearGradient(colors: <Color>[AppColors.primaryGlow, Colors.white])
          .createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    for (final metric in full.computeMetrics()) {
      canvas.drawPath(metric.extractPath(0, metric.length * progress.clamp(0.0, 1.0)), flown);
    }

    _airport(canvas, geo.start, fromCode, below: true);
    _airport(canvas, geo.end, toCode, below: true);
  }

  void _airport(Canvas canvas, Offset p, String code, {required bool below}) {
    canvas.drawCircle(p, 9, Paint()..color = Colors.white);
    canvas.drawCircle(p, 5, Paint()..color = AppColors.primary);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: code,
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(p.dx - tp.width / 2, p.dy + (below ? 16 : -30)));
  }

  @override
  bool shouldRepaint(covariant RoutePainter old) =>
      old.progress != progress || old.fromCode != fromCode || old.toCode != toCode;
}
