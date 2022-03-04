import 'package:dio/dio.dart';
import 'package:swifty_companion/functions/get_access_token.dart';
import 'package:swifty_companion/globals/globals.dart';

validateAccessToken() async {
  try {
    Response _response = await dio.get(
      'https://api.intra.42.fr/oauth/token/info',
      options: Options(headers: {'Authorization': 'Bearer ' + accessToken})
    );
  } catch (e) {
    if (e is DioError && e.response?.statusCode == 401) {
      await getAccessToken();
      return ;
    }
    print('<<<<<<<- ERROR POINT #2 ->>>>>>>');
    rethrow;
  }
}
