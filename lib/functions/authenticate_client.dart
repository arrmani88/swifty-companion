import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<Response> AuthenticateClient(Future<Response> Function setState) async {
  late Response _response;
  setState(() => _isAppLoading = true);
  try {
    await InternetAddress.lookup('api.intra.42.fr');
    _response = await dio.post(
        authorizationLink,
        data: {
          'grant_type': 'client_credentials',
          'client_id': '30480b7ab0ff85a13ebca0ac0bd338f56dfaf0904ef8bc4866c3866930212be3',
          'client_secret': 'f60c5403a51a62eade9f61d99eca07a7cbac9adec3ce329756aae7a487e9cb8e'
        }
    );


    // await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, 'home_route');
  } on SocketException catch (_) {
    setState(() {
      _hasNoInternet = true;
      _isAppLoading = false;
    });
  } catch (e) {
    if (e is DioError)
      print(e.message);
    else
      print(e);
  }
  return _response;
}