import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/core/store/schedule_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

List<SingleChildWidget> streamProviders = [
  Provider<BehaviorSubject<AllScheduleO>>(
    lazy: false,
    create: (context) => BehaviorSubject<AllScheduleO>(sync: true),
    dispose: (_, stream) => stream.close(),
  ),
  Provider<PublishSubject<LocalStorageUpdate>>(
    lazy: false,
    create: (context) => PublishSubject<LocalStorageUpdate>(sync: true),
    dispose: (_, stream) => stream.close(),
  ),
];