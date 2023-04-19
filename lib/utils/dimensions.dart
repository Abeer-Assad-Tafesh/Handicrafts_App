import 'package:get/get.dart';

class Dimensions{
  // screenHeight = 866.3
  // screenWidth = 411
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // 866/220 = 3.93
  static double pageView = screenHeight /2.93;
  static double pageViewContainer = screenHeight /3.93 ;
  static double pageViewTextContainer = screenHeight /7.03;

  // 866/10 = 86.6
  static double height10 = screenHeight/86.6;
  static double height15 = screenHeight/57.7;

  static double width10 = screenHeight/86.6;
  static double width15 = screenHeight/57.7;

  static double font20 = screenHeight/43.3;
  static double radius10 = screenHeight/86.6;

  static double icon24 = screenHeight/36;


}