import 'package:dio/dio.dart';
import '../constants/constants.dart';
import '../globals/globals.dart';

Future doRefreshTokens() async {
  Response _rsp = await dio.post(
      kHostname + '/oauth/token'
      '?grant_type=refresh_token'
      '&client_id=30480b7ab0ff85a13ebca0ac0bd338f56dfaf0904ef8bc4866c3866930212be3'
      '&client_secret=f60c5403a51a62eade9f61d99eca07a7cbac9adec3ce329756aae7a487e9cb8e'
      '&refresh_token=$refreshToken',
  );
  accessToken = (_rsp.data as Map<String, dynamic>)['access_token'];
  refreshToken = (_rsp.data as Map<String, dynamic>)['refresh_token'];
  accessTokenCreatedAt = (_rsp.data as Map<String, dynamic>)['created_at'];
  await storage.write(key: 'accessToken', value: accessToken);
  await storage.write(key: 'refreshToken', value: refreshToken);
  await storage.write(key: 'accessTokenCreatedAt', value: accessTokenCreatedAt.toString());
}