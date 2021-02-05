import 'package:flutter/cupertino.dart';
import 'package:fun_alarm/core/view/page/createalarm/create_alarm_page.dart';
import 'package:fun_alarm/core/view/page/dashboard/dashboard_page.dart';
import 'package:fun_alarm/core/view/page/ringalarm/ring_alarm_page.dart';
import 'package:fun_alarm/core/view/page/splash/splash_screen.dart';

String initialRoute = RouteName.dashboardPage;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouteName {
  static String splashScreen = "splashScreen";
  static String dashboardPage = "dashboardPage";
  static String createAlarmPage = "createAlarmPage";
  static String ringAlarmPage = "ringAlarmPage";
}

Map<String, WidgetBuilder> routes = {
  RouteName.dashboardPage: (context) => DashboardPage(),
  RouteName.createAlarmPage: (context) => CreateAlarPage(),
  RouteName.ringAlarmPage: (context) => RingAlarmPage(),
  RouteName.splashScreen: (context) => SplashScreen(),
};