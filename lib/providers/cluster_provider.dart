import 'package:flutter/material.dart';

class ClustersProvider with ChangeNotifier {

  List clustersList = [];
  Map<String, List<String>?> e1 = {};
  Map<String, List<String>?> e2 = {};
  List<List> e1WidgetsList = [[]];
  List<List> e2WidgetsList = [[]];
  bool isClustersLoading = true;

  addClusterPartToClustersList(List clusterPart) => clustersList.addAll(clusterPart);

  getClusterWidgetsList() {
    int r = 1;
    int p;
    while (r <= 13) {
      p = 1;
      while (p <= 15) {
        if (e1['e1r${r}p$p'] == null) {
          e1WidgetsList[r-1].insert(0, '-vacant-');
        }
        else {
          e1WidgetsList[r-1].insert(0, e1['e1r${r}p$p']![0]);
        }
        p++;
      }
      r++;
    }
  }

  parseClusters(List list) {
    int iterations = 0;
    late String location;
    late String login;
    late String image;

    for (Map<String, dynamic> workStation in list) {
      location = (workStation['user'] as Map)['location'];
      login = (workStation['user'] as Map)['login'];
      image = (workStation['user'] as Map)['image'];
      if (location.startsWith('e1')) {
        e1[location] = [login, image];
      } else if (location.startsWith('e2')) {
        e2[location] = [login, image];
      }
    }
    getClusterWidgetsList();
  }

  gotClusters() {
    print('------- GOT ALL CLUSTERS SUCCESSFULLY ---------');
    parseClusters(clustersList);
    isClustersLoading = false;
    notifyListeners();
  }

}