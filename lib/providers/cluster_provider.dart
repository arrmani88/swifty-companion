import 'package:flutter/material.dart';

class ClustersProvider with ChangeNotifier {

  List clustersList = [];
  Map<String, List<String>?> e1 = {};
  Map<String, List<String>?> e2 = {};
  List<List> e1WidgetsList = []; // {"e2r7p9": ["anel-bou", "photo.jpg"]}
  List<List> e2WidgetsList = [];
  bool isClustersLoading = true;

  addClusterPartToClustersList(List clusterPart) => clustersList.addAll(clusterPart);

  getClusterWidgetsList() {
    int r = 1;
    int p;
    while (r <= 13) {
      p = 1;
      while (p <= 15) {
        if (p == 1) { // create an empty range at the beginning
          e1WidgetsList.insert(0, []);
        }
        if (((r == 1 || (r >= 11 && r <= 13)) && p >= 6) || (r == 10 && p >= 6 && p<= 10)) { // non existing workstation in the grid
          e1WidgetsList[0].insert(0, '__NULL__');
        }
        else { // else if the workstation exists in the cluster
          if (e1['e1r${r}p$p'] == null) { // if the workstation is vacant
            e1WidgetsList[0].insert(0, '-vacant-');
          }
          else {
            e1WidgetsList[0].insert(0, e1['e1r${r}p$p']![0]);
          }
        }
        p++;
      }
      r++;
    }

    for (List elem in e1WidgetsList) {
      print(elem);
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