import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/globals/globals.dart';

class CoverAndProfilePictures extends StatelessWidget {
  final String? profilePictureURL;
  CoverAndProfilePictures({Key? key, required this.profilePictureURL}) : super(key: key);
  final double profileImageSize = kScreenWidth > 500 ? 250 : kScreenWidth * 0.5;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            child: profilePictureWidget,
          ),
        )
      ],
    );
  }
}

