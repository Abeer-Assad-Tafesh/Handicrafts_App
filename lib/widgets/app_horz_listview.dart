import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/models/product.dart';

class AppHorzListView extends StatefulWidget{
   const AppHorzListView({Key? key,
     required this.listTitle,
     this.productName,
     this.productItemImage,
     this.productsItemCount,
     this.onTap,}) : super(key: key);


  final String listTitle;
  final String? productName;
  final String? productItemImage;
  final int? productsItemCount;
  final VoidCallback? onTap;

   @override
  State<AppHorzListView> createState() => _AppHorzListView();
}

class _AppHorzListView extends State<AppHorzListView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      // color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.onTap,
                  child: Text(
                    widget.listTitle,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: demoProduct.length,
              itemBuilder: (BuildContext context, int index) => AppCard(
                 product: demoProduct[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
