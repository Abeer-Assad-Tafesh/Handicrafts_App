import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/widgets/all_appBar.dart';

class HandLoadingImageScreen extends StatelessWidget {

  const HandLoadingImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(back: false),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: InteractiveViewer(
                    child: SvgPicture.asset('assets/images/hand_loading.svg',
                      height: 300,
                      width: 300,
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

