import 'package:flutter/cupertino.dart';
import 'dart:math';

class ProcessesOrganizerProvider with ChangeNotifier {
  // The application has a request limit set as 2 requests per second
  //    so the app can't send 3 requests or more at the same moment.
  // The main purpose of this provider is to organize sending requests by doing a queue that
  //    allows requests with a bigger importance to run first, then it allows other requests with less
  //    importance etc ...

  //  processId = 1 >>> target specific change || target any change (processes with smallest numbers are less important)
  //  processId = 2 >>> get ranking
  //  processId = 3 >>> get cluster
  //  processId = 4 >>> get the user info (processes with biggest numbers are most important)
  List<int> processesQueue = [];
  int currentRunningProcess = 0;

  canIRunThisProcess(int processId) async {
    print('<debug>:CanIRunThisProcess($processId)');
    if (processesQueue.isEmpty) return true;
    if (processesQueue.contains(processId) == true) return false;

    if (processesQueue.contains(processId) == false) {
      while (true) {
        if ((currentRunningProcess == 0 && processesQueue.isNotEmpty && processesQueue.reduce(min) == processId)
              || processesQueue.isEmpty) { // if no process is currently running and no process is in the queue
          return true;
        }
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    notifyListeners();
  }

  runThisProcess(int processId) {
    currentRunningProcess = processId;
    processesQueue.add(processId);
    notifyListeners();
  }

  finishThisProcess(int processId) {
    currentRunningProcess = 0;
    processesQueue.remove(processId);
    notifyListeners();
  }
}