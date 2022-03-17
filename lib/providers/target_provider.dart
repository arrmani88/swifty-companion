import 'package:flutter/cupertino.dart';
import '../globals/globals.dart';

class TargetProvider with ChangeNotifier {
  bool areAllWorkstationsTargeted = false;
  Map<String, List<Map<String, dynamic>>> targetedItemsData = {
    'targeted_hosts': [],
    'targeted_users': []
  };

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