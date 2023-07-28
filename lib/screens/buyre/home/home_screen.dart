import 'package:flutter/material.dart';
import 'package:handcrafts/screens/buyre/home/home_most_rated.dart';
import 'package:handcrafts/screens/buyre/home/home_most_requested.dart';
import 'package:handcrafts/screens/buyre/home/home_stores.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          HomeStores(),
          HomeMostRequested(),
          HomeMostRated(),
          SizedBox(height: 100,),
        ],
      ),
    );
  }
}
