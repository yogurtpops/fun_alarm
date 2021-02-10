import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double percentage;

  TrianglePainter({this.percentage, this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    final tanElevation = 1.73205080757;
    double yPosition = y*percentage;
    double xPosition = (x-(2*(y*(1-percentage))/tanElevation))/2;

    return Path()
      ..moveTo(0, y)
      ..lineTo(x, y)
      ..lineTo(x-xPosition, y-yPosition)
      ..lineTo(xPosition, y-yPosition)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.percentage != percentage;
  }
}