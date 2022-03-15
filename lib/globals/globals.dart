import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum Status{waitingForCorrection, subscribed, validated, failed}
enum PushWorkStationTo{bottom, top}
enum ConnectionStatus{notFound, success, noInternet}
String? accessToken;
String? refreshToken;
int? accessTokenCreatedAt;
Dio dio = Dio();
const storage = FlutterSecureStorage();
late Response response;
late PageController pageController;
Map<String, List<Map<String, dynamic>>> targetedList = {
  'targeted_hosts': [],
  'targeted_users': []
};






/*
targetedList = {
  'targeted_hosts': [
    {
      "user_id": 125548,
      "login": 'aait-ihi',
      'host': 'e2r7p8'
    },
  ],
  'tergeted_users': [
    {
      "user_id": 138775,
      "login": 'anel-bou',
      'host': 'e2r7p6'
    }
  ]
}
*/