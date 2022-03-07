import 'package:dio/dio.dart';
import 'package:swifty_companion/functions/validate_access_token.dart';
import '../constants/constants.dart';
import '../globals/globals.dart';

getCluster() async {
  await validateAccessToken();
  Future<Response> _response1 = dio.get(
    kHostname + '/v2/campus/16/locations?page[size]=100&page[number]=1&filter[host]',
    options: Options(headers: {'Authorization': 'Bearer ' + accessToken}),
  );
  Future<Response> _response2 = dio.get(
    kHostname + '/v2/campus/16/locations?page[size]=100&page[number]=2&filter[host]',
    options: Options(headers: {'Authorization': 'Bearer ' + accessToken}),
  );
  Future<Response> _response3 = dio.get(
    kHostname + '/v2/campus/16/locations?page[size]=100&page[number]=3&filter[host]',
    options: Options(headers: {'Authorization': 'Bearer ' + accessToken}),
  );
}