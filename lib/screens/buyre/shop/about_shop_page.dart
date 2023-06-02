import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';


class AboutShopPage extends StatelessWidget {
  const AboutShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'منصات التواصل الإجتماعي',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/facebook.svg",
                            height: 24,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SvgPicture.asset(
                            "assets/icons/instagram.svg",
                            height: 22,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SvgPicture.asset(
                            "assets/icons/tiktok.svg",
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'تواصل معنا',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/call.svg",
                            height: 22,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SvgPicture.asset(
                            "assets/icons/chat.svg",
                            height: 22,
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'من نحن',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى،'
                            ' حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.'
                            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى،'
                            'حيث يمكنك أن تولد مثل هذا النص.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
