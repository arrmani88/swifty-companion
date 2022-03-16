import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

enum Status{waitingForCorrection, subscribed, validated, failed}
enum PushWorkStationTo{bottom, top}
enum ConnectionStatus{notFound, success, noInternet}
String? accessToken;
String? refreshToken;
int? accessTokenCreatedAt;
Dio dio = Dio();
const String targetedItemsBoxName = 'targetedItems';
const storage = FlutterSecureStorage();
late Response response;
late PageController pageController;
Map<String, List<Map<String, dynamic>>> targetedItemsData = {
  'targeted_hosts': [],
  'targeted_users': []
};
var targetedItemsBox = Hive.box(targetedItemsBoxName);






/*
targetedList = {
  'targeted_hosts': [
    {
      "user_id": 125548,
      "login": 'aait-ihi',
      'host': 'e2r7p8'
    },
  ],
  'targeted_users': [
    {
      "user_id": 138775,
      "login": 'anel-bou',
      'host': 'e2r7p6'
    }
  ]
}
*/