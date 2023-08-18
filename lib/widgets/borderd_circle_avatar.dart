import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';

class CircleAvatarWithBorder extends StatelessWidget {
  final String imageUrl;

  CircleAvatarWithBorder({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400,width: 1)
      ),
      padding: const EdgeInsets.all(6),
      child:Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400,width: 1),
          image: DecorationImage(
            image: AssetImage(imageUrl),// NetworkImage(imageUrl) ,
            fit: BoxFit.cover,
          ),
        ),

        /*child: SvgPicture.asset(
          'assets/images/store_logo.svg',
        ),*/
      ),
    );
  }
}
