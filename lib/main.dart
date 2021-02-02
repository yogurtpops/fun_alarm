import 'package:flutter/material.dart';
import 'package:fun_alarm/provider/providers.dart';
import 'package:fun_alarm/router/router.dart';
import 'package:provider/provider.dart';

import 'core/helper/warm_up_rive.dart';

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
            backgroundColor: Colors.pink[100],
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryTextTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.white
                ),
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
              bodyText2: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            appBarTheme: AppBarTheme(
              color: Colors.pink[100],
              elevation: 0,
              actionsIconTheme: IconThemeData(
                  color: Colors.white
              ),
              iconTheme: IconThemeData(
                  color: Colors.white
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            scaffoldBackgroundColor: Colors.pink[100]
          ),
        );
      }
    );
  }
}
