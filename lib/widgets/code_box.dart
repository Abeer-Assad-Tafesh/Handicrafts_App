import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CodeBox extends StatelessWidget {
  const CodeBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
          style: TextStyle(color: kPrimaryColor,fontSize: 35,fontWeight: FontWeight.w400 ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
