import 'package:dio/dio.dart';

parseTokens(Response rsp) {
  String acessToken = (rsp.data as Map<String, dynamic>)['access_token'];
}