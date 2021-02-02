// import 'dart:ui';
// import 'package:flame/game.dart';
// import 'file:///D:/personal/fun_alarm/lib/core/view/page/ringalarm/game/ghost.dart';
//
// class LameTank360 extends Game {
//   Size screenSize;
//   Tank tank;
//
//   @override
//   void render(Canvas c) {
//     if (screenSize == null) {
//       return; // just end execution if there's no screenSize
//     }
//
//     // draw a grass field
//     c.drawRect(
//       Rect.fromLTWH(
//         0,
//         0,
//         screenSize.width,
//         screenSize.height,
//       ),
//       Paint()..color = Color(0xff27ae60),
//     );
//
//     tank.render(c);
//   }
//
//   @override
//   void update(double t) {
//     if (screenSize == null) {
//       return; // just end execution if there's no screenSize
//     }
//   }
//
//   void updateTankPosition(Offset delta){
//     if (tank.position + delta < screenSize && tank.position + delta > Offset.zero) {
//       tank.position = tank.position + delta;
//     }
//   }
//
//   @override
//   void resize(Size size) {
//     screenSize = size;
//
//     if (tank == null) {
//       tank = Tank(
//         this,
//         position: Offset(
//           screenSize.width / 2,
//           screenSize.height / 2,
//         ),
//       );
//     }
//   }
// }