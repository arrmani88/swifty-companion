import 'package:swifty_companion/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'dart:async';

setProfilePictureWidget(String? profilePictureURL) async {
  final double profileImageSize = kScreenWidth > 500 ? 250 : kScreenWidth * 0.5;
  profilePictureWidget = Image.network(
    profilePictureURL!,
    width: profileImageSize - 16,
    height: profileImageSize - 16,
    errorBuilder: (context, exception, stackTrace) {
      return Image.asset('assets/images/blank_profile_picture.png', width: profileImageSize - 16, height: profileImageSize - 16);
    },
  );
}