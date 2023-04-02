import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';

class TextFormLabel extends StatelessWidget {

  final String icon;
  final String label;

   const TextFormLabel({super.key,
    required this.icon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            color: kDefaultColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

