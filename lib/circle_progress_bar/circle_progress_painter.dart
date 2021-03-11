import 'dart:math';
import 'package:flutter/material.dart';

class CircleProgressPainter extends CustomPainter {
  /// [backgroundColor] represents the background of arc progressing .
  /// @Default is [Colors.grey[200]]
  final backgroundColor;

  /// [progressColor] represents the Color of the arc progressing .
  /// @Default is [Colors.green[600]]
  final progressColor;

  double height, width, rightProgress, leftProgress, combinedProgress, arcWidth;
  bool combined;

  CircleProgressPainter({
    this.backgroundColor,
    this.leftProgress,
    this.rightProgress,
    this.progressColor,
    this.height,
    this.arcWidth,
    this.width,
    this.combinedProgress,
    this.combined,
  });

  num degToRad(num deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = height * 0.5;

    Paint pr = Paint()
      ..color = progressColor ?? Colors.green[600]
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.25
      ..strokeCap = StrokeCap.round;

    Paint paint = Paint()
      ..color = backgroundColor ?? Colors.grey[200]
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.25
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(width / 2, height / 2);

    canvas.drawCircle(center, radius, paint);

    Rect rect = Rect.fromCircle(center: center, radius: radius);
    if (combined) {
      canvas.drawArc(
          rect, degToRad(combinedProgress), degToRad(-arcWidth), false, pr);
    } else {
      canvas.drawArc(
          rect, degToRad(leftProgress), degToRad(-arcWidth / 2), false, pr);
      canvas.drawArc(
          rect, degToRad(rightProgress), degToRad(arcWidth / 2), false, pr);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
