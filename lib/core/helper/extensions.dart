import 'dart:ui';

import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension BoolExtension on bool {
  static bool fromString(String bool) {
    return bool=='true';
  }
}

extension TimeDayExtension on TimeOfDay {
  int toMinutes() {
    return this.hour * 60 + this.minute;
  }

  int compareTo(TimeOfDay second){
    if (this.hour > second.hour)
      return 1;
    else if (this.hour < second.hour)
      return 2;
    else
    if (this.minute > second.minute)
      return 1;
    else if (this.minute < second.minute)
      return 2;
    else
      return 0;
  }

  String toTwelveHourFormat(){
    int hour = this.hour;
    bool am = true;
    if (hour>12){
      am = false;
      hour = hour-12;
    }

    return (hour<=9 ? "0$hour" : "$hour") + ":"
        + (minute<=9 ? "0$minute" : "$minute")
      + (am ? " AM" : " PM");
  }

  String print(){
    return (hour<=9 ? "0$hour" : "$hour") + ":"
        + (minute<=9 ? "0$minute" : "$minute");
  }
}
