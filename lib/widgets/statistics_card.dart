import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
class StatisticsCard extends StatelessWidget {
  final String image;
  final String text;
  final String total;

  const StatisticsCard({
    super.key,
    required this.image,
    required this.text,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110,
        child: Card(
          elevation: 6,
          shadowColor: Colors.grey.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(image),
                    SizedBox(width: 8),
                    SmallText(text:text,color: Colors.grey,size: 15,),
                  ],
                ),
                SmallText(text: total,color: Colors.black,fontWeight: FontWeight.bold,size: 14,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}