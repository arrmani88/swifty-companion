import 'package:swifty_companion/globals/globals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

saveTokenToLocalStorage(Response rsp) async {
  const storage = FlutterSecureStorage();

  accessToken = (rsp.data as Map<String, dynamic>)['access_token'];
  await storage.write(key: 'accessToken', value: accessToken);
}
