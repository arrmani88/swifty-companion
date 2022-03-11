import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:swifty_companion/widgets/pop_ups/loading_pop_up.dart';
import 'package:swifty_companion/widgets/pop_ups/error_pop_up.dart';
import 'package:swifty_companion/functions/validate_access_token.dart';
import 'package:swifty_companion/functions/get_access_token_with_authorization_code_flow.dart';

class AuthorizationRoute extends StatefulWidget {
  AuthorizationRoute({Key? key}) : super(key: key);
  @override State<AuthorizationRoute> createState() => _AuthorizationRouteState();
}
class _AuthorizationRouteState extends State<AuthorizationRoute> {
  bool _isLoadingPopUpDisplayed = false;
  bool _isErrorPopUpDisplayed = false;
  String? descriptionMessage;

  closeErrorPopUp() {
    setState(() => _isErrorPopUpDisplayed = false);
  }
  closeLoadingPopUp() {
    setState(() => _isLoadingPopUpDisplayed = false);
  }
  describeTheError(String msg) {
    setState(() {
      descriptionMessage = msg;
      _isErrorPopUpDisplayed = true;
      _isLoadingPopUpDisplayed = false;
    });
  }
  onLockTap() async {
    setState(() => _isLoadingPopUpDisplayed = true);
    try {
      await InternetAddress.lookup('api.intra.42.fr');
      await getAccessTokenWithAuthorizationCodeFlow();
      // await validateAccessToken();
      Navigator.pushNamed(context, 'home_route');
    } on SocketException catch (_) {
      describeTheError('Either your device isn\'t connected to the internet, or the server that you are looking for is down');
    } catch (e) {
      if (e is DioError)
        {describeTheError((e.response?.data as Map<String, dynamic>)['error_description']);}
      else
        {describeTheError('An unknown error has occured, try re-connecting the device with internet and restart the app');}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            onTap: _isLoadingPopUpDisplayed == false ? null : () => setState(() =>_isLoadingPopUpDisplayed = false),
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
                        onTap: onLockTap,
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
          if (_isLoadingPopUpDisplayed == true && _isErrorPopUpDisplayed == false)
            const LoadingPopUp(),
          if (_isErrorPopUpDisplayed == true)
            ErrorPopUp(closePopUp: closeErrorPopUp, descriptionMessage: descriptionMessage)
        ],
      ),
    );
  }
}
