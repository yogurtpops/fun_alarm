import 'dart:math';

import 'package:flutter/material.dart';


class HourHandPainter extends CustomPainter{
  final Paint hourHandPaint;
  int hours;
  int minutes;

  HourHandPainter({this.hours, this.minutes}):hourHandPaint= new Paint(){
    hourHandPaint.color= Colors.black87;
    hourHandPaint.style= PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width/2;
    // To draw hour hand
    canvas.save();

    canvas.translate(radius, radius);

    //checks if hour is greater than 12 before calculating rotation
    canvas.rotate(this.hours>=12?
    2*pi*((this.hours-12)/12 + (this.minutes/720)):
    2*pi*((this.hours/12)+ (this.minutes/720))
    );


    Path path= new Path();

    //hour hand stem
    path.moveTo(-2.0, -radius+radius/4);
    path.lineTo(-2.0, 0.0);
    path.lineTo(2.0, 0.0);
    path.lineTo(2.0, -radius+radius/4);
    path.close();

    canvas.drawPath(path, hourHandPaint);
    // canvas.drawShadow(path, Colors.black, 2.0, false);


    canvas.restore();

  }

  @override
  bool shouldRepaint(HourHandPainter oldDelegate) {
    return true;
  }
}


class MinuteHandPainter extends CustomPainter{
  final Paint minuteHandPaint;
  int minutes;
  int seconds;

  MinuteHandPainter({this.minutes, this.seconds}):minuteHandPaint= new Paint(){
    minuteHandPaint.color= const Color(0xFF333333);
    minuteHandPaint.style= PaintingStyle.fill;

  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius= size.width/2;
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2*pi*((this.minutes+(this.seconds/60))/60));

    Path path= new Path();
    path.moveTo(-2.0, -radius+radius/8);
    path.lineTo(-2.0, 0.0);
    path.lineTo(2.0, 0.0);
    path.lineTo(2.0, -radius+radius/8);
    path.close();

    canvas.drawPath(path, minuteHandPaint);
    // canvas.drawShadow(path, Colors.black, 2.0, false);


    canvas.restore();

  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}