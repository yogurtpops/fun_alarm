import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_alarm/router/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }


}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) => navigatorKey.currentState.pushNamed(RouteName.dashboardPage));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}