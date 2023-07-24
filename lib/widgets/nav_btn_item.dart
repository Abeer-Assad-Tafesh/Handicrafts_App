import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';
import 'out_boarding_indicator.dart';

class NavBtnItem extends StatelessWidget {

  final bool selected;
  final String iconImage;
  final bool dotVisibility;

  const NavBtnItem({
    super.key,
    required this.selected,
    required this.iconImage,
    this.dotVisibility = false,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: SvgPicture.asset(iconImage, color: selected ? kPrimaryColor : Colors.grey.shade600,),
      subtitle: Visibility(
          visible: dotVisibility,
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          child: OutBoardingIndicator(selected: selected,unSelectedColor: Colors.grey.shade600,marginEnd: 0,width: 6,height: 6,)
      ),
    );


    // return Column(
    //   children: [
    //     IconButton(
    //       enableFeedback: false,
    //       onPressed: onPressed,
    //       icon: SvgPicture.asset(iconImage, color: selected ? kDefaultColor : Colors.grey.shade600,
    //       ),
    //     ),
    //     Visibility(
    //         visible: dotVisibility,
    //         maintainAnimation: true,
    //         maintainState: true,
    //         maintainSize: true,
    //         child: OutBoardingIndicator(selected: selected,unSelectedColor: Colors.grey.shade600,marginEnd: 0,width: 6,height: 6,)
    //     ),
    //   ],
    // );
  }
}
