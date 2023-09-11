import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/widgets/all_appBar.dart';

import '../../../api/get/who_us_getx_controller.dart';



class WhoUsScreen extends StatelessWidget {
   WhoUsScreen({Key? key}) : super(key: key);
  WhoUsGetXController _whoUsGetXController = Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              AllAppBar(
                text: 'من نحن',
                back: true,
                // spaceAfterLogo: 0,
                spaceBeforeLogo: 45,
              ),
              Expanded(
                  child: GetBuilder<WhoUsGetXController>(builder: (controller){
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children:  [
                            Text('${controller.whoUs}',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20,)
                          ],
                        ),
                      ),
                    );
                  })
              ),
            ],
          )
      ),
    );
  }
}
