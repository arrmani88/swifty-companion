import 'package:dio/dio.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:swifty_companion/constants/constants.dart';

import '../globals/globals.dart';

Future getAccessTokenWithAuthorizationCodeFlow() async {

  String url = 'https://api.intra.42.fr/oauth/authorize'
      '?client_id=30480b7ab0ff85a13ebca0ac0bd338f56dfaf0904ef8bc4866c3866930212be3'
      '&redirect_uri=com.example.swiftycompanion%3A%2F%2Fredirect'
      '&response_type=code';
  try {
    final String result = await FlutterWebAuth.authenticate(
      url: url,
      callbackUrlScheme: 'com.example.swiftycompanion'
    );
    final String code = Uri.parse(result).queryParameters['code']!;
    Response _rsp = await dio.post(
      kHostname + '/oauth/token',
      data: {
        'grant_type': 'authorization_code',
        'client_id': '30480b7ab0ff85a13ebca0ac0bd338f56dfaf0904ef8bc4866c3866930212be3',
        'client_secret': 'f60c5403a51a62eade9f61d99eca07a7cbac9adec3ce329756aae7a487e9cb8e',
        'code': code,
        "redirect_uri": 'com.example.swiftycompanion://redirect'
      }
    );
    print('code===>$code<');
    accessToken = (_rsp.data as Map<String, dynamic>)['access_token'];
    refreshToken = (_rsp.data as Map<String, dynamic>)['refresh_token'];
    accessTokenCreatedAt = (_rsp.data as Map<String, dynamic>)['created_at'];
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
    await storage.write(key: 'accessTokenCreatedAt', value: accessTokenCreatedAt.toString());
  } catch (e) {
    rethrow ;
  }
}

/*
{
  access_token: be488f1186154b19a72e545bae138b3d800c256797915fa08e918952c01f13e7,
  token_type: bearer,
  expires_in: 5603,
  refresh_token: 2f0b018e76ee0d635d402b009a8636987843c65291408b031451bd3ec5a79851,
  scope: public,
  created_at: 1647293160
}

{
  access_token: 3acda0f3d7bb0e219290bbc68f1f82280b119ef223f61005769f5e9052e3c0e9,
  token_type: bearer,
  expires_in: 7200,
  refresh_token: bc8773beb79ff7cd92e744b7beabecb08061ae22d202ad50676606b04da58079,
  scope: public,
  created_at: 1647309051
}

*/