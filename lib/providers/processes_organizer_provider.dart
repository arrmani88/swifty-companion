import 'package:flutter/cupertino.dart';

class ProcessesOrganizerProvider with ChangeNotifier {
  // The application has a request limit set as 2 requests per second
  //    so the app can't send 3 requests or more at the same moment
  // The main purpose of this provider is to organize sending requests by doing a queue that
  //
  int currentRunningProcess = 0;
  bool? canRunGetUserProcess;
  bool? canRunGetClusterProcess;
  bool? canRunGetRankingProcess;
  bool? canRunTargettingProcess;

  currentRunningProcessIs(int processId) {
    currentRunningProcess = processId;
    notifyListeners();
  }
//********************************************************************/
  runGetUserProcess() {
    canRunGetUserProcess = true;
    notifyListeners();
  }  
  runGetClusterProcess() {
    canRunGetClusterProcess = true;
    notifyListeners();
  }  
  runGetRankingProcess() {
    canRunGetRankingProcess = true;
    notifyListeners();
  }  
  runTargettingProcess() {
    canRunTargettingProcess = true;
    notifyListeners();
  }
//********************************************************************/
  pauseGetUserProcess() {
    canRunGetUserProcess = false;
    notifyListeners();
  }
  pauseGetClusterProcess() {
    canRunGetClusterProcess = false;
    notifyListeners();
  }
  pauseGetRankingProcess() {
    canRunGetRankingProcess = false;
    notifyListeners();
  }
  pauseTargettingProcess() {
    canRunTargettingProcess = false;
    notifyListeners();
  }
  
}