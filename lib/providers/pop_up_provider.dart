import 'package:flutter/material.dart';

class PopUpProvider with ChangeNotifier {
  bool isUserNotFoundPopUpDisplayed = false;

  hideAllPopUps() {
    print('---------- HIDING ALL POP UPS ------------');
    isUserNotFoundPopUpDisplayed = false;
  }

  displayUserNotFoundPopUp() {
    print('---------- DISPLAYING USER NOT FOUND POP UP ------------');
    isUserNotFoundPopUpDisplayed = true;
    notifyListeners();
  }

  hideUserNotFoundPopUp() {
    print('---------- HIDING USER NOT FOUND POP UP ------------');
    isUserNotFoundPopUpDisplayed = false;
    notifyListeners();
  }

}