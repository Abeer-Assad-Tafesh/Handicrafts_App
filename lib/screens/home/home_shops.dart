import 'package:flutter/material.dart';

class HomeShops extends StatelessWidget {
  const HomeShops({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      color: Colors.green.shade100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'widget.listTitle',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount:10,
              itemBuilder: (BuildContext context, int index) =>
                  Container()
              /*AppCard(
                product: demoProduct[index],
              ),*/
            ),
          ),
        ],
      ),
    );
  }
}
