import 'package:swifty_companion/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';

setProfilePictureWidget(String? profilePictureURL) {
  final double profileImageSize = kScreenWidth > 500 ? 250 : kScreenWidth * 0.5;
  profilePictureWidget = SizedBox(
    width: profileImageSize - 16,
    height: profileImageSize - 16,
    child: Image.network(
      profilePictureURL!,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, exception, stackTrace) {
        return Image.asset('assets/images/blank_profile_picture.png');
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 100.0),
              const SizedBox(height: 20.0),
              const Text('Loading ...', style: TextStyle(color: Colors.white, fontSize: 25.0)),
            ],
          ),
        );
      },
    ),
  );
}

