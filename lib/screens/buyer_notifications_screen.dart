import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import '../constants.dart';

class BuyerNotificationsScreen extends StatelessWidget {
  const BuyerNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              back: true,
              text: 'الإشعارات',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 739,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 4,
                                    blurRadius: 6,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.grey,
                              ),
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 1,
                                        top: 8,
                                        bottom: 4),
                                    child: SvgPicture.asset(
                                      'assets/images/logo_image.svg',
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'تحديث جديد',
                                  style: TextStyle(
                                      fontSize: 16, color: kPrimaryColor),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Text(
                                  'قم بتحديث التطبيق',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                      ],
                    ),
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
