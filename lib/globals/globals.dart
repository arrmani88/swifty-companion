import 'package:dio/dio.dart';
import 'package:swifty_companion/classes/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

// User user = User();
// late String selectedCursus;
late String accessToken;
Dio dio = Dio();
const storage = FlutterSecureStorage();
// late Widget profilePictureWidget;
enum Status{waitingForCorrection, subscribed, validated, failed}
late Response response;

/*

import 'package:provider/provider.dart';
import 'package:swifty_companion/providers/user_provider.dart';

context.watch<UserProvider>().

 */