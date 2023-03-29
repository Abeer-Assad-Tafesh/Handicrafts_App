import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/widgets/all_appBar.dart';

class MostRated extends StatefulWidget {
  const MostRated({Key? key}) : super(key: key);

  @override
  State<MostRated> createState() => _MostRatedState();
}

class _MostRatedState extends State<MostRated> {
  Color _favoriteColor = Colors.white;
  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AllAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 749,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: myProducts.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        elevation: 4,
                        // margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/register.svg'),
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
                                  icon: Icon(
                                    Icons.favorite_rounded,
                                    color: _favoriteColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_favoriteColor == Colors.white) {
                                        _favoriteColor = Colors.red.shade900;
                                      } else {
                                        _favoriteColor = Colors.white;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
