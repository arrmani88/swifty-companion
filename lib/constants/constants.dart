import 'dart:ui' as ui;
import 'package:flutter/material.dart';

late final double kScreenHeight;
late final double kScreenWidth;
const String kClientCredentialsFlowAuthorizationLink = 'https://api.intra.42.fr/oauth/token';
// const String kAuthorizationCodeFlowAuthorizationLink = 'https://api.intra.42.fr/oauth/authorize';
const String kHostname = 'https://api.intra.42.fr';
const Color kSubscribedColor = Color(0xffdec666);
const Color kValidatedColor = Color(0xff79ab98);
const Color kFailedColor = Color(0xffdc8088);

void setScreenDimensions () {
  kScreenHeight = ui.window.physicalSize.height / ui.window.devicePixelRatio;
  kScreenWidth = ui.window.physicalSize.width / ui.window.devicePixelRatio;
}
