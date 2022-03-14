import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

late String accessToken;
Dio dio = Dio();
const storage = FlutterSecureStorage();
late Response response;
late PageController pageController;
enum Status{waitingForCorrection, subscribed, validated, failed}
enum PushWorkStationTo{bottom, top}
enum ProfileSearchStatus{notFound, success, noInternet}
