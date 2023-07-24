import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/home_getx_controller.dart';
import 'package:handcrafts/api/models/all_products.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/not_yet.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutShopPage extends StatefulWidget {
  AllProducts? product;

  AboutShopPage({Key? key, this.product}) : super(key: key);

  @override
  State<AboutShopPage> createState() => _AboutShopPageState();
}

class _AboutShopPageState extends State<AboutShopPage> {

  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 30, bottom: 10),
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
                        InkWell(
                          onTap: (){
                            makePhoneCall('0595395820');
                          },
                          child: SvgPicture.asset(
                            "assets/icons/call.svg",
                            height: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: (){
                            print('${_auth.currentUser}   ===========>');
                            Navigator.pushNamed(context,
                                _auth.currentUser != null ? '/chat_screen' :'/login_register_screen'
                            );

                          },
                          child: SvgPicture.asset(
                            "assets/icons/chat.svg",
                            height: 22,
                          ),
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
                    Text(
                     widget.product!.store.description,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
