import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/widgets.dart';

class AppDimensions {
  static late double screenWidth;
  static late double screenHeight;
  static late double screenPadding;
  static late double buttonHeight;
  static late double feedContentPadding;

  static void init(BuildContext context) {
    screenWidth = ScreenUtils().screenWidth(context);
    screenHeight = ScreenUtils().screenHeight(context);

    screenPadding = screenWidth*0.04;
    buttonHeight = screenHeight*0.055;
    feedContentPadding = screenWidth*0.05;

  }
}