import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_alarm/core/view/components/joypad.dart';
import 'package:fun_alarm/core/view/page/ringalarm/game/ring_geme_layout.dart';

class RingAlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RingAlarmPageState();
  }
}

class RingAlarmPageState extends State<RingAlarmPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:     Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            game.widget,
            // joypad overlay
            Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    SizedBox(width: 48),
                    Joypad(
                      onChange: (Offset delta) => print(delta),
                    ),
                    Spacer(),
                    Joypad(
                      onChange: (Offset delta) => print(delta),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void moveLeft(){

  }

  void moveUp(){

  }

  LameTank360 game;

  @override
  void initState() {
    game = LameTank360();
  }
}