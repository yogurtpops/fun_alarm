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