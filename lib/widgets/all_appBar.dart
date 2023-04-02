import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';

class AllAppBar extends StatelessWidget {
  final bool back;
  final String text;

  AllAppBar({super.key, this.text = '', required this.back});

  @override
  Widget build(BuildContext context) {

    double size = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: back ? const EdgeInsets.only(top: 8, bottom: 8) : const EdgeInsets.all(8) ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {},
                child: back
                    ? SizedBox(
                      width: size/3,
                      child: Row(
                          children: [
                            const SizedBox(width: 8,),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                                child: SvgPicture.asset("assets/icons/back_arrow.svg",)
                            ),
                          const SizedBox(width: 8,),
                          Text(text,
                          style: TextStyle(
                            fontSize: 14,
                            color: kDefaultColor
                          ),),
                        ]
                      ),
                    )
                    : SvgPicture.asset("assets/icons/search.svg")),
            SizedBox(
                width: size/3,
                child: SvgPicture.asset("assets/icons/logo.svg",height: 70, width: 70,),
            ),
            back ? SizedBox(
              width: size/3,
              height: 40,
            ) :
            InkWell(
                onTap: () {},
                child: SvgPicture.asset("assets/icons/notifications.svg")),
          ],
        ),
      ),
    );
  }
}
