import 'dart:math' as math;
import 'dart:ui';

/// Curved flight path shared by the painter and the plane marker so they
/// always agree on where the route is.
class RouteGeometry {
  const RouteGeometry(this.size);

  final Size size;

  Offset get start => Offset(size.width * 0.12, size.height * 0.72);
  Offset get control => Offset(size.width * 0.5, size.height * 0.08);
  Offset get end => Offset(size.width * 0.88, size.height * 0.62);

  Path get path => Path()
    ..moveTo(start.dx, start.dy)
    ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);

  Offset pointAt(double t) {
    final double u = 1 - t;
    return Offset(
      u * u * start.dx + 2 * u * t * control.dx + t * t * end.dx,
      u * u * start.dy + 2 * u * t * control.dy + t * t * end.dy,
    );
  }

  /// Direction of travel at [t], as an angle where 0 = up and pi/2 = right.
  double angleAt(double t) {
    final double u = 1 - t;
    final double dx = 2 * u * (control.dx - start.dx) + 2 * t * (end.dx - control.dx);
    final double dy = 2 * u * (control.dy - start.dy) + 2 * t * (end.dy - control.dy);
    return math.atan2(dx, -dy);
  }
}
