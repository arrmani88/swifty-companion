import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/app_logo.jpeg', height: 150.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
