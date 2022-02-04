import 'package:flutter/material.dart';

class AuthorizationRoute extends StatelessWidget {
  const AuthorizationRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], radius: 0.8)
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Click on th lock to allow Swifty Companion use your 42intra account',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                InkWell(child: Image.asset('assets/icons/lock_icon.png', height: 250.0,)),
              ],
            ),
          ),
        )
      ),
    );
  }
}
