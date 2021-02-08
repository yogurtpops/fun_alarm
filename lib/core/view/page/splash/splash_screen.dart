import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_alarm/core/view/page/ringalarm/triangle_painter.dart';
import 'package:fun_alarm/core/view/page/ringalarm/upside_down_triangle_painter.dart';
import 'package:fun_alarm/router/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  double fillPercentage = 0;
  Timer t;

  @override
  void initState() {
    t = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (fillPercentage<1){
        setState(() {
          fillPercentage+=.2;
        });
      } else {
        navigatorKey.currentState.pushReplacementNamed(RouteName.dashboardPage);
      }
    });
  }


  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 54, horizontal: 48),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    child: CustomPaint(
                      painter: UpsideDownTrianglePainter(
                        percentage: fillPercentage,
                        strokeColor: Colors.blue,
                        strokeWidth: 10,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: Container(
                        height: 120,
                        width: 140,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36.0),
                    child: CustomPaint(
                      painter: TrianglePainter(
                        percentage: fillPercentage,
                        strokeColor: Colors.blue,
                        strokeWidth: 10,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 0),
                        height: 120,
                        width: 140,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  child: SvgPicture.asset("assets/svg/hourglass.svg")),
            ],
          ),
        ),
      ),
    );
  }

}