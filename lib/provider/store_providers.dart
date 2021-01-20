import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/core/service/local_storage_service.dart';
import 'package:fun_alarm/core/store/schedule_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

List<SingleChildWidget> storeProviders = [
  // provide stream of observable returned by suitable store
  Provider<ScheduleStore>(
      create: (context) => ScheduleStore(
          Provider.of<LocalStorageService>(context, listen: false),
          Provider.of<Subject<LocalStorageUpdate>>(context, listen: false),
          Provider.of<BehaviorSubject<AllScheduleO>>(context, listen: false)),
      lazy: false,
      dispose: (context, store) => store.dispose()),
  StreamProvider<AllScheduleO>(
    lazy: false,
    create: (context) {
      ScheduleStore store =  Provider.of<ScheduleStore>(context, listen: false);
      return store.o$;
    }
  )
];