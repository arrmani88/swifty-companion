import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notifier_42/widgets/workstation.dart';
import 'package:notifier_42/globals/globals.dart';
import 'package:notifier_42/functions/validate_access_token.dart';
import '../constants/constants.dart';

class ClustersProvider with ChangeNotifier {

  List clustersJsonList = [];
  Map<String, List<String>?> e1JsonList = {};
  Map<String, List<String>?> e2JsonList = {};
  List<List<Widget>> e1WidgetsList = []; // {"e2r7p9": ["anel-bou", "photo.jpg"]}
  List<List<Widget>> e2WidgetsList = [];
  bool areClustersLoading = true;
  bool isE1Selected = false;
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
    areClustersLoading = false;
    notifyListeners();
  }

  Future<void> getClusters(BuildContext context) async {
    try {
      clearAllClustersData();
      await validateAccessToken();
      await Future.wait([

        Future.delayed(const Duration(milliseconds: 1000))
            .then((value) => dio.get(
            getPath(pageNum: 1),
            options: Options(headers: {'Authorization': 'Bearer ' + accessToken!}))
            .then((value) => addClusterPartToClustersList((value.data)))),

        Future.delayed(const Duration(milliseconds: 1000))
            .then((value) => dio.get(
            getPath(pageNum: 2),
            options: Options(headers: {'Authorization': 'Bearer ' + accessToken!}))
            .then((value) => addClusterPartToClustersList((value.data)))),

        Future.delayed(const Duration(milliseconds: 3000))
            .then((value) => dio.get(
            getPath(pageNum: 3),
            options: Options(headers: {'Authorization': 'Bearer ' + accessToken!}))
            .then((value) => addClusterPartToClustersList((value.data)))),

      ]);
      gotClusters();
    } catch (e) {
      rethrow ;
    }
  }

  clearAllClustersData() {
    areClustersLoading = true;
    clustersJsonList = [];
    e1JsonList = {};
    e2JsonList = {};
    e1WidgetsList = [];
    e2WidgetsList = [];
    notifyListeners();
  }
}

String getPath({required int pageNum})  {
  return kHostname +
    '/v2/campus/16/locations'
    '?page[size]=100'
    '&page[number]=$pageNum'
    '&range[host]=e1,e3'
    '&sort=host'
    '&filter[end]=false';
}
