import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

late Future<Response> response1;
late Future<Response> response2;
late Future<Response> response3;
late String accessToken;
Dio dio = Dio();
const storage = FlutterSecureStorage();
enum Status{waitingForCorrection, subscribed, validated, failed}
late Response response;
