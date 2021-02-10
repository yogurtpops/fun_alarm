import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_alarm/core/action/schedule_action.dart';
import 'package:fun_alarm/core/view/page/ringalarm/animation/animated_text.dart';
import 'package:fun_alarm/core/view/page/ringalarm/triangle_painter.dart';
import 'package:fun_alarm/core/view/page/ringalarm/upside_down_triangle_painter.dart';
import 'package:fun_alarm/router/router.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';

class RingAlarmPage extends StatefulWidget {
  const RingAlarmPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RingAlarmPageState();
  }
}

class RingAlarmPageState extends State<RingAlarmPage> with SingleTickerProviderStateMixin {

  int shakeCount = 0;
  double fillPercentage = 0;
  bool finish = false;
  AnimationController controller;
  Alignment _alignment = Alignment.topCenter;
  bool isAmTimeAlarm = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 5)
    );


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted){
        setState(() => _alignment=Alignment.bottomCenter);
      }
    });

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      if (event.x > 10 || event.x < -10){
        shake();
      }
    });

    if (DateTime.now().hour > 12) {
      isAmTimeAlarm = false;
    }
  }

  turnOffAlarm(){
    finish = true;
    controller.forward().whenComplete(() {
      controller.stop();
    });

    Provider.of<ScheduleAction>(context, listen: false).updateScheduledNotification();
  }

  updateHourGlass(){
    if (mounted){
      setState(() {
        if (fillPercentage<1){
          fillPercentage += 0.05;
        } else {
          turnOffAlarm();
        }
      });
    }
  }

  shake(){
    if (mounted){
      setState(() {
        if (shakeCount<5){
          shakeCount++;
        } else {
          shakeCount = 0;
          updateHourGlass();
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          if (finish){
            navigatorKey.currentState.pop();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Visibility(
                visible: finish,
                child: AnimatedSvgText(
                  controller: controller,
                  svg: isAmTimeAlarm ? "assets/svg/greetings_morning.svg" : "assets/svg/greetings_night.svg"
                ),
              ),
              Visibility(
                visible: !finish,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:24),
                            child: CustomPaint(
                              painter: UpsideDownTrianglePainter(
                                percentage: fillPercentage,
                                strokeColor: Colors.blue,
                                strokeWidth: 10,
                                paintingStyle: PaintingStyle.fill,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(top: 0),
                                height: 125,
                                width: 145,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:24),
                            child: CustomPaint(
                              painter: TrianglePainter(
                                percentage: fillPercentage,
                                strokeColor: Colors.blue,
                                strokeWidth: 10,
                                paintingStyle: PaintingStyle.fill,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(top: 0),
                                height: 125,
                                width: 145,
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
              Visibility(
                visible: !finish,
                child: Positioned(
                  bottom: 64,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(10.0),
                    duration: Duration(milliseconds: 300),
                    alignment: _alignment,
                    // this is good but gives me motion sickness :(
                    // onEnd: () => setState(() => _alignment==Alignment.topCenter ? _alignment=Alignment.bottomCenter : _alignment=Alignment.topCenter),
                    height: 80,
                    child: Text(
                        "Shake the Hourglass\nto Move It Faster!",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}