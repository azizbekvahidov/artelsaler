import 'package:artel/screen/login_screen.dart';
import 'package:artel/screen/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:artel/globals.dart' as globals;
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWeight = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff54E346),
        onPressed: () {
          if (globals.token != null)
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ScanPage();
            }));
          else
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LoginScreen();
                },
              ),
              // ModalRoute.withName(HomePage.routeName),
            );
        },
        child: SvgPicture.asset("assets/img/mobile_scan.svg"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xff153E90),
                      Color(0xff0E49B5),
                    ],
                  ),
                ),
                height: dHeight * 0.20,
                width: dWeight,
                padding: EdgeInsets.only(right: 20, bottom: 50, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: dWeight - 120,
                      child: Text(
                        "Привет, ${globals.login != null ? globals.login : ""}\nДобро пожаловать",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    globals.token != null
                        ? Container()
                        : InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return LoginScreen();
                                  },
                                ),
                                // ModalRoute.withName(HomePage.routeName),
                              );
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/img/user.svg",
                                height: 50,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                height: dHeight * 0.75,
              )
            ],
          ),
        ),
      ),
    );
  }
}
