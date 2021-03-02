import 'package:fun_alarm/core/store/schedule_store.dart';

abstract class LocalStorageService {
  Future<void> init();

  Future<String> getValue(String key);

  Future<void> saveValue(String key, {String value});

  Future<List<String>> getList(String key);

  Future<void> notifyUpdateForKey(LocalStorageUpdate key);

  Future<void> saveList(String key, {List<String> values});

  Future<void> removeValue(String key);

  Future<void> resetAll();

  dispose() {}
}