import 'package:flutter/cupertino.dart';
import 'package:fun_alarm/core/view/page/dashboard_page/dashboard_page.dart';
import 'package:fun_alarm/main.dart';

String initialRoute = RouteName.dashboardPage;

var navigatorKey = GlobalKey<NavigatorState>();

class RouteName {
  static String splashScreen = "splashScreen";
  static String dashboardPage = "dashboardPage";
  static String createAlarmPage = "createAlarmPage";
  static String ringAlarmPage = "ringAlarmPage";
}

Map<String, WidgetBuilder> routes = {
  RouteName.dashboardPage: (context) => DashboardPage(),

};