import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/home_getx_controller.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/screens/login_register/login_register_screen.dart';
import 'package:handcrafts/screens/chat/chat_screen.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/not_yet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/models/store.dart';

class AboutShopPage extends StatefulWidget {
  Product? product;
  Store? store;

  AboutShopPage({Key? key, this.product, this.store}) : super(key: key);

  @override
  State<AboutShopPage> createState() => _AboutShopPageState();
}

class _AboutShopPageState extends State<AboutShopPage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: widget.product == null
              ? Column(
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
                                InkWell(
                                  onTap: () {
                                    if (widget.store!.urlFacebook != null) {
                                      _launchURL(widget.store!.urlFacebook);
                                    } else {
                                      Get.snackbar('عذراً',
                                          'لا يوجد صفحة فيسبوك للمتجر');
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/facebook.svg",
                                    height: 24,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (widget.store!.urlInstagram != null) {
                                      _launchURL(widget.store!.urlInstagram);
                                    } else {
                                      Get.snackbar('عذراً',
                                          'لا يوجد صفحة انستجرام للمتجر');
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/instagram.svg",
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
                                  onTap: () {
                                    if (widget.store!.phoneWhatsapp != null) {
                                      makePhoneCall(widget.store!.phoneWhatsapp
                                          .toString());
                                    }
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
                                  onTap: () {
                                    sendSMS(
                                        widget.store!.phoneWhatsapp.toString());
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/message.svg",
                                    color: kPrimaryColor,
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
                              'تشات المتجر',
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
                                  onTap: () {
                                    if (_auth.currentUser != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                            store_Name: widget.store!.name,
                                            store_Id:
                                                widget.store!.id.toString(),
                                          ),
                                        ),
                                      );
                                    } else {
                                      Get.snackbar('سجل الدخول لحسابك أولاً',
                                          'سجل الدخول لتتمتع بالمراسلة مع المتجر والمشترين :)');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginRegisterScreen()),
                                      );
                                    }
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
                              widget.store!.description?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                )
              : Column(
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
                                InkWell(
                                  onTap: () {
                                    if (widget.product!.store.urlFacebook !=
                                        null) {
                                      _launchURL(
                                          widget.product!.store.urlFacebook);
                                    } else {
                                      Get.snackbar('عذراً',
                                          'لا يوجد صفحة فيسبوك للمتجر');
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/facebook.svg",
                                    height: 24,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (widget.product!.store.urlInstagram !=
                                        null) {
                                      _launchURL(
                                          widget.product!.store.urlInstagram);
                                    } else {
                                      Get.snackbar('عذراً',
                                          'لا يوجد صفحة انستجرام للمتجر');
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/instagram.svg",
                                    height: 22,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(),
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
                                  onTap: () {
                                    if (widget.product!.store.phoneWhatsapp !=
                                        null) {
                                      makePhoneCall(widget
                                          .product!.store.phoneWhatsapp
                                          .toString());
                                    }
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
                                  onTap: () {
                                    if (_auth.currentUser != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                            store_Name: widget.product!.store.name,
                                            store_Id:
                                            widget.product!.store.id.toString(),
                                          ),
                                        ),
                                      );
                                    } else {
                                      Get.snackbar('سجل الدخول لحسابك أولاً',
                                          'سجل الدخول لتتمتع بالمراسلة مع المتجر والمشترين :)');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const LoginRegisterScreen()),
                                      );
                                    }
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
                              'تشات المتجر',
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
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      if (_auth.currentUser != null) {
                                        return ChatScreen(
                                          store_Name:
                                              widget.product!.store.name,
                                          store_Id: widget.product!.store.id
                                              .toString(),
                                        );
                                      } else {
                                        Get.snackbar('سجل الدخول لحسابك أولاً',
                                            'سجل الدخول لتتمتع بالمراسلة مع المتجر والمشترين :)');
                                        return const LoginRegisterScreen();
                                      }
                                    }));
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
                              widget.product!.store.description?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                )),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendSMS(String phoneNumber) async {
    String message = '';
    String url = 'sms:$phoneNumber?body=${Uri.encodeComponent(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch SMS: $url';
    }
    // final Uri launchUri = Uri(
    //   scheme: 'sms',
    //   path: phoneNumber,
    // );
    // await launchUrl(launchUri);
  }

  _launchURL(url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
