import 'package:dio/dio.dart';
import 'package:swifty_companion/functions/get_access_token.dart';
import 'package:swifty_companion/globals/globals.dart';

validateToken() async {
  try {
    Response _response = await dio.get(
      'https://api.intra.42.fr/oauth/token/info',
      options: Options(headers: {'Authorization': 'Bearer ' + accessToken})
    );
    if (_response.statusCode == 200)
      {return ;}
    else
      {await getAccessToken();}
  } catch (e) {
    print(e);
  }
}