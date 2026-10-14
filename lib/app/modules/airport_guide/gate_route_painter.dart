import 'package:flutter/material.dart';

import 'package:aerova_app/app/core/core.dart';

/// Simple terminal sketch: entrance -> security -> gate, drawn with a dashed path.
class GateRoutePainter extends CustomPainter {
  const GateRoutePainter({required this.gate});

  final String gate;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = AppColors.primarySoft;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(22)),
      bg,
    );

    final Paint block = Paint()..color = AppColors.primaryBorder;
    final List<Rect> blocks = <Rect>[
      Rect.fromLTWH(size.width * 0.08, size.height * 0.12, size.width * 0.26, size.height * 0.24),
      Rect.fromLTWH(size.width * 0.42, size.height * 0.12, size.width * 0.22, size.height * 0.24),
      Rect.fromLTWH(size.width * 0.72, size.height * 0.62, size.width * 0.2, size.height * 0.26),
    ];
    for (final Rect r in blocks) {
      canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(10)), block);
    }

    final Offset start = Offset(size.width * 0.12, size.height * 0.78);
    final Offset mid = Offset(size.width * 0.5, size.height * 0.52);
    final Offset end = Offset(size.width * 0.84, size.height * 0.34);

    final Path path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(start.dx, mid.dy)
      ..lineTo(mid.dx, mid.dy)
      ..lineTo(end.dx - 30, mid.dy)
      ..lineTo(end.dx - 30, end.dy)
      ..lineTo(end.dx, end.dy);

    final Paint line = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final metric in path.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 7), line);
        d += 13;
      }
    }

    canvas.drawCircle(start, 8, Paint()..color = AppColors.success);
    canvas.drawCircle(mid, 6, Paint()..color = AppColors.amber);

    canvas.drawCircle(end, 14, Paint()..color = AppColors.primary);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: gate,
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, end - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant GateRoutePainter old) => old.gate != gate;
}
