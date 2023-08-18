import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/api/get/auth_getx_controller.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/screens/buyer/profile/buyer_info_screen.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/widgets/not_yet.dart';
import 'package:random_color/random_color.dart';

import '../../../widgets/small_text.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? name;
  String? email;

  final AuthGetXController _authGetXController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SharedPrefController().loggedIn
        ? GetBuilder<AuthGetXController>(builder: (controller) {
            var user = controller.userApi;
            // print('666666666 ${user?.profile?.imgProfile}');
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    children: [
                      controller.userApi != null
                          ? Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: user!.profile?.imgProfile == null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          foregroundColor:
                                              Colors.deepPurpleAccent,
                                          child: Text(
                                            SharedPrefController()
                                                .name
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.grey.shade300,
                                          foregroundColor: Colors.grey,
                                          backgroundImage: FileImage(File(user.profile!.imgProfile!))
                                        ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name ?? '',
                                      style: TextStyle(
                                          color: kPrimaryColor, fontSize: 14),
                                    ),
                                    Text(
                                      user.email ?? '',
                                      style: TextStyle(
                                          color: kPrimaryColor, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, '/buyer_info_screen');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BuyerInfoScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/profile.svg"),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'معلوماتي',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/buyer_password_edit_screen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/password.svg"),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'كلمة المرور',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/buyer_orders_screen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/password.svg"),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'طلباتي',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/who_us_screen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/info_circle.svg"),
                                const SizedBox(width: 8),
                                Text('من نحن'),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/question_screen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/question.svg"),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('أسئلة'),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/contact_us_screen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/contact_us.svg"),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('تواصل معنا'),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          bool loggedOut = await AuthApiController().logout();
                          if (loggedOut)
                            Navigator.pushReplacementNamed(context, '/login_register_screen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/profile.svg"),
                                const SizedBox(width: 8),
                                SmallText(text:'تسجيل خروج',size: 15,),
                              ],
                            ),
                            SvgPicture.asset("assets/icons/logout.svg"),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  )),
            );
          })
        : const NotYet(
            image: 'assets/images/no_cart.svg',
            text: 'ليس لديك حساب حاليًا',
            textButton: 'سجل دخول لإنشاء حساب',
            route: '/login_register_screen',
          );
  }
}
