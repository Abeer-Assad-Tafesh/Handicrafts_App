import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/timeline.dart';

class AllOrdersPage extends StatefulWidget {
   List<String> items;
   String selectedOption;

   AllOrdersPage({
    Key? key,
    required this.items,
    required this.selectedOption,
  }) : super(key: key);

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: Offset(-3, 3)),
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: Offset(1, -1)),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                  text: '20.Dec,2022',
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                SmallText(
                                  text: '2:15 Am',
                                  color: Colors.grey,
                                  size: 12,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/request_details_page');
                                  },
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: SvgPicture.asset(
                                          'assets/icons/red_info_circle.svg')),
                                ),
                                SmallText(
                                  text: 'ID: 276332',
                                  size: 18,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                                text: widget.items[1], color: kPrimaryColor, size: 10),
                            SmallText(
                                text: widget.items[2], color: kPrimaryColor, size: 10),
                            SmallText(
                                text: widget.items[3], color: kPrimaryColor, size: 10),
                            SmallText(
                                text: widget.items[4], color: kPrimaryColor, size: 10),
                          ],
                        ),
                      ),
                      DeliveryTimeline(
                          currentStep: widget.items.indexOf(widget.selectedOption) - 1),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Image.asset(
                                            'assets/images/product5.png',
                                            fit: BoxFit.fill,
                                            height: 90,
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BigText(
                                              text: 'اسم المنتج',
                                              size: 18,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/calendar.svg",
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  'يومين عمل',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 100,
                                          alignment: Alignment.center,
                                          color: kSecondaryColor,
                                          child: BigText(text: '20\$'),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topRight,
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  width: 180,
                                  alignment: Alignment.center,
                                  child: DropdownButtonFormField<String>(
                                    value: widget.selectedOption,
                                    iconSize: 35,
                                    icon: Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color: kPrimaryColor,
                                    ),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      contentPadding: EdgeInsets.only(right: 8),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        widget.selectedOption = newValue!;
                                      });
                                    },
                                    items: widget.items.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
