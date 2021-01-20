import 'package:fun_alarm/core/store/schedule_store.dart';

abstract class LocalStorageService {
  Future<void> init();

  Future<String> getValueForKey(String key);

  Future<void> saveValueForKey(String key, {String value});

  Future<List<String>> getListForKey(String key);

  Future<void> notifyUpdateForKey(LocalStorageUpdate key);

  Future<void> saveListForKey(String key, {List<String> values});

  Future<void> removeValueForKey(String key);

  Future<void> resetAll();

  dispose() {}
}