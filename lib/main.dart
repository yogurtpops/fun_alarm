import 'package:flutter/material.dart';
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

// Todo : wrap with multiprovider
class FunAlarm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: initialRoute,
      navigatorKey: navigatorKey,

      theme: ThemeData(
        backgroundColor: Colors.blueGrey[100],
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.black
            ),
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
        )
      ),
    );
  }
}
