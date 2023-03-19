import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/app_horz_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      scrollDirection: Axis.vertical,
      itemCount: 2+3, //( المتاجر + 'الأعلى تقييمًا'و'الأكثر طلبًا')
      itemBuilder: (context, index) {
        if(index == 0){
          return AppHorzListView(
            listTitle: 'الأكثر طلبًا',
            onTap: (){Navigator.pushNamed(context, '/most_requested');}
          );
        }else if(index == 1){
          return AppHorzListView(
            listTitle: 'الأعلى تقييمًا',
              onTap: (){Navigator.pushNamed(context, '/most_rated');}
          );
        }else {
          return AppHorzListView(
            listTitle: demoProduct[index].shopName,
            );
        }
      }
    );
  }
}
