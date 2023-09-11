import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/store_getx_controller.dart.dart';
import 'package:handcrafts/api/models/store.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/borderd_circle_avatar.dart';

import '../api/api_settings.dart';
import '../api/models/user.dart';

class AllAppBar extends StatelessWidget {
  final bool back;
  final bool logo;
  final String text;
  final double spaceBeforeLogo;
  final double spaceAfterLogo;

  AllAppBar(
      {super.key,
      this.text = '',
      required this.back,
      this.logo = true,
      this.spaceBeforeLogo = 0,
      this.spaceAfterLogo = 30});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    Store store = Store();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: back
            ? const EdgeInsets.only(top: 8, bottom: 8, left: 8)
            : const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  back ? Navigator.pop(context) : null;
                },
                child: back
                    ? SizedBox(
                        // width: size / 3,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/back_arrow.svg",
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              text,
                              style:
                                  TextStyle(fontSize: 14, color: kPrimaryColor),
                            ),
                            SizedBox(
                              width: spaceBeforeLogo,
                            ),
                          ],
                        ),
                      )
                    : SharedPrefController().typeUser == 'buyer'
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/search_screen');
                            },
                            child: SvgPicture.asset("assets/icons/search.svg"),
                          )
                        : GetBuilder<StoreGetXController>(
                            builder: (controller) {
                            var logo = controller.store?.logoImage;
                            return logo != null
                                ? Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ClipOval(
                                        child: Image.network(
                                          ApiSettings.getImageUrl(controller
                                              .store!.logoImage!
                                              .replaceFirst('uploads/', '')),
                                          fit: BoxFit.cover,
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                              width: 60,
                            );
                          })
                /*CircleAvatarWithBorder(imageUrl:
                store.logoImage == null ? "assets/images/store_logo.svg"
                    : store.logoImage
                ,)*/
                ),
            logo
                ? Row(
                    children: [
                      SizedBox(
                        // width: size / 3,
                        child: SvgPicture.asset(
                          "assets/icons/logo.svg",
                          height: 70,
                          width: 70,
                        ),
                      ),
                      SharedPrefController().typeUser == 'buyer'
                          ? const SizedBox()
                          : SizedBox(
                              width: spaceAfterLogo,
                            ),
                    ],
                  )
                : const SizedBox(),
            back
                ? SizedBox(
                    width: size / 3,
                    height: 40,
                  )
                : InkWell(
                    onTap: () {
                      SharedPrefController().typeUser == 'buyer'
                          ? Navigator.pushNamed(
                              context, '/buyer_notifications_screen')
                          : Navigator.pushNamed(
                              context, '/seller_notifications_screen');
                    },
                    child: SvgPicture.asset("assets/icons/notifications.svg")),
          ],
        ),
      ),
    );
  }
}
