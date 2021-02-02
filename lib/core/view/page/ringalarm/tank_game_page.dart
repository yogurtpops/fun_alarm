// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fun_alarm/core/view/components/joypad.dart';
// import 'package:fun_alarm/core/view/page/ringalarm/game/ring_geme_layout.dart';
//
// class TankGamePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return TankGamePageState();
//   }
// }
//
// class TankGamePageState extends State<TankGamePage> {
//
//   LameTank360 game;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:     Directionality(
//         textDirection: TextDirection.ltr,
//         child: Stack(
//           children: [
//             game.widget,
//             // joypad overlay
//             Column(
//               children: [
//                 Spacer(),
//                 Row(
//                   children: [
//                     SizedBox(width: 48),
//                     Joypad(
//                       onChange: (Offset delta) => onChange(delta),
//                     ),
//                     Spacer(),
//                     Joypad(
//                       onChange: (Offset delta) => onChange(delta),
//                     ),
//                     SizedBox(width: 48),
//                   ],
//                 ),
//                 SizedBox(height: 24),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   onChange(Offset delta){
//     game.updateTankPosition(delta);
//   }
//
//   @override
//   void initState() {
//     game = LameTank360();
//   }
// }