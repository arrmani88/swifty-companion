import 'dart:ui' as ui;

late double kScreenHeight;
late double kScreenWidth;

void setScreenDimensions () {
  kScreenHeight = ui.window.physicalSize.height / ui.window.devicePixelRatio;
  kScreenWidth = ui.window.physicalSize.width / ui.window.devicePixelRatio;
}
