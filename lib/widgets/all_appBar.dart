import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AllAppBar extends StatelessWidget {
  const AllAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(''),
                InkWell(
                    onTap:(){},
                    child: SvgPicture.asset("assets/icons/search.svg")),
              ],
            ),
            SizedBox(
                height: 70,
                width: 70,
                child: SvgPicture.asset("assets/icons/logo.svg")),
            InkWell(
                onTap: (){},
                child: SvgPicture.asset("assets/icons/notifications.svg")),
          ],
        ),
      ),
    );
  }
}
