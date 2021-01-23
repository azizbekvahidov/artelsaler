import 'package:artel/globals.dart' as globals;
import 'package:artel/screen/login_screen.dart';
import 'package:artel/screen/main_profile.dart';
import 'package:artel/screen/main_screen.dart';
import 'package:artel/screen/news_screen.dart';
import 'package:artel/screen/report_screen.dart';
import 'package:artel/screen/shop_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:requests/requests.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home-page";
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<Map<String, dynamic>> getUser() async {
  //   if (globals.token != null) {
  //     var url = '${globals.api_link}/users/profile';
  //     // var request = HttpGet();
  //     var response = await Requests.get(url);

  //     globals.userData = response.json();
  //     return globals.userData;
  //   }
  // }

  final List<Widget> _children = [
    MainScreen(),
    ReportScreen(),
    ShopScreen(),
    MainProfile(),
  ];
  List<Color> _colors = [
    Colors.black,
    Color(0xff153E90),
    Color(0xff153E90),
    Color(0xff153E90),
  ];
  Widget _page = MainScreen();
  int _currentIndex = 0;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // getUser();
  }

  customDialog(BuildContext context) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: Container(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,

        onTap: (index) {
          // if (index == 1) {
          //   if (globals.token == null) {
          //     customDialog(context);
          //   } else {
          //     setState(() {
          //       _colors[0] = Colors.black;
          //       _colors[1] = Colors.black;
          //       _colors[2] = Colors.black;
          //       _colors[3] = Colors.black;
          //       _page = _children[index];
          //       _colors[index] = Theme.of(context).primaryColor;
          //     });
          //     navigatorKey.currentState
          //         .popUntil((route) => route.isFirst);
          //     _currentIndex = index;
          //   }
          // } else {
          setState(() {
            _colors[0] = Colors.black;
            _colors[1] = Colors.black;
            _colors[2] = Colors.black;
            _colors[3] = Colors.black;
            _colors[4] = Colors.black;
            _page = _children[index];
            _colors[index] = Theme.of(context).primaryColor;
          });
          navigatorKey.currentState.popUntil((route) => route.isFirst);
          _currentIndex = index;
        },
        // },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // inactiveColor: Color(0xffFF8F27),
            // activeColor: Theme.of(context).primaryColor,
            title: Text(
              "Главная",
              textAlign: TextAlign.center,
            ),
            icon: SvgPicture.asset(
              "assets/img/home.svg",
              color: _colors[0],
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
            // inactiveColor: Color(0xffFF8F27),
            // activeColor: Theme.of(context).primaryColor,
            title: Text(
              "Отчет",
              textAlign: TextAlign.center,
            ),
            icon: SvgPicture.asset(
              "assets/img/report.svg",
              color: _colors[1],
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
            // activeColor: Theme.of(context).primaryColor,
            title: Text(
              "Новости",
              textAlign: TextAlign.center,
            ),
            icon: SvgPicture.asset(
              "assets/img/news.svg",
              color: _colors[2],
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
            // activeColor: Theme.of(context).primaryColor,
            title: Text(
              "Магазин",
              textAlign: TextAlign.center,
            ),
            icon: SvgPicture.asset(
              "assets/img/shop.svg",
              color: _colors[3],
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
            // activeColor: Theme.of(context).primaryColor,
            title: Text(
              "Профиль",
              textAlign: TextAlign.center,
            ),
            icon: SvgPicture.asset(
              "assets/img/profile.svg",
              color: _colors[4],
              height: 25,
            ),
          ),
        ],
        // selectedIndex: _currentIndex,
        currentIndex: _currentIndex,
      ),*/

      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            inactiveColor: Color(0xffFF8F27),
            activeColor: Color(0xffFFFAA4),
            title: Text(
              'Главная',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            icon: SvgPicture.asset("assets/img/home.svg", color: _colors[0]),
          ),
          BottomNavyBarItem(
            activeColor: Color(0xffFFFAA4),
            title: Text(
              'Отчет',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            icon: SvgPicture.asset("assets/img/report.svg", color: _colors[1]),
          ),
          BottomNavyBarItem(
            activeColor: Color(0xffFFFAA4),
            title: Text(
              'Магазин',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            icon: SvgPicture.asset("assets/img/basket.svg", color: _colors[2]),
          ),
          BottomNavyBarItem(
            activeColor: Color(0xffFFFAA4),
            title: Text(
              'Профиль',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            icon: SvgPicture.asset("assets/img/profile.svg", color: _colors[3]),
          ),
        ],
        onItemSelected: (index) {
          if (index != 0) {
            if (globals.token == null) {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return LoginScreen();
                  },
                ),
                // ModalRoute.withName(HomePage.routeName),
              );
            } else {
              setState(() {
                _colors[0] = Color(0xff153E90);
                _colors[1] = Color(0xff153E90);
                _colors[2] = Color(0xff153E90);
                _colors[3] = Color(0xff153E90);

                _page = _children[index];
                _colors[index] = Colors.black;
              });
              navigatorKey.currentState.popUntil((route) => route.isFirst);
              _currentIndex = index;
            }
          } else {
            setState(() {
              _colors[0] = Color(0xff153E90);
              _colors[1] = Color(0xff153E90);
              _colors[2] = Color(0xff153E90);
              _colors[3] = Color(0xff153E90);

              _page = _children[index];
              _colors[index] = Colors.black;
            });
            navigatorKey.currentState.popUntil((route) => route.isFirst);
            _currentIndex = index;
          }
        },
        selectedIndex: _currentIndex,
      ),
      body: CustomNavigator(
        navigatorKey: navigatorKey,
        home: _page,
        pageRoute: PageRoutes.materialPageRoute,
      ),
    );
  }
}
