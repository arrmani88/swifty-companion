import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notifier_42/widgets/workstation.dart';
import 'package:notifier_42/globals/globals.dart';
import 'package:notifier_42/functions/validate_access_token.dart';
import '../constants/constants.dart';
import 'package:notifier_42/providers/processes_organizer_provider.dart';
import 'package:provider/provider.dart';

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
  final int processId = 3;

  bool addClusterPartToClustersList(List clusterPart) {
    if (clusterPart.isEmpty) return false;
    clustersJsonList.addAll(clusterPart);
    return true;
  }

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
        // some blank space between every 5 workstations
        if (p == 6 || p == 11) {
          stageWidgetsList[0].insert(0, const SizedBox(width: 35,));
        }
        // if the workstation doesn't exist in the cluster
        if (((r == 1 || (r >= 11 && r <= 13)) && p >= 6) || (r == 10 && p >= 6 && p<= 10)) {
          stageWidgetsList[0].insert(0, WorkStation(pushWorkStationTo: pushWorkStationTo, isDoorFacing: isDoorFacing,));
        }
        // else if the workstation exists in the cluster
        else {
          // if the workstation is vacant
          if (stageJsonList['e${stageNumber}r${r}p$p'] == null) {
            stageWidgetsList[0].insert(0, WorkStation(host: 'e${stageNumber}r${r}p$p', pushWorkStationTo: pushWorkStationTo, isDoorFacing: isDoorFacing));
          }
          // if the workstation is occupied
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
      if (host != null) {
        if (host.startsWith('e1')) {
          e1JsonList[host] = [login, image];
        } else if (host.startsWith('e2')) {
          e2JsonList[host] = [login, image];
        }
      }
    }
  }

  getMap(BuildContext context) async {
    try {
      await getClusters(context);
      parseClusters(clustersJsonList);
      getClusterWidgetsList(stageNumber: 1, stageWidgetsList: e1WidgetsList, stageJsonList: e1JsonList);
      getClusterWidgetsList(stageNumber: 2, stageWidgetsList: e2WidgetsList, stageJsonList: e2JsonList);
      areClustersLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow ;
    }
  }

  Future<void> getClusters(BuildContext context) async {
    Options options = Options(headers: {'Authorization': 'Bearer ' + accessToken!});
    int gotAllPages = -1;
    try {
      clearAllClustersData();
      await validateAccessToken();

      if (await context.read<ProcessesOrganizerProvider>().canIRunThisProcess(processId) == true) {
        context.read<ProcessesOrganizerProvider>().runThisProcess(processId);
        // print('<debug>:runProcess(CLUSTER)');
        // while gotAllPages != 1, send (repeated) times the request and wait for the (repeated) responses
        // and then check if one of them is empty to finish the operation
        for (int pageNumber = 1; gotAllPages != 1; pageNumber += 3) {
          await Future.wait([
            // send (repeated) times the request and then check if one of the (repeated) requests is empty to finish the operation
            for (int repeated = 0, interval = 1000; repeated < 3; repeated++, interval += 700)
              Future.delayed(Duration(milliseconds: interval))
                .then((value) => dio.get(_getPath(pageNum: pageNumber + repeated), options: options)
                .then((value) {
                // if the app got all parts, the operation finishes here
                if (addClusterPartToClustersList(value.data) == false) gotAllPages = 1;
              })),
          ]);
        }
        context.read<ProcessesOrganizerProvider>().finishThisProcess(processId);
        // print('<debug>:finishProcess(CLUSTER)');
      }
    } catch (e) {
      if (e is DioError && (e.response!.statusCode == 403 || e.response!.statusCode == 401)) {
        await validateAccessToken();
        await getClusters(context);
      } else if (e is DioError && e.response!.statusCode == 429) {
        await getClusters(context);
      } else {
        rethrow;
      }
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

  String _getPath({required int pageNum}) {
    return kHostname +
      '/v2/campus/16/locations'
      '?page[size]=100'
      '&page[number]=$pageNum'
      '&range[host]=e1,e3'
      '&sort=host'
      '&filter[end]=false';
  }
}

