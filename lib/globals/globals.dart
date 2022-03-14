import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum Status{waitingForCorrection, subscribed, validated, failed}
enum PushWorkStationTo{bottom, top}
enum ProfileSearchStatus{notFound, success, noInternet}
late String accessToken;
Dio dio = Dio();
const storage = FlutterSecureStorage();
late Response response;
late PageController pageController;
List<Map<int, Map<String, String?>>> targetedUsers = []; // [{184475: {'anel-bou', 'e2r9p7'}}]
