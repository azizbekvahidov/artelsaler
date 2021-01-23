import 'dart:ui';

import 'package:artel/screen/home_page.dart';
import 'package:artel/screen/widget/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:artel/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class MainProfile extends StatefulWidget {
  MainProfile({Key key}) : super(key: key);

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  addStringToSF(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  @override
  Widget build(BuildContext context) {
    var dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Профиль",
        centerTitle: true,
        actionImg: "assets/img/logout.svg",
        actionFunc: () {
          globals.token = null;
          globals.userData = null;
          globals.login = null;

          addStringToSF("userToken", null);
          addStringToSF("login", null);
          addStringToSF("userData", null);
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              HomePage.routeName, (Route<dynamic> route) => false);
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Имя",
                      style: TextStyle(
                        fontSize: dWidth * globals.fontSize12,
                        color: Color(0xff66676C),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      globals.login,
                      style: TextStyle(
                        fontFeatures: [
                          FontFeature.enable("pnum"),
                          FontFeature.enable("lnum")
                        ],
                        fontSize: dWidth * globals.fontSize18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Точка",
                      style: TextStyle(
                        fontSize: dWidth * globals.fontSize12,
                        color: Color(0xff66676C),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      globals.userData["point"],
                      style: TextStyle(
                        fontFeatures: [
                          FontFeature.enable("pnum"),
                          FontFeature.enable("lnum")
                        ],
                        fontSize: dWidth * globals.fontSize18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Divider(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
