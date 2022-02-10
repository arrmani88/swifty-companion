import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:swifty_companion/functions/parse_token.dart';
import 'package:swifty_companion/widgets/pop_ups/loading_pop_up.dart';
import 'dart:io';
import 'package:swifty_companion/widgets/pop_ups/no_internet_pop_up.dart';
import 'package:swifty_companion/functions/get_access_token.dart';

class AuthorizationRoute extends StatefulWidget {
  AuthorizationRoute({Key? key}) : super(key: key);
  @override State<AuthorizationRoute> createState() => _AuthorizationRouteState();
}
class _AuthorizationRouteState extends State<AuthorizationRoute> {
  bool _isAppLoading = false;
  bool _hasNoInternet = false;
  late Response _response;
  var dio = Dio();

  closeNoInterNetPopUp() {
    setState(() => _hasNoInternet = false);
  }

  closeLoadingPopUp() {
    setState(() => _isAppLoading = false);
  }

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
                        'Click on the lock to allow Swifty Companion use your 42 Intra account',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      const SizedBox(height: 40.0),
                      InkWell(
                        child: Image.asset('assets/icons/lock_icon.png', height: 250.0),
                        onTap: () async {
                          setState(() => _isAppLoading = true);
                          try {
                            await InternetAddress.lookup('api.intra.42.fr');
                            _response = await getAccessToken(dio);
                            Navigator.pushNamed(context, 'home_route');
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
                        },
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        'You\'ll be redirected to the 42 Intra website to authorize the use of your account',
                        style: TextStyle(color: Color(0xffa3a3a3), fontSize: 16.5),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
          if (_isAppLoading == true && _hasNoInternet == false) LoadingPopUp(callParentSetState: closeLoadingPopUp,),
          if (_hasNoInternet == true) NoInternetPopUp(closePopUp: closeNoInterNetPopUp,)
        ],
      ),
    );
  }
}
