import 'package:fun_alarm/core/store/schedule_store.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'local_storage_service.dart';
import 'package:path_provider/path_provider.dart';

import 'local_storage_service.dart';

class HiveLocalStorageService extends LocalStorageService {
  Box box;

  final String boxName = 'localBox';

  PublishSubject<LocalStorageUpdate> localStorageUpdate$;

  HiveLocalStorageService(this.localStorageUpdate$);

  @override
  Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    box = await Hive.openBox(boxName);
  }

  @override
  Future<List<String>> getListForKey(String key) async {
    return box.get(key);
  }

  @override
  Future<String> getValueForKey(String key) async {
    var value = box.get(key);
    if (value is String) {
      return value;
    } else {
      throw "Value is of wrong type";
    }
  }

  @override
  Future<void> removeValueForKey(String key) async {
    return await box.delete(key);
  }

  @override
  Future<void> resetAll() async {
    return await box.clear();
  }

  @override
  Future<void> saveListForKey(String key, {List<String> values}) async {
    return await box.put(key, values);
  }

  @override
  Future<void> saveValueForKey(String key, {String value}) async {
    return await box.put(key, value);
  }

  @override
  Future<void> dispose() async {
    localStorageUpdate$.close();
  }

  @override
  Future<void> notifyUpdateForKey(LocalStorageUpdate key) async {
    localStorageUpdate$.add(key);
    @override
    Future<void> removeValueForKey(String key) async {
      return await box.delete(key);
    }

    @override
    Future<void> resetAll() async {
      return await box.clear();
    }

    @override
    Future<void> saveListForKey(String key, {List<String> values}) async {
      return await box.put(key, values);
    }

    @override
    Future<void> saveValueForKey(String key, {String value}) async {
      return await box.put(key, value);
    }
  }
}
