import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';

class ProfileRoute extends StatelessWidget {
  ProfileRoute({Key? key}) : super(key: key);

  double profileImageSize = kScreenWidth > 500 ? 250 : kScreenWidth * 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor],
              center: const Alignment(0, -0.05),
              radius: 0.8
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    child: Image.asset('assets/images/cover.jpg', width: 500.0,), padding: EdgeInsets.only(bottom: profileImageSize / 2),
                  ),
                  Positioned(
                    bottom: 0,
                    left: (profileImageSize + 5) / 2,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset('assets/images/profile_picture.jpeg', width: profileImageSize - 16, height: profileImageSize - 16),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30.0),
              const Text('Anas El boudali', style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

