import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_alarm/core/view/page/ringalarm/rive_animation.dart';
import 'package:fun_alarm/core/view/page/ringalarm/triangle_painter.dart';

class RingAlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RingAlarmPageState();
  }
}

class RingAlarmPageState extends State<RingAlarmPage> with SingleTickerProviderStateMixin {
  GlobalKey<MyRiveAnimationState> alarmAnimationKey = GlobalKey();

  bool finish = false;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this
    );
    WidgetsBinding.instance.addObserver(alarmAnimationKey?.currentState?.startLoop('ringing'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: finish,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: AnimatedDrawing.svg(
                "assets/svg/goodmorning.svg",
                run: finish,
                duration: new Duration(seconds: 3),
                controller: controller,
                onFinish: () => setState(() {
                  controller.stop();
                }),
              ),
            ),
          ),
          Visibility(
            visible: !finish,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPaint(
                      painter: TrianglePainter(
                        strokeColor: Colors.blue,
                        strokeWidth: 10,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 0),
                        height: 145,
                        width: 150,
                      ),
                    ),
                  ],
                ),
                Container(
                    child: SvgPicture.asset("assets/svg/hourglass.svg")),
              ],
            ),
          ),
          Positioned(
            bottom: 64,
            child: Container(
              // width: 80,
              // height: 80,
              child: InkWell(
                onTap: () => setState(()=>finish=!finish),
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
    );
  }

}