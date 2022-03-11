import 'package:flutter/material.dart';
import 'package:swifty_companion/widgets/workstation.dart';
import 'package:swifty_companion/globals/globals.dart';

class ClustersProvider with ChangeNotifier {

  List clustersJsonList = [];
  Map<String, List<String>?> e1JsonList = {};
  Map<String, List<String>?> e2JsonList = {};
  List<List<Widget>> e1WidgetsList = []; // {"e2r7p9": ["anel-bou", "photo.jpg"]}
  List<List<Widget>> e2WidgetsList = [];
  bool isClustersLoading = true;
  bool isE1Selected = true;
  bool isClusterRotated = false;

  List<List> e1Debug = [];
  List<List> e2Debug = [];

  addClusterPartToClustersList(List clusterPart) => clustersJsonList.addAll(clusterPart);

  switchCluster() {
    isE1Selected = !isE1Selected;
    notifyListeners();
  }

  rotateCluster() {
    isClusterRotated = !isClusterRotated;
    notifyListeners();
  }

  clearAllClustersData() {
    clustersJsonList = [];
    e1JsonList = {};
    e2JsonList = {};
    e1WidgetsList = [];
    e2WidgetsList = [];
    isClustersLoading = true;
  }

  getClusterWidgetsList({required stageNumber, required stageWidgetsList, required stageJsonList}) {
    late var pushWorkStationTo;
    late bool isDoorFacing;
    int r = 1;
    int p;

    while (r <= 13) {
      p = 1;
      stageWidgetsList.insert(0, <Widget>[]);
      while (p <= 15) {
        pushWorkStationTo = (p >= 6 && p <= 10 ? PushWorkStationTo.top : PushWorkStationTo.bottom);
        isDoorFacing = (p == 2 || p == 4 || p == 7 || p == 9 || p == 12 || p == 14);
        if (p == 6 || p == 11) {
          stageWidgetsList[0].insert(0, const SizedBox(width: 35,));
        }
        // non existing workstation in the grid
        if (((r == 1 || (r >= 11 && r <= 13)) && p >= 6) || (r == 10 && p >= 6 && p<= 10)) {
          stageWidgetsList[0].insert(0, WorkStation(pushWorkStationTo: pushWorkStationTo, isDoorFacing: isDoorFacing,));
        }
        // else if the workstation exists in the cluster
        else {
          if (stageJsonList['e${stageNumber}r${r}p$p'] == null) {
            stageWidgetsList[0].insert(0, WorkStation(host: 'e${stageNumber}r${r}p$p', pushWorkStationTo: pushWorkStationTo, isDoorFacing: isDoorFacing));
          }
          else {
            stageWidgetsList[0].insert(0, WorkStation(host: 'e${stageNumber}r${r}p$p', userData: stageJsonList['e${stageNumber}r${r}p$p'], pushWorkStationTo: pushWorkStationTo, isDoorFacing: isDoorFacing));
          }
        }
        p++;
      }
      r++;
    }
  }

  parseClusters(List list) {
    late String? host;
    late String login;
    late String image;

    for (Map<String, dynamic> workStation in list) {
      host = (workStation['user'] as Map)['location'];
      login = (workStation['user'] as Map)['login'];
      image = (workStation['user'] as Map)['image_url'];
      // print('host:"${host}"\t["${login}", "${image}"]');
      if (host != null) {
        if (host.startsWith('e1')) {
          e1JsonList[host] = [login, image];
        } else if (host.startsWith('e2')) {
          e2JsonList[host] = [login, image];
        }
      }
    }
  }

  gotClusters() {
    parseClusters(clustersJsonList);
    getClusterWidgetsList(stageNumber: 1, stageWidgetsList: e1WidgetsList, stageJsonList: e1JsonList);
    getClusterWidgetsList(stageNumber: 2, stageWidgetsList: e2WidgetsList, stageJsonList: e2JsonList);
    isClustersLoading = false;
    notifyListeners();
  }


  getClusterDebugList({required stageNumber, required stageWidgetsList, required stageJsonList}) {
    int r = 1;
    int p;
    while (r <= 13) {
      p = 1;
      while (p <= 15) {
        if (p == 1) { // create an empty range at the beginning
          stageWidgetsList.insert(0, []);
        }
        if (((r == 1 || (r >= 11 && r <= 13)) && p >= 6) || (r == 10 && p >= 6 && p<= 10)) { // non existing workstation in the grid
          stageWidgetsList[0].insert(0, '__NULL__');
        }
        else { // else if the workstation exists in the cluster
          if (stageJsonList['e${stageNumber}r${r}p$p'] == null) { // if the workstation is vacant
            stageWidgetsList[0].insert(0, '-vacant-');
          }
          else {
            stageWidgetsList[0].insert(0, stageJsonList['e${stageNumber}r${r}p$p']![0]);
          }
        }
        p++;
      }
      r++;
    }
    // getClusterDebugList(stageNumber: 1, stageWidgetsList: e1Debug, stageJsonList: e1JsonList);
    // getClusterDebugList(stageNumber: 2, stageWidgetsList: e2Debug, stageJsonList: e2JsonList);
  }
}