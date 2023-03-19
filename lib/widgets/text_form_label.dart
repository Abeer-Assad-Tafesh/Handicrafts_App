import 'package:flutter/material.dart';
import 'package:handcrafts/constants.dart';

class TextFormLabel extends StatelessWidget {

  final IconData icon;
  final String label;

   const TextFormLabel({super.key,
    required this.icon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
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
    );
  }
}
