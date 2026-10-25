import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom painter that renders a smooth dashed/dotted rounded rectangle border.
class DashedRectPainter extends CustomPainter {
  const DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dash = 6.0,
    this.gap = 4.0,
    this.radius = 16.0,
  });

  final Color color;
  final double strokeWidth;
  final double dash;
  final double gap;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metricsList = path.computeMetrics().toList();
    if (metricsList.isEmpty) return;

    final metrics = metricsList.first;
    final totalLength = metrics.length;

    double currentDistance = 0.0;
    final dashedPath = Path();

    while (currentDistance < totalLength) {
      final endDistance = math.min(currentDistance + dash, totalLength);
      dashedPath.addPath(
        metrics.extractPath(currentDistance, endDistance),
        Offset.zero,
      );
      currentDistance += dash + gap;
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(DashedRectPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.dash != dash ||
      oldDelegate.gap != gap ||
      oldDelegate.radius != radius;
}
