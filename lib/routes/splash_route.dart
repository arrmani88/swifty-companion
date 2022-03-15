import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/functions/do_refresh_tokens.dart';
import 'package:swifty_companion/functions/get_access_token_with_client_credentials_flow.dart';
import 'package:swifty_companion/functions/validate_access_token.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/functions/save_token_to_local_storage.dart';

import '../providers/pop_up_provider.dart';
import '../widgets/pop_ups/error_pop_up.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({Key? key}) : super(key: key);
  @override State<SplashRoute> createState() => _SplashRouteState();
}
class _SplashRouteState extends State<SplashRoute> {
  late Future initAccessTokenVariable;
  String? descriptionMessage;

  @override
  initState () {
    super.initState();
    initAccessTokenVariable = initAccessToken(context);
  }

  Future<dynamic> initAccessToken (BuildContext context) async {
    // await getAccessTokenWithClientCredentialsFlow();        // client credential flow - oauth2
    // Navigator.pushReplacementNamed(context, 'home_route');  // client credential flow - oauth2
    try {
      String? tmp;
      await InternetAddress.lookup('api.intra.42.fr');
      tmp = await storage.read(key: 'accessTokenCreatedAt');
      if (tmp != null) accessTokenCreatedAt = int.parse(tmp);
      if (accessTokenCreatedAt == null) { // if no token is locally saved
        Navigator.pushReplacementNamed(context, 'authorization_route');
      } else { // if a token was saved locally
        validateAccessToken();
        Navigator.pushReplacementNamed(context, 'home_route');
      }
    } on SocketException catch (_) {
      context.read<PopUpProvider>().displayNoInternetPopUp();
    } catch (e) {
      if (e is DioError) {
        descriptionMessage = (e.response?.data as Map<String, dynamic>)['error_description'];
        context.read<PopUpProvider>().displayUnknownErrorPopUp();
      } else {
        descriptionMessage = null;
        context.read<PopUpProvider>().displayUnknownErrorPopUp();
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: kScreenHeight,
            width: kScreenWidth,
            decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(child: Hero(tag: 'app_logo', child: Image.asset('assets/images/app_logo.jpeg')), padding: const EdgeInsets.symmetric(horizontal: 60.0),),
              ],
            ),
          ),
          if (context.watch<PopUpProvider>().isNoInternetPopUpDisplayed == true) ErrorPopUp(closePopUp: () {}, descriptionMessage: 'Either your device isn\'t connected to the internet, or the server that you are looking for is down',)
          else if (context.watch<PopUpProvider>().isUnknownErrorPopUpDisplayed == true) ErrorPopUp(closePopUp: () {}, descriptionMessage: descriptionMessage,)
        ],
      ),
    );
  }
}
