import 'package:flutter/material.dart';
import '../models/weight_entry.dart';

class WeightChartPainter extends CustomPainter {
  final List<WeightEntry> entries;

  WeightChartPainter({required this.entries});

  @override
  void paint(Canvas canvas, Size size) {
    if (entries.length < 2) return;

    // Calculate min and max weight for scaling
    double minWeight = entries
        .map((e) => e.weight)
        .reduce((a, b) => a < b ? a : b);
    double maxWeight = entries
        .map((e) => e.weight)
        .reduce((a, b) => a > b ? a : b);

    // Add padding to min and max
    minWeight = (minWeight - 2).clamp(0, double.infinity);
    maxWeight = maxWeight + 2;

    final range = maxWeight - minWeight;
    if (range == 0) return;

    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()
      ..color = Colors.green.shade700
      ..style = PaintingStyle.fill;

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.green.withOpacity(0.3), Colors.green.withOpacity(0.1)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final xStep = size.width / (entries.length - 1);
    final heightScale = size.height / range;

    Path linePath = Path();
    Path fillPath = Path();

    Offset? firstPoint;

    for (int i = 0; i < entries.length; i++) {
      final x = i * xStep;
      final y = size.height - ((entries[i].weight - minWeight) * heightScale);

      final point = Offset(x, y);
      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
        firstPoint = point;
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      // Draw points
      canvas.drawCircle(point, 6, pointPaint);
      canvas.drawCircle(point, 3, Paint()..color = Colors.white);

      // Add labels
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${entries[i].weight.toStringAsFixed(1)} kg',
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - 20, y - 20));
    }

    // Draw fill area
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, gradientPaint);

    // Draw the line
    canvas.drawPath(linePath, paint);

    // Draw horizontal grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    for (double i = minWeight; i <= maxWeight; i += (range / 4)) {
      final y = size.height - ((i - minWeight) * heightScale);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant WeightChartPainter oldDelegate) {
    return entries != oldDelegate.entries;
  }
}
