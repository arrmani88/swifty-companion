import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../globals/globals.dart';
import 'package:notifier_42/constants/constants.dart';

// {{hostname}}/v2/campus/16/locations?page[size]=100&filter[end]=false&filter[host]=e1r1p2,e1r1p1,e1r1p3
// {{hostname}}/v2/campus/16/users?page[size]=100&filter[id]=94220,39760,62432

class TargetProvider with ChangeNotifier {
  // SEE THE DOCUMENTATIONS BELOW
  late String hostsParameters;
  late String usersParameters;
  Map<String, List<Map<String, dynamic>>> targetedItemsData = {
    'targeted_hosts': [],
    'targeted_users': []
  };
  bool isAnythingTargeted = false;
  bool areAllWorkstationsTargeted = false;

  getParameters() {

    hostsParameters = '?page[size]=100&filter[end]=false&filter[host]=';
    for (Map<String, dynamic> element in targetedItemsData['targeted_hosts']!) {
      usersParameters = usersParameters + element['host'] + ',';
    }
    usersParameters = '?page[size]=100&filter[id]=';
    for (Map<String, dynamic> element in targetedItemsData['targeted_users']!) {
      hostsParameters = hostsParameters + element['userId'] + ',';
    }
  }

  analyzeUsersChanges(List<Map<String, dynamic>> rsp) {}

  analyzeHostsChanges(List<Map<String, dynamic>> rsp) {
    late String tmpHost;

    for (Map <String, dynamic> respElem in rsp) {
      tmpHost = '';
      for (Map<String, dynamic> targetedItem in targetedItemsData['targeted_hosts']!) {
        if (respElem['host'] == targetedItem['host']) {
          tmpHost = targetedItem['host'];
          break;
        }
      }
      if (tmpHost == '') {

      }
    }
  }

  listenOnSpecifiedWorkstations() async {
    late Response _hostsRsp;
    late Response _usersRsp;

    if (isAnythingTargeted == true) {
      while (true) {
        getParameters();
        await Future.wait([
          // listen on hosts ...
          Future.delayed(const Duration(milliseconds: 700))
            .then((_) => dio.get(
              kHostname + '/v2/campus/16/locations' + hostsParameters,
              options: Options(headers: {'Authorization': 'Bearer ' + accessToken!})))
            .then((value) => _hostsRsp = value),
          // listen on users ...
          Future.delayed(const Duration(milliseconds: 700))
            .then((_) => dio.get(
              kHostname + '/v2/campus/16/locations' + hostsParameters,
              options: Options(headers: {'Authorization': 'Bearer ' + accessToken!})))
            .then((value) => _usersRsp = value)
        ]);
        analyzeHostsChanges(_hostsRsp as List<Map<String, dynamic>>);
        analyzeUsersChanges(_usersRsp as List<Map<String, dynamic>>);
      }
    }
  }

  detargetAllWorkstations() {
    areAllWorkstationsTargeted = false;
    isAnythingTargeted = false;
    notifyListeners();
  }

  targetAllWorkstations() {
    areAllWorkstationsTargeted = true;
    isAnythingTargeted = true;
    notifyListeners();
  }

  somethingIsTargeted() {
    isAnythingTargeted = true;
    notifyListeners();
  }

  nothingIsTargeted() {
    isAnythingTargeted = false;
    notifyListeners();
  }

  addThisTargetToList(String key, int userId, String login, String? location) {
    targetedItemsData[key]!.add({
      'user_id': userId,
      'login': login,
      'host': location ?? 'null'
    });
    somethingIsTargeted();
    targetedItemsBox.put(key, targetedItemsData[key]!); // overwrite the old list by the new list
    isAnythingTargeted = true;
    notifyListeners();
  }

  removeThisTargetFromList(String key, int userId) {
    targetedItemsData[key]!.removeWhere((element) => element['user_id'] == userId);
    targetedItemsBox.put(key, targetedItemsData[key]!); // overwrite the old list by the new list
    if (targetedItemsData[key]!.isEmpty) isAnythingTargeted = false;
    notifyListeners();
  }
}


// EXPLANATION OF THE STRUCTURE OF THE VARIABLES

//  targetedItemsData =
//  {
//    'targeted_hosts': [ // list if the targeted item is a workstation
//      {
//        'user_id': '123456',
//        'login': 'anel-bou',
//        'host': 'e2r9p7', // or 'null' if the user isn't logged in (means if the targeted item is
//                              a user, so in 'targeted_hosts', the field 'host' shouldn't be null
//      },
//      {
//        (...)
//      }
//    ],
//    'targeted_users': [
//      same as targeted_hosts except that 'host' field should be null because the targeted user isn't logged in
//    ]
//  }

