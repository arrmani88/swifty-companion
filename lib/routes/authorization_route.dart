import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:swifty_companion/functions/save_token_to_local_storage.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/widgets/pop_ups/loading_pop_up.dart';
import 'dart:io';
import 'package:swifty_companion/widgets/pop_ups/error_pop_up.dart';
import 'package:swifty_companion/functions/get_access_token.dart';
import 'package:swifty_companion/functions/validate_access_token.dart';

class AuthorizationRoute extends StatefulWidget {
  AuthorizationRoute({Key? key}) : super(key: key);
  @override State<AuthorizationRoute> createState() => _AuthorizationRouteState();
}
class _AuthorizationRouteState extends State<AuthorizationRoute> {
  bool _showLoadingPopUp = false;
  bool _showErrorPopUp = false;
  String? descriptionMessage;

  closeErrorPopUp() {
    setState(() => _showErrorPopUp = false);
  }

  closeLoadingPopUp() {
    setState(() => _showLoadingPopUp = false);
  }

  describeTheError(String msg) {
    setState(() {
      descriptionMessage = msg;
      _showErrorPopUp = true;
      _showLoadingPopUp = false;
    });
  }

  onLockTap() async {
    setState(() => _showLoadingPopUp = true);
    try {
      await InternetAddress.lookup('api.intra.42.fr');
      await validateAccessToken();
      Navigator.pushNamed(context, 'home_route');
    } on SocketException catch (_) {
      describeTheError('Either your device isn\'t connected to the internet, or the server that you are looking for is down');
    } catch (e) {
      if (e is DioError)
        {describeTheError((e.response?.data as Map<String, dynamic>)['error_description']);}
      else
        {describeTheError('Try re-connecting the device with internet and restart the app');}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            onTap: _showLoadingPopUp == false ? null : () => setState(() =>_showLoadingPopUp = false),
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
          if (_showLoadingPopUp == true && _showErrorPopUp == false)
            LoadingPopUp(callParentSetState: closeLoadingPopUp),
          if (_showErrorPopUp == true)
            ErrorPopUp(closePopUp: closeErrorPopUp, descriptionMessage: descriptionMessage)
        ],
      ),
    );
  }
}
