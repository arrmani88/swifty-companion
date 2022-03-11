import 'package:dio/dio.dart';
import 'package:swifty_companion/functions/get_access_token_with_client_credentials_flow.dart';
import 'package:swifty_companion/globals/globals.dart';

validateAccessToken() async {
  try {
    await dio.get(
      'https://api.intra.42.fr/oauth/token/info',
      options: Options(headers: {'Authorization': 'Bearer ' + accessToken})
    );
  } catch (e) {
    if (e is DioError && e.response?.statusCode == 401) {
      await getAccessTokenWithClientCredentialsFlow();
      return ;
    }
    print('<<<<<<<- ERROR POINT #2 ->>>>>>>');
    rethrow;
  }
  print('ACCESS TOKEN => <$accessToken>');
}
