import 'dart:math';

import 'package:flutter/material.dart';

class TwoSegment3DPieChart extends StatelessWidget {
  final double paidAmount;
  final double dueAmount;
  final Color paidColor;
  final Color dueColor;
  final double depth;

  const TwoSegment3DPieChart({
    super.key,
    required this.paidAmount,
    required this.dueAmount,
    required this.paidColor,
    required this.dueColor,
    this.depth = 15,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TwoSegment3DPiePainter(
        paidAmount: paidAmount,
        dueAmount: dueAmount,
        paidColor: paidColor,
        dueColor: dueColor,
        depth: depth,
      ),
    );
  }
}

class _TwoSegment3DPiePainter extends CustomPainter {
  final double paidAmount;
  final double dueAmount;
  final Color paidColor;
  final Color dueColor;
  final double depth;

  _TwoSegment3DPiePainter({
    required this.paidAmount,
    required this.dueAmount,
    required this.paidColor,
    required this.dueColor,
    required this.depth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final total = paidAmount + dueAmount;
    final radius = size.width / 2;
    final center = Offset(radius, radius - depth / 2);

    final paidAngle = (paidAmount / total) * 2 * pi;
    final dueAngle = (dueAmount / total) * 2 * pi;

    final colors = [paidColor, dueColor];
    final angles = [paidAngle, dueAngle];
    final labels = [
      '${(paidAmount / total * 100).toStringAsFixed(1)}%',
      '${(dueAmount / total * 100).toStringAsFixed(1)}%'
    ];

    double startAngle = -pi / 2;

    // Draw 3D depth
    for (int d = depth.toInt(); d >= 0; d--) {
      double yOffset = d.toDouble();
      double angleStart = startAngle;

      for (int i = 0; i < 2; i++) {
        final paint = Paint()
          ..color = colors[i].withOpacity(1.0 - (d / (depth * 1.5)));

        canvas.drawArc(
          Rect.fromCircle(center: Offset(center.dx, center.dy + yOffset), radius: radius),
          angleStart,
          angles[i],
          true,
          paint,
        );

        angleStart += angles[i];
      }
    }

    // Draw top slices with gradients
    // Draw top slices with gradients and shadow
    double topStart = startAngle;

    // Create a path for the top circle shadow
    final shadowPath = Path();
    shadowPath.addOval(Rect.fromCircle(center: center, radius: radius));

    canvas.drawShadow(shadowPath, Colors.black.withOpacity(0.7), 6.0, true);

    for (int i = 0; i < 2; i++) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            colors[i].withOpacity(0.95),
            colors[i].withOpacity(0.7),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        topStart,
        angles[i],
        true,
        paint,
      );

      // Draw percentage label
      final labelAngle = topStart + angles[i] / 2;
      final labelRadius = radius * 0.6;
      final labelX = center.dx + labelRadius * cos(labelAngle);
      final labelY = center.dy + labelRadius * sin(labelAngle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(labelX - textPainter.width / 2, labelY - textPainter.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();

      topStart += angles[i];
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}