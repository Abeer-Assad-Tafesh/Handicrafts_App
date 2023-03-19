import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/out_boarding_content.dart';

class OutBoardingScreen extends StatefulWidget {
  const OutBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OutBoardingScreen> createState() => _OutBoardingScreenState();
}

class _OutBoardingScreenState extends State<OutBoardingScreen> {
  late PageController _pageController;
  late int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_splash.png', width: double.infinity,fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/basic_screens');
                    },
                    child: Text('تخطي',
                      style: TextStyle(color: kDefaultColor,),),
                  ),
                ),
                const SizedBox(height: 80,),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                      minHeight: 0,
                      minWidth: 0,
                      maxHeight: 500,
                      maxWidth: double.infinity),
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    children: [
                      OutBoardingContent(currentPage:_currentPage,image:'assets/images/ob1.svg',title: 'شاهد',describe: 'شاهد منتجات الحرفيين المميزة\n أفضل الحرفيين لدينا'),
                      OutBoardingContent(currentPage:_currentPage,image:'assets/images/ob2.svg',title: 'تسوق',describe: 'تسوق الان بكل سهولة\n وتابع تقييمات الزبائن'),
                      OutBoardingContent(currentPage:_currentPage,image:'assets/images/ob3.svg',title: 'ابحث',describe: 'ابحث عن المنتجات بكل سهولة\n وشاهد اخر اعمال الحرفيين'),
                      OutBoardingContent(currentPage:_currentPage,image:'assets/images/ob4.svg',title: 'احصل الآن',describe: 'احصل الان على افضل الأسعار\n وتابع طلباتك'),
                      ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: _currentPage > 0,
                      maintainAnimation: true,
                      maintainState: true,
                      maintainSize: true,
                      child: IconButton(
                        onPressed: () {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
/*                    InkWell(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/login_register_screen');
                      },
                      child: Text(
                        'تسجيل دخول',
                        style: TextStyle(
                            color: kDefaultColor,
                            fontSize: 18,
                            decoration: TextDecoration.underline),
                      ),
                    ),*/
                    IconButton(
                      onPressed: () {
                        if(_currentPage == 3){
                          Navigator.pushReplacementNamed(context, '/basic_screens');
                        }else{
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);}
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

