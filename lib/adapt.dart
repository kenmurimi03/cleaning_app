import 'package:flutter/material.dart';

class Adapt {
  static late MediaQueryData mediaQuery;
  static late double? _width;
  static late double? _height;
  static late double? _topbarH;
  static late double? _botbarH;
  static late double _pixelRatio;
  static num? _ratio;

  static void initContext(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    _width = mediaQuery.size.width;
    _height = mediaQuery.size.height;
    _topbarH = mediaQuery.padding.top;
    _botbarH = mediaQuery.padding.bottom;
    _pixelRatio = mediaQuery.devicePixelRatio;
  }

  static void init(int number) {
    final uiwidth = number;
    _ratio = _width! / uiwidth;
  }

  static double px(num number) {
    if (!(_ratio is double || _ratio is int)) {
      Adapt.init(750);
    }
    return (number * _ratio!).toDouble();
  }

  static double onepx() {
    return 1 / _pixelRatio;
  }

  static double screenW() {
    return _width!;
  }

  static double screenH() {
    return _height!;
  }

  static double padTopH() {
    return _topbarH!;
  }

  static double padBotH() {
    return _botbarH!;
  }
}
