import 'package:notifier_42/constants/constants.dart';
import 'package:notifier_42/globals/globals.dart';
import 'do_refresh_tokens.dart';
import 'package:dio/dio.dart';

validateAccessToken() async {
  try {
    refreshToken = await storage.read(key: 'refreshToken');
    if (accessTokenCreatedAt! + 7200 - 20 > (DateTime.now().millisecondsSinceEpoch / 1000).round()) { //if token still valid ---> (-20 seconds of interval to be sure that the token didn't expired during the flow)
      accessToken = await storage.read(key: 'accessToken');
      await dio.get( // to know if the read access token is valid
        kHostname + '/oauth/token/info',
        options: Options(headers: {'Authorization': 'Bearer ' + accessToken!}),
      );
    } else { // if the locally saved token expired
      await doRefreshTokens();
    }
  } catch (e) {
    rethrow ;
  }
}
