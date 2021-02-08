import 'package:flutter_neumorphic/flutter_neumorphic.dart';

var neumorphicTheme = NeumorphicTheme(
  themeMode: ThemeMode.light,
  darkTheme: NeumorphicThemeData(
    baseColor: Color(0xff333333),
    accentColor: Colors.green,
    lightSource: LightSource.topLeft,
    depth: 4,
    intensity: 0.3,
  ),
  theme: NeumorphicThemeData(
    shadowDarkColor: Color(0xff6E85D5),
    baseColor: Color(0xffC4CDEE),
    accentColor: Color(0xffB8CDF8),
    lightSource: LightSource.topLeft,
    depth: 6,
    intensity: 0.5,
  ),
);

var neumorphicTextTheme = NeumorphicTheme(
  themeMode: ThemeMode.dark,
  darkTheme: NeumorphicThemeData(
    baseColor: Color(0xff41463D),
    // accentColor: Colors.green,
    lightSource: LightSource.topLeft,
    depth: 4,
    intensity: 0.3,
  ),
  theme: NeumorphicThemeData(
    shadowDarkColor: Color(0xff6E85D5),
    baseColor: Color(0xffC4CDEE),
    accentColor: Color(0xffB8CDF8),
    lightSource: LightSource.topLeft,
    depth: 6,
    intensity: 0.5,
  ),
);

var ThemeLight = ThemeData(
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
  textTheme: TextTheme(
    headline6: TextStyle(color: Color(0xff41463D)),
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Color(0xff41463D)),
    bodyText2: TextStyle(fontSize: 14.0, color: Color(0xff41463D), fontWeight: FontWeight.bold, letterSpacing: 1.5),
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
);