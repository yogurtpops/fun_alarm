import 'package:fun_alarm/core/action/schedule_action.dart';
import 'package:fun_alarm/core/service/notification_service.dart';
import 'package:fun_alarm/core/store/schedule_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> actionProviders = [
  Provider<ScheduleAction>(
    lazy: false,
    create: (context) => ScheduleAction(
        Provider.of<ScheduleStore>(context, listen: false),
        Provider.of<NotificationService>(context, listen: false)),
  ),
];