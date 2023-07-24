import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotYet extends StatelessWidget {
  const NotYet({
    super.key,
    required this.image,
    this.text = '',
    this.title = '',
    this.textButton = '',
    this.route = '',
  });

  final String image;
  final String text;
  final String title;
  final String textButton;
  final String route;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: Column(
        children: [
          const Spacer(flex: 1,),
          Container(
              alignment: AlignmentDirectional.center,
              height: 300,
              width: 300,
              child: SvgPicture.asset(image),
          ),
          Text(
           title,
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Text(
            text,
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.h),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, route);
            },
            child: Text(
            textButton,
              style: TextStyle(color: kPrimaryColor,
                  fontSize: 18.sp,
                  decoration: TextDecoration.underline),
            ),
          ),
          const Spacer(flex: 4,),
        ],
      ),
    );
  }
}
