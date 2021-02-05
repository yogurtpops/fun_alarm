import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fun_alarm/provider/providers.dart';
import 'package:fun_alarm/router/router.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = <T>(T value) {
    return true;
  };

  runApp(FunAlarm());
}

class FunAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, snapshot) {
        return MaterialApp(
          routes: routes,
          initialRoute: initialRoute,
          navigatorKey: navigatorKey,
          theme: ThemeData(
               primaryColor: Color(0xff383B53),
               primaryColorLight: Color(0xff383B53),
               primaryColorDark: Color(0xff383B53),
               canvasColor: Color(0xff383B53),
               bottomAppBarColor: Color(0xff383B53),
               dividerColor: Color(0xff383B53),
               focusColor: Color(0xff383B53),
               hoverColor: Color(0xff383B53),
               splashColor: Color(0xff383B53),
               selectedRowColor: Color(0xff383B53),
               unselectedWidgetColor: Color(0xff383B53),
               disabledColor: Color(0xff383B53),
               secondaryHeaderColor: Color(0xff383B53),
               textSelectionColor: Color(0xff383B53),
               cursorColor: Color(0xff383B53),
               textSelectionHandleColor: Color(0xff383B53),
               dialogBackgroundColor: Color(0xff383B53),
               indicatorColor: Color(0xff383B53),
               hintColor: Color(0xff383B53),
              highlightColor: Colors.white,
              accentColor: Color(0xff95F2D9),
              cardColor: Color(0xff1CFEBA),
              buttonColor: Color(0xff383B53),
              shadowColor: Color(0xf6E85D5),
              backgroundColor: Color(0xffCCD9CD),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryTextTheme: TextTheme(
                  headline6: TextStyle(
                      color: Color(0xff41463D)
                  ),
                headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Color(0xff41463D)),
                bodyText2: TextStyle(fontSize: 14.0, color: Color(0xff41463D), fontWeight: FontWeight.bold),
              ),
              appBarTheme: AppBarTheme(
                color: Color(0xffCCD9CD),
                elevation: 0,
                actionsIconTheme: IconThemeData(
                    color: Color(0xff41463D)
                ),
                iconTheme: IconThemeData(
                    color: Color(0xff41463D)
                ),
              ),
              iconTheme: IconThemeData(
                color: Color(0xff41463D)
              ),
              scaffoldBackgroundColor: Color(0xffCCD9CD),
          ),
        );
      }
    );
  }
}


