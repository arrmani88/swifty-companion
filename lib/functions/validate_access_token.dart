import 'package:flutter/cupertino.dart';
import 'package:notifier_42/globals/globals.dart';
import 'do_refresh_tokens.dart';

validateAccessToken(BuildContext? context) async {
  try {
    refreshToken = await storage.read(key: 'refreshToken');
    refreshToken = '202f94cc52f406c8e60d6989f6c1c3348e38865b3413a26bfa9af1647397574b';
    print('<<<<<<<<>>>>>>>>><<<<<<>>>>>');
    // if (accessTokenCreatedAt! + 7200 - 20 > (DateTime.now().millisecondsSinceEpoch / 1000).round()) { //if token still valid ---> (-20 seconds of interval to be sure that the token didn't expired during the flow)
    //   accessToken = await storage.read(key: 'accessToken');
    // } else { // if the locally saved token expired
      await doRefreshTokens(context);
    // }
  } catch (e) {
    rethrow ;
  }
}
