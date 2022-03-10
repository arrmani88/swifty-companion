import 'package:flutter/material.dart';

class ClustersProvider with ChangeNotifier {

  List clustersList = [];
  Map<String, String> e1 = {};
  Map<String, String> e2 = {};
  bool isClustersLoading = true;
  bool fillE1 = true;

  addClusterPartToClustersList(List clusterPart) {
    clustersList.addAll(clusterPart);
    print('-------- ADDED A PART TO CLUSTERS LIST ----------');
  }

  parseClusters(List list) {
    int iterations = 0;
    for (Map<String, dynamic> workStation in list) {
      ++iterations;
      print('location:'+(workStation['user'] as Map<String, dynamic>)['location'].toString() + '\t->' + (workStation['user'] as Map<String, dynamic>)['login']);
    }
    print('iterations = $iterations');

    /*********** arak lme39ol lte7t ************/
    late String location;
    late String login;
    for (Map<String, dynamic> workStation in list) {
      location = (workStation['user'] as Map<String, String>)['location'] as String;
      login = (workStation['user'] as Map<String, dynamic>)['login'];
      if (location.startsWith('e1')) e1[location] = login;
      else if (location.startsWith('e2')) e2[location] = login;
    }
  }

  gotClusters() {
    print('------- GOT ALL CLUSTERS SUCCESSFULLY ---------');
    isClustersLoading = false;
    parseClusters(clustersList);
    notifyListeners();
  }

}