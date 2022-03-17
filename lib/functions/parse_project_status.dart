import 'package:notifier_42/globals/globals.dart';

String parseProjectStatus(var status) {
  switch (status) {
    case(Status.subscribed): return 'Status: Subscribed';
    case(Status.validated): return 'Status: Validated';
    case(Status.failed): return 'Status: Failed';
    case(Status.waitingForCorrection): return 'Status: Waiting for correctioooooooooooon';
  }
  return '';
}