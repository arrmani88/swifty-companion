import 'dart:ui' as ui;

late double kScreenHeight;
late double kScreenWidth;
String authorizationLink = 'https://api.intra.42.fr/oauth/token';
String hostname = 'https://api.intra.42.fr';

void setScreenDimensions () {
  kScreenHeight = ui.window.physicalSize.height / ui.window.devicePixelRatio;
  kScreenWidth = ui.window.physicalSize.width / ui.window.devicePixelRatio;
}
