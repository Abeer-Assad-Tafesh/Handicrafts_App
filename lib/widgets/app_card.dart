import 'package:flutter/material.dart';
import 'package:handcrafts/models/product_model.dart';
import '../utils/app_constant.dart';

class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.product,
    this.topMargin = 0,
  });

  final ProductModel product;
  final double topMargin;

  @override
  State<AppCard> createState() => AppCardState();
}

class AppCardState extends State<AppCard> {

  Color _favoriteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      margin: EdgeInsets.fromLTRB(10, widget.topMargin, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
         boxShadow: [
           // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 3),
           // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 5),
           // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 5),
           BoxShadow(
             color: Colors.grey.withOpacity(0.5),
             spreadRadius: 2,
             blurRadius: 4,
             offset: const Offset(0, 3), // changes position of shadow
           ),
         ],
        color: Colors.orangeAccent,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            AppConstants.BASE_URL+AppConstants.Upload_URI+
                widget.product.img!,),
        ),
      ),
      child:  Stack(
        children: [
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