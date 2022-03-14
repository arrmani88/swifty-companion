import 'package:flutter/material.dart';

class PopUpProvider with ChangeNotifier {
  bool isUserNotFoundPopUpDisplayed = false;
  bool isNoInternetPopUpDisplayed = false;
  bool isUnknownErrorPopUpDisplayed = false;
  bool isProfileLoadingPopUpDisplayed = false;

  hideAllPopUps() {
    isUserNotFoundPopUpDisplayed = false;
    isNoInternetPopUpDisplayed = false;
    isUnknownErrorPopUpDisplayed = false;
    isProfileLoadingPopUpDisplayed = false;
    notifyListeners();
  }

  displayProfileLoadingPopUp() {
    isProfileLoadingPopUpDisplayed = true;
    notifyListeners();
  }

  displayUnknownErrorPopUp () {
    isUnknownErrorPopUpDisplayed = true;
    notifyListeners();
  }

  displayNoInternetPopUp() {
    isNoInternetPopUpDisplayed = true;
    notifyListeners();
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