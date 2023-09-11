import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/api/get/home_getx_controller.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/widgets/app_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // PopularProductControllers _popularProductControllers = Get.find();
  TextEditingController searchController = TextEditingController();
  List<Product> searchResults = [];
  String searchText = '';

  void search(String text,List<Product> products) {
    setState(() {
      searchText = text.toLowerCase();
      /*searchResults = products
          .where((product) =>
          product.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();*/
      searchResults = products
          .where((product) =>
      product.name.toLowerCase().contains(searchText.toLowerCase()) ||
          product.description.toLowerCase().contains(searchText.toLowerCase()) ||
          product.category!.name.toLowerCase().contains(searchText.toLowerCase())
      ).toList();
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      search('',[]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeGetXController>(builder: (controller){
      var productsList = controller.productsList;
     return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey.shade100,
            title:TextField(
              controller: searchController,
              onChanged: (text) => search(text,productsList),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15,right: 15),
                hintText: 'بحث',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.clear,color: Colors.grey,),
                      onPressed: clearSearch,
                    ),
                    IconButton(
                      icon: Icon(Icons.search,color: kPrimaryColor,),
                      onPressed: () => search(searchController.text,productsList),
                    ),
                  ],
                ),
              ),
            ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: searchResults.isEmpty ?
          GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemCount: productsList.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(
                              product: productsList[index],
                              productId: productsList[index].id),
                    ),
                  );
                },
                child: productsList.isNotEmpty
                    ? ProductCard(
                  product:
                  productsList[index],
                  topMargin: 10,
                )
                    : const AppCard2(
                  topMargin: 10,
                ),
              );
            },
          )
              : GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemCount: searchResults.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(
                              product: searchResults[index],
                              productId: searchResults[index].id),
                    ),
                  );
                },
                child: searchResults.isNotEmpty
                    ? ProductCard(
                  product:
                  searchResults[index],
                  topMargin: 10,
                )
                    : const AppCard2(
                  topMargin: 10,
                ),
              );
            },
          )
        ),
      );
    });
  }
}
