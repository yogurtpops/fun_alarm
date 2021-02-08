import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fun_alarm/core/configs/themes.dart';
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
          theme: ThemeLight
        );
      }
    );
  }
}

