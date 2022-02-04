import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:swifty_companion/widgets/loading_wrapper.dart';

class AuthorizationRoute extends StatelessWidget {
  const AuthorizationRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                      'Click on the lock to allow Swifty Companion use your 42intra account',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    const SizedBox(height: 40.0),
                    InkWell(
                      child: Image.asset('assets/icons/lock_icon.png', height: 250.0),
                      onTap: () {},
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
          const LoadingWrapper(),
        ],
      ),
    );
  }
}
