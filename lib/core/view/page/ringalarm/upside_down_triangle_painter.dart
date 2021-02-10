import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpsideDownTrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double percentage;

  UpsideDownTrianglePainter({
    this.percentage, this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    double yPosition = y*percentage;
    double xPosition = (x-(x*(1-percentage)))/2;

    return Path()
      ..moveTo(x/2, y)
      ..lineTo(xPosition, yPosition)
      ..lineTo(x-xPosition, yPosition)
      ..lineTo(x/2, y);
  }

  @override
  bool shouldRepaint(UpsideDownTrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.percentage != percentage;
  }
}