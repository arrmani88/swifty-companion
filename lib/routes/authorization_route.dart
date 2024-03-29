import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:notifier_42/constants/constants.dart';
import 'package:notifier_42/widgets/pop_ups/loading_pop_up.dart';
import 'package:notifier_42/widgets/pop_ups/error_pop_up.dart';
import 'package:notifier_42/functions/get_access_token_with_authorization_code_flow.dart';

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
      Navigator.pushReplacementNamed(context, 'home_route');
    } on SocketException catch (_) {
      describeTheError('Either your device isn\'t connected to the internet, or the server that you are looking for is down');
    } catch (e) {
      if (e is DioError)
        {describeTheError((e.response?.data as Map<String, dynamic>)['error_description']);}
      else {
        print(e);
        describeTheError('An unknown error has occured, try re-connecting the device with internet and restart the app');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], radius: 0.8)),
        height: kScreenHeight,
        child: Stack(
          children: [
            Container(
              height: kScreenHeight,
              child: Center(
                child: SingleChildScrollView(
                  child: InkWell(
                    // onTap: _isLoadingPopUpDisplayed == false ? null : () => setState(() =>_isLoadingPopUpDisplayed = false),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Click on the lock to allow 42 Notifier use your 42 Intra account',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 25.0),
                              ),
                              const SizedBox(height: 40.0),
                              InkWell(
                                child: Image.asset('assets/icons/lock_icon.png', height: kScreenWidth > 400 ? 250.0 : kScreenHeight / 2.5),
                                onTap: onLockTap,
                              ),
                              const SizedBox(height: 40.0),
                              const Text(
                                'You\'ll be redirected to the 42 Intra website to authorize the use of your account',
                                style: TextStyle(color: Color(0xffa3a3a3), fontSize: 16.5),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_isLoadingPopUpDisplayed == true && _isErrorPopUpDisplayed == false)
              const LoadingPopUp(),
            if (_isErrorPopUpDisplayed == true)
              ErrorPopUp(closePopUp: closeErrorPopUp, descriptionMessage: descriptionMessage)
          ],
        ),
      ),
    );
  }
}

