import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FullImageScreen extends StatelessWidget {
  String? image;

  FullImageScreen({this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: InteractiveViewer(child: Image.network(image!)),
      ),
    );
  }
}

