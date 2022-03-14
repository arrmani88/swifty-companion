import 'package:flutter_web_auth/flutter_web_auth.dart';

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
    final String? code = Uri.parse(result).queryParameters['code'];

  } catch (e) {
    print(e);
  }
}

