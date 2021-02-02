// import 'package:flutter/services.dart';
//
// const _filesToWarmup = [
//   "assets/anim/cup.riv",
//   "assets/anim/alarm.riv",
// ];
//
// /// Ensure all Flare assets used by this app are cached and ready to
// /// be displayed as quickly as possible.
// Future<void> warmupFlare() async {
//   for (final filename in _filesToWarmup) {
//     await cachedActor(AssetFlare(bundle: rootBundle, name: filename));
//     await Future<void>.delayed(const Duration(milliseconds: 16));
//   }
// }