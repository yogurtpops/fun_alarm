import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fun_alarm/core/service/hive_storage_service.dart';
import 'package:fun_alarm/core/service/local_storage_service.dart';
import 'package:fun_alarm/core/service/notification_service.dart';
import 'package:fun_alarm/core/store/schedule_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

List<SingleChildWidget> serviceProviders = [
  Provider<LocalStorageService>(
    lazy: false,
    create: (context) => HiveLocalStorageService(Provider.of<PublishSubject<LocalStorageUpdate>>(context, listen: false))
      ..init(),
    dispose: (context, service) => service.dispose(),
  ),
  Provider<NotificationService>(
    lazy: false,
    create: (context) {
      return NotificationService()..initialize();
    }
  ),
];
