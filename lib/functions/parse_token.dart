import 'package:dio/dio.dart';

parseToken(Response rsp) {
  String acessToken = (rsp.data as Map<String, dynamic>)['access_token'];
}