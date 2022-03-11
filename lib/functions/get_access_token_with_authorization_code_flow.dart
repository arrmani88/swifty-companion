import 'package:swifty_companion/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:url_launcher/url_launcher.dart';

Future getAccessTokenWithAuthorizationCodeFlow() async {
  try {
    Response _rsp = await dio.get(
      kAuthorizationCodeFlowAuthorizationLink +
      '?response_type=code'
      '&client_id=30480b7ab0ff85a13ebca0ac0bd338f56dfaf0904ef8bc4866c3866930212be3'
      '&redirect_uri=https%3A%2F%www.google.com'
    );
    print('----------- GETTING ACCSS TKN ----------');
  } catch (e) {
    rethrow ;
  }
}