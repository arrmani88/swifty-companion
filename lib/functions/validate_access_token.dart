import 'package:swifty_companion/globals/globals.dart';
import 'do_refresh_tokens.dart';

validateAccessToken() async {
  try {
    refreshToken = await storage.read(key: 'refreshToken');
    if (accessTokenCreatedAt! + 7200 - 20 > (DateTime.now().millisecondsSinceEpoch / 1000).round()) { //if token still valid ---> (-20 seconds of interval to be sure that the token didn't expired during the flow)
      accessToken = await storage.read(key: 'accessToken');
    } else { // if the locally saved token expired
      await doRefreshTokens();
    }
  } catch (e) {
    rethrow ;
  }
}
