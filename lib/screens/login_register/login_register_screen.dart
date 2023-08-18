import 'package:flutter/material.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/screens/login_register/buyer_login_page.dart';
import 'package:handcrafts/screens/login_register/buyer_register_page.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({
    Key? key,
    this.page1 = 0,
    this.page2 = 1
  }) : super(key: key);

  final int page1;
  final int page2;

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  BuyerLoginPage? loginPage ;
  BuyerRegisterPage? registerPage ;

  List pages = [
    BuyerLoginPage(),
    BuyerRegisterPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset('assets/images/bg_screens.png', width: double.infinity,fit: BoxFit.cover),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  height: 65,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(40),
                  ),

                  child: TabBar(
                      controller: _tabController,
                      onTap: (int selectedTabIndex) {},
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(color: kPrimaryColor)),
                      tabs: [
                        Text(
                          'تسجيل الدخول',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        Text(
                          'تسجيل',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ]),
                ),
                Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [pages[widget.page1], pages[widget.page2]],
                ))
              ],
            ),
            ]
        ),
      ),
    );
  }
}
