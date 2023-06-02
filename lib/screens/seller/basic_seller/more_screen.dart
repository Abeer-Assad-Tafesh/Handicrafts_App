import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
        child: Column(
          children: [
            const SizedBox(height: 20,),
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
                      SizedBox(width: 8,),
                      Text('معلومات المتجر'),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,size: 18,),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 10,),
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
                      const SizedBox(width: 8,),
                      const Text('متجري',
                        style: TextStyle(
                            fontSize: 15
                        ),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,size: 18,),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 10,),
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
                      SizedBox(width: 8,),
                      Text('من نحن'),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,size: 18,),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 10,),
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
                      const SizedBox(width: 8,),
                      Text('أسئلة'),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,size: 18,),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 10,),
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
                      const SizedBox(width: 8,),
                      Text('تواصل معنا'),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,size: 18,),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/profile.svg"),
                      SizedBox(width: 8,),
                      Text('تسجيل خروج'),
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
