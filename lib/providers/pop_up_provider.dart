import 'package:flutter/material.dart';

class PopUpProvider with ChangeNotifier {
  bool isUserNotFoundPopUpDisplayed = false;

  hideAllPopUps() {
    isUserNotFoundPopUpDisplayed = false;
  }

  displayUserNotFoundPopUp() {
    isUserNotFoundPopUpDisplayed = true;
    notifyListeners();
  }

  hideUserNotFoundPopUp() {
    isUserNotFoundPopUpDisplayed = false;
    notifyListeners();
  }

}