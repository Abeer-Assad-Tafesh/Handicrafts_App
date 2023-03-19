// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:handcrafts/screens/account_screen.dart';
// import 'package:handcrafts/screens/cart_screen.dart';
// import 'package:handcrafts/screens/favorite_screen.dart';
// import 'package:handcrafts/screens/home_screen.dart';
// // import 'nav_btn_item.dart';
// //
// // class AppBottomNavBar extends StatefulWidget {
// //   const AppBottomNavBar({Key? key}) : super(key: key);
// //
// //   @override
// //   State<AppBottomNavBar> createState() => _AppBottomNavBarState();
// // }
// //
// // class _AppBottomNavBarState extends State<AppBottomNavBar> {
// //   //
// //   // bool _isSelectedHome = true;
// //   // bool _isSelectedFavorite = false;
// //   // bool _isSelectedCart = false;
// //   // bool _isSelectedUserAccount = false;
// //
// //   int pageIndex = 0;
// //
// //   final pages = [
// //     const HomeScreen(),
// //     const FavoriteScreen(),
// //     const CartScreen(),
// //     const AccountScreen(),
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Positioned(
// //       left: 1,right: 1,bottom: 5,
// //       child: Container(
// //         height: 60,
// //         margin: const EdgeInsets.fromLTRB(40, 0, 40, 20),
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(30),
// //           border: Border.all(color: Colors.white),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.2),
// //               spreadRadius: 0.2,
// //               blurRadius: 9,
// //               offset: const Offset(0,0), // changes position of shadow
// //             ),
// //           ],
// //         ),
// //         child: ClipRRect(
// //           borderRadius: BorderRadius.circular(30),
// //           child: BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //             child: Row(
// //
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: [
// //                 NavBtnItem(iconImage: 'assets/icons/home.svg',
// //                   selected: pageIndex == 0 ? true : false,
// //                   dotVisibility: pageIndex == 0 ? true : false,
// //                   onPressed: (){
// //                     setState(() {
// //                       pageIndex = 0;
// //                       print('page 0');
// //                       // if(pageIndex == 0){
// //                       //   setState(() {
// //                       //     _isSelectedHome = true;
// //                       //     _isSelectedFavorite = false;
// //                       //     _isSelectedCart = false;
// //                       //     _isSelectedUserAccount = false;
// //                       //   });
// //                       // }
// //                     });
// //
// //                   },
// //                 ),
// //                 NavBtnItem(iconImage: 'assets/icons/heart.svg',
// //                   selected: pageIndex == 1 ? true : false,
// //                   dotVisibility: pageIndex == 1 ? true : false,
// //                   onPressed: (){
// //                     setState(() {
// //                       pageIndex = 1;
// //                       print('page 1');
// //
// //                       // if(pageIndex == 1){
// //                       //   setState(() {
// //                       //     _isSelectedHome = false;
// //                       //     _isSelectedFavorite = true;
// //                       //     _isSelectedCart = false;
// //                       //     _isSelectedUserAccount = false;
// //                       //   });
// //                       // }
// //                     });
// //                   },
// //                 ),
// //                 NavBtnItem(iconImage: 'assets/icons/buy.svg',
// //                   selected: pageIndex == 2 ? true : false,
// //                   dotVisibility: pageIndex == 2 ? true : false,
// //                   onPressed: (){
// //                     setState(() {
// //                       pageIndex = 2;
// //                       print('page 2');
// //
// //                     });
// //                     // if(pageIndex == 2){
// //                     //   setState(() {
// //                     //     _isSelectedHome = false;
// //                     //     _isSelectedFavorite = false;
// //                     //     _isSelectedCart = true;
// //                     //     _isSelectedUserAccount = false;
// //                     //   });
// //                     // }
// //                   },
// //                 ),
// //                 NavBtnItem(iconImage: 'assets/icons/category.svg',
// //                   selected: pageIndex == 3 ? true : false,
// //                   dotVisibility: pageIndex == 3 ? true : false,
// //                   onPressed: (){
// //                     setState(() {
// //                       pageIndex = 3;
// //                       print('page 3');
// //
// //                     });
// //                     // if(pageIndex == 3){
// //                     // setState(() {
// //                     //   _isSelectedHome = false;
// //                     //   _isSelectedFavorite = false;
// //                     //   _isSelectedCart = false;
// //                     //   _isSelectedUserAccount = true;
// //                     // });
// //                     // }
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// }
