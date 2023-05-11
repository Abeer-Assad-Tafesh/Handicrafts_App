import 'package:flutter/material.dart';
import 'package:handcrafts/screens/home/home_most_rated.dart';
import 'package:handcrafts/screens/home/home_most_requested.dart';
import 'package:handcrafts/screens/home/home_shops.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 10,),
          HomeMostRequested(),
          HomeMostRated(),
          HomeShops(),
        ],
      ),
    );
  }
}
