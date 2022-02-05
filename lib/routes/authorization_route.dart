import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:swifty_companion/widgets/loading_pop_up.dart';
import "dart:async";
import 'package:swifty_companion/globals/globals.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class AuthorizationRoute extends StatefulWidget {
  AuthorizationRoute({Key? key}) : super(key: key);
  @override State<AuthorizationRoute> createState() => _AuthorizationRouteState();
}
class _AuthorizationRouteState extends State<AuthorizationRoute> {
  bool _isAppLoading = false;
  late Response _response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            onTap: _isAppLoading == false ? null : () => setState(() =>_isAppLoading = false),
            child: Container(
              decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], radius: 0.8)),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Click on the lock to allow Swifty Companion use your 42intra account',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      const SizedBox(height: 40.0),
                      InkWell(
                        child: Image.asset('assets/icons/lock_icon.png', height: 250.0),
                        onTap: () async {
                          _isAppLoading = true;
                          setState(() {});
                          try {
                            final result = await InternetAddress.lookup('api.intra.42.fr');
                            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) print('connected');
                          } on SocketException catch (_) {
                            print('not connected');
                          }
                          // try {
                            // _response = await dio.post(
                            //   authorizationLink,
                            //   data: {
                            //     'grant_type': 'client_credentials',
                            //     'client_id': '30480b7ab0ff85a13ebca0ac0bd338f56dfaf0904ef8bc4866c3866930212be3',
                            //     'client_secret': 'f60c5403a51a62eade9f61d99eca07a7cbac9adec3ce329756aae7a487e9cb8e'
                            //   }
                            // );
                            // print('RESPONSE =');
                            // print(_response.statusCode);
                            // print(_response);
                          // } catch (e) {
                          //   if (e is DioError)
                          //     print(e.message);
                          //   else
                          //     print(e);
                          // }
                        },
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        'You\'ll be redirected to the 42 intra website to authorize the use of your account',
                        style: TextStyle(color: Color(0xffa3a3a3), fontSize: 16.5),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
          if(_isAppLoading == true) const LoadingPopUp(),
        ],
      ),
    );
  }
}
