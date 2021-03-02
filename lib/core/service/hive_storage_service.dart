import 'package:fun_alarm/core/store/schedule_store.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'local_storage_service.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocalStorageService extends LocalStorageService {
  Box box;

  final String boxName = 'primaryBox';

  PublishSubject<LocalStorageUpdate> localStorageUpdate$;

  HiveLocalStorageService(this.localStorageUpdate$);

  @override
  Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    box = await Hive.openBox(boxName);
  }

  @override
  Future<List<String>> getList(String key) async {
    return await box.get(key);
  }

  @override
  Future<String> getValue(String key) async {
    var value = box.get(key);
    return value;
  }

  @override
  Future<void> removeValue(String key) async {
    return await box.delete(key);
  }

  @override
  Future<void> resetAll() async {
    return await box.clear();
  }

  @override
  Future<void> saveList(String key, {List<String> values}) async {
    return await box.put(key, values);
  }

  @override
  Future<void> saveValue(String key, {String value}) async {
    return await box.put(key, value);
  }

  @override
  Future<void> dispose() async {
    localStorageUpdate$.close();
  }

  @override
  Future<void> notifyUpdateForKey(LocalStorageUpdate key) async {
    localStorageUpdate$.add(key);
  }
}
