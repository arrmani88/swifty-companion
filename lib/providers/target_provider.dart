import 'package:flutter/cupertino.dart';
import '../globals/globals.dart';

class TargetProvider with ChangeNotifier {
  // SEE THE DOCUMENTATIONS BELOW
  Map<String, List<Map<String, dynamic>>> targetedItemsData = {
    'targeted_hosts': [],
    'targeted_users': []
  };
  bool areAllWorkstationsTargeted = false;

  detargetAllWorkstations() {
    areAllWorkstationsTargeted = false;
    notifyListeners();
  }

  targetAllWorkstations() {
    areAllWorkstationsTargeted = true;
    notifyListeners();
  }

  addThisTargetToList(String key, int userId, String login, String? location) {
    targetedItemsData[key]!.add({
      'user_id': userId,
      'login': login,
      'host': location ?? 'null'
    });
    targetedItemsBox.put(key, targetedItemsData[key]!);
    notifyListeners();
  }

  removeThisTargetFromList(String key, int userId) {
    targetedItemsData[key]!.removeWhere((element) => element['user_id'] == userId);
    targetedItemsBox.put(key, targetedItemsData[key]!);
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