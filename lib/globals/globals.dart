import 'package:dio/dio.dart';
import 'package:swifty_companion/classes/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

late String accessToken;
Dio dio = Dio();
User user = User();
const storage = FlutterSecureStorage();
