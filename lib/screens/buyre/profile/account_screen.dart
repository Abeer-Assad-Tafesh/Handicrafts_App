import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/widgets/not_yet.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SharedPrefController().loggedIn
        ? SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.grey,
                            child: const Icon(
                              Icons.person_outline_rounded,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'محمود احمد المنصور',
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                            Text(
                              'Mahmoud@gmail.com',
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/buyer_info_screen');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/profile.svg"),
                              SizedBox(
                                width: 8,
                              ),
                              Text('معلوماتي'),
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
                              SvgPicture.asset("assets/icons/info_circle.svg"),
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
                          Navigator.pushNamed(
                              context, '/login_register_screen');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/profile.svg"),
                              const SizedBox(width: 8),
                              Text('تسجيل خروج'),
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
          )
        : const NotYet(
            image: 'assets/images/no_cart.svg',
            text: 'ليس لديك حساب حاليًا',
            textButton: 'سجل دخول لإنشاء حساب',
            route: '/login_register_screen',
          );
  }
}
