import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WidgetConstants {
  static const double categoryGridItemHeight = 170;
  static const double categoryGridItemWidth = 192.8;
  static const double categoryGridItemTextWidth = categoryGridItemWidth - 58;
}

class NavigatorConstants {
  static backToPrev() {
    Get.back();
  }

  static sendToScreen(Widget widget) {
    Get.to(widget);
  }

  static closeApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static sendToNext(String route, {Object? arguments}) {
    if (arguments != null) {
      Get.toNamed(route, arguments: arguments);
    } else {
      Get.toNamed(route);
    }
  }
}
