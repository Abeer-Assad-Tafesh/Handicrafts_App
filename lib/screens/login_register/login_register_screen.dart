import 'package:flutter/material.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/screens/login_register/buyer_login_page.dart';
import 'package:handcrafts/screens/login_register/buyer_register_page.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({Key? key}) : super(key: key);

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
                  margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
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
                          border: Border.all(color: kDefaultColor)),
                      tabs: [
                        Text(
                          'تسجيل الدخول',
                          style: TextStyle(color: kDefaultColor),
                        ),
                        Text(
                          'تسجيل',
                          style: TextStyle(color: kDefaultColor),
                        ),
                      ]),
                ),
                Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [BuyerLoginPage(), BuyerRegisterPage()],
                ))
              ],
            ),
            ]
        ),
      ),
    );
  }
}
