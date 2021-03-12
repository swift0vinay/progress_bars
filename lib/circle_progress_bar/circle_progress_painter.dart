import 'dart:math';
import 'package:flutter/material.dart';

class CircleProgressPainter extends CustomPainter {
  /// [backgroundColor] represents the background of arc progressing .
  /// @Default is [Colors.grey[200]]
  final backgroundColor;

  /// [progressColor] represents the Color of the arc progressing .
  /// @Default is [Colors.green[600]]
  final progressColor;

  /// [height] [width] are dimension of canvas ,
  /// [rightProgress] [leftProgress] are leftAnimation and rightAnimation values respectively ,
  double height, width, rightProgress, leftProgress, combinedProgress, arcWidth;
  bool combined;
  String version;
  CircleProgressPainter({
    this.version,
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

  /// [degToRad] function to convert angle in degrees to radians .
  num degToRad(num deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    /// [radius] is the radius of progress bar .
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

    /// [center] is the center of progress bar .
    Offset center = Offset(width / 2, height / 2);

    canvas.drawCircle(center, radius, paint);

    Rect rect = Rect.fromCircle(center: center, radius: radius);

    if (combined) {
      drawArc(
          canvas, rect, degToRad(combinedProgress), degToRad(-arcWidth), pr);
    } else {
      if (version == 'F') {
        drawArc(canvas, rect, degToRad(270 - arcWidth / 3),
            degToRad(2 * arcWidth / 3), pr);
        drawArc(
            canvas, rect, degToRad(leftProgress), degToRad(-arcWidth / 6), pr);
        drawArc(
            canvas, rect, degToRad(rightProgress), degToRad(arcWidth / 6), pr);
      } else if (version == 'S') {
        drawArc(canvas, rect, degToRad(90 + arcWidth / 6),
            degToRad(-arcWidth / 3), pr);
        drawArc(canvas, rect, degToRad(270 - arcWidth / 6),
            degToRad(arcWidth / 3), pr);
        drawArc(
            canvas, rect, degToRad(leftProgress), degToRad(-arcWidth / 6), pr);
        drawArc(
            canvas, rect, degToRad(rightProgress), degToRad(arcWidth / 6), pr);
      } else {
        drawArc(canvas, rect, degToRad(90 + arcWidth / 3),
            degToRad(-2 * arcWidth / 3), pr);
        drawArc(
            canvas, rect, degToRad(leftProgress), degToRad(-arcWidth / 6), pr);
        drawArc(
            canvas, rect, degToRad(rightProgress), degToRad(arcWidth / 6), pr);
      }
    }
  }

  /// [drawArc] uses the [canvas.drawArc] method only .
  drawArc(Canvas canvas, Rect rect, double startAngle, double sweepAngle,
      Paint pr) {
    canvas.drawArc(rect, startAngle, sweepAngle, false, pr);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
