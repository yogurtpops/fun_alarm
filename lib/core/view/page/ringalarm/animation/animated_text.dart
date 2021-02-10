import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedSvgText extends StatefulWidget {

  final String svg;
  final AnimationController controller;

  const AnimatedSvgText({Key key, this.controller, this.svg}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnimatedSvgTextState();
  }
}

class AnimatedSvgTextState extends State<AnimatedSvgText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: AnimatedDrawing.svg(
          widget.svg,
          controller: widget.controller
      ),
    );
  }
}