import 'package:swifty_companion/globals/globals.dart';

getStatusStringFromEnum(String str, bool isValidated){
  if (str == 'finished' && isValidated == true) return Status.validated;
  else if (str == 'finished' && isValidated == true) return Status.failed;
  else if (str == 'waiting_for_correction') return Status.waitingForCorrection;
  return Status.subscribed;
}
