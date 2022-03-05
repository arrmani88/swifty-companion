import 'package:dio/dio.dart';
import 'package:swifty_companion/classes/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';


late String accessToken;
Dio dio = Dio();
const storage = FlutterSecureStorage();
enum Status{waitingForCorrection, subscribed, validated, failed}
late Response response;
