import 'package:swifty_companion/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:swifty_companion/functions/save_token_to_local_storage.dart';
import 'package:swifty_companion/globals/globals.dart';

Future<Response> getAccessToken() async {
  Response? response;

  try {
     response = await dio.post(
        authorizationLink,
        data: {
          'grant_type': 'client_credentials',
          'client_id': '30480b7ab0ff85a13ebca0ac0bd338f56dfaf0904ef8bc4866c3866930212be3',
          'client_secret': 'f60c5403a51a62eade9f61d99eca07a7cbac9adec3ce329756aae7a487e9cb8e'
        }
      );
    await saveTokenToLocalStorage(response);
  } catch (e) {
    rethrow ;
  }
  return response;
}
