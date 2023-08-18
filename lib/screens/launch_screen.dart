import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handcrafts/firebase/fb_notifications.dart';

import '../prefs/shared_pref_controller.dart';


class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with FbNotifications {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //FCM Messaging
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();

    Future.delayed(const Duration(seconds: 1), () {
     var route =  SharedPrefController().loggedIn ?
      SharedPrefController().typeUser == 'buyer' ? '/out_boarding_screen' : '/basic_seller_screens'
      : '/out_boarding_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_screens.png' ,width: double.infinity,fit: BoxFit.cover),
          Center(
            child: SizedBox(
              height: 160.h,
              width: 160.w,
              child: SvgPicture.asset('assets/images/logo_image.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
