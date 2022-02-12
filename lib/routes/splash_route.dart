import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/functions/get_access_token.dart';
import 'package:swifty_companion/functions/validate_access_token.dart';
import 'package:swifty_companion/globals/globals.dart';

class SplashRoute extends StatelessWidget {
  const SplashRoute({Key? key}) : super(key: key);

  Future<dynamic> initAccessToken (BuildContext context) async {
    try {
      String? tmpAccessToken = await storage.read(key: 'accessToken');
      if (tmpAccessToken == null) {
        await getAccessToken();
      } else {
        accessToken = tmpAccessToken;
        await validateAccessToken();
      }
      print('-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
      Navigator.pushNamed(context, 'home_route');
    } catch (e) {
      // rethrow ;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initAccessToken(context),
        builder: (context, _) {
          return Container(
            height: kScreenHeight,
            width: kScreenWidth,
            decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(child: Hero(tag: 'app_logo', child: Image.asset('assets/images/app_logo.jpeg')), padding: const EdgeInsets.symmetric(horizontal: 60.0),),
              ],
            ),
          );
        }
      ),
    );
  }
}
