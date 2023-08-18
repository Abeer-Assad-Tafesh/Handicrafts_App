import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/screens/chat/chat_screen.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20.h,left: 10.w,right: 10.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/store_info_page');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/store_info.svg"),
                      SizedBox(width: 8.w),
                      SmallText(text:'معلومات المتجر',size: 15),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,size: 18.w),
                ],
              ),
            ),
            const Divider(),
            /*SizedBox(height: 10.h),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/my_store_page');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/my_store.svg"),
                      SizedBox(width: 8.w),
                      SmallText(text: 'متجري',size: 15)
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,size: 18.w),
                ],
              ),
            ),
            const Divider(),*/
            SizedBox(height: 10.h),
            InkWell(
              onTap: (){
                /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                    ChatScreen(
                      store_Name: widget.product!.store.name,
                      store_Id: widget.product!.store.id.toString(),
                      ),
                ));*/
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/email.svg"),
                      SizedBox(width: 8.w),
                      SmallText(text: 'تشات',size: 15)
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,size: 18.w),
                ],
              ),
            ),
            const Divider(),
            SizedBox(height: 10.h),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/who_us_seller_page');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/info_circle.svg"),
                      SizedBox(width: 8.w),
                      SmallText(text:'من نحن',size: 15,),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,size: 18.w),
                ],
              ),
            ),
            const Divider(),
            SizedBox(height: 10.h),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/question_seller_page');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/question.svg"),
                      SizedBox(width: 8.w),
                      SmallText(text:'أسئلة',size: 15,),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,size: 18.w),
                ],
              ),
            ),
            const Divider(),
            SizedBox(height: 10.h),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/contact_us_seller_page');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/contact_us.svg"),
                      SizedBox(width: 8.w),
                      SmallText(text:'تواصل معنا',size: 15,),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,size: 18.w),
                ],
              ),
            ),
            const Divider(),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () async {
                bool loggedOut = await AuthApiController().logout();
                if(loggedOut) Navigator.pushReplacementNamed(context, '/login_register_screen');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/profile.svg"),
                      SizedBox(width: 8.w),
                      SmallText(text:'تسجيل خروج',size: 15,),
                    ],
                  ),
                  SvgPicture.asset("assets/icons/logout.svg"),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
    );
  }
}
