import 'package:notifier_42/globals/globals.dart';
import 'package:dio/dio.dart';

saveTokenToLocalStorage(Response rsp) async {
  accessToken = (rsp.data as Map<String, dynamic>)['access_token'];
  try {
    await storage.write(key: 'accessToken', value: accessToken);
  } catch (e) {
    rethrow ;
  }
}
