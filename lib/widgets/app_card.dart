import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/product.dart';

class AppCard extends StatefulWidget {
  const AppCard({
    super.key, required this.product,
  });

  final Product product;

  @override
  State<AppCard> createState() => AppCardState();
}

class AppCardState extends State<AppCard> {

  Color _favoriteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(10, 8, 0, 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        children: [
          SvgPicture.asset(widget.product.images.first),
          Positioned(
              right: 10,
              top: 10,
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite_rounded, color: _favoriteColor,),
                    onPressed: (){
                      setState(() {
                        if(_favoriteColor == Colors.white){
                          _favoriteColor = Colors.red.shade900;
                        }else {
                          _favoriteColor = Colors.white;
                        }
                      });
                    },
                  )
              )
          ),
          Positioned(
              left: 10,
              bottom: 10,
              child: Text('\$ ${widget.product.price}')),
        ],
      ),
    );
  }
}