import 'package:fun_alarm/provider/stream_providers.dart';
import 'package:fun_alarm/provider/service_providers.dart';
import 'package:fun_alarm/provider/store_providers.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...streamProviders,
  ...storeProviders,
  ...serviceProviders
];