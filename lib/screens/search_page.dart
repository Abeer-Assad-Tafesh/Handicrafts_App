import 'package:flutter/material.dart';
import 'package:handcrafts/utils/constants.dart';

class Product {
  final String name;

  Product(this.name);
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Product> products = [
    Product('Product 1'),
    Product('Product 2'),
    Product('Product 3'),
  ];
  List<Product> searchResults = [];
  String searchText = '';

  void search(String text) {
    setState(() {
      searchText = text;
      searchResults = products
          .where((product) =>
          product.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
    print('Searching for: $searchText');
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      search('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: TextField(
          controller: searchController,
          onChanged: (text) => search(text),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15,right: 15),
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
                  onPressed: () => search(searchController.text),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults[index].name),
          );
        },
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';

  void search(String text) {
    setState(() {
      searchText = text;
    });
    // Perform the search operation based on the searchText value
    // Add your own search logic here
    print('Searching for: $searchText');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarDelegate(search),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Search Text: $searchText'),
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate<String> {
  final Function(String) searchCallback;

  SearchBarDelegate(this.searchCallback);

  @override
  String get searchFieldLabel => 'Search...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('No results found for "$query".'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // You can implement your own search suggestions logic here
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => ListTile(
        title: Text('Suggestion $index'),
        onTap: () {
          searchCallback('Suggestion $index');
          close(context, '');
        },
      ),
    );
  }
}

*/