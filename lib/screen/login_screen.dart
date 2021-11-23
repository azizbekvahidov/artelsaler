import 'dart:convert';

import 'package:artel/screen/widget/default_button.dart';
import 'package:artel/screen/widget/input/default_input.dart';
import 'package:artel/screen/widget/input/pass_input.dart';
import 'package:artel/screen/widget/text/main_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import 'package:artel/globals.dart' as globals;

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:artel/screen/home_page.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-page";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  bool isLogin = false;
  void getLogin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userToken', null);
      String phone = phoneController.text;
      phone = phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      String pass = passController.text;
      var url = '${globals.site_link}/users/login';
      Map map = {
        "username": phone,
        "password": pass,
      };
      var response = await Requests.post(url,
          body: map, headers: {"Accept": "application/json"});
      // request.methodPost(map, url);
      if (response.statusCode == 200) {
        // Map<String,dynamic> reply = response.json();

        Map<String, dynamic> responseBody = response.json();
        addStringToSF("userToken", responseBody["userId"]);
        addStringToSF("login", responseBody["login"]);
        addStringToSF("userData", json.encode(responseBody));

        globals.token = responseBody["userId"];
        globals.login = responseBody["login"];
        globals.userData = responseBody;
        isLogin = true;
      } else {
        Map<String, dynamic> responseBody = response.json();
        Fluttertoast.showToast(
            msg: responseBody['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 15.0);
      }

      if (isLogin) Navigator.pushReplacementNamed(context, HomePage.routeName);
    } catch (e) {
      print(e);
    }
  }

  addStringToSF(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final dWith = mediaQuery.size.width;
    final dHeight = mediaQuery.size.height;
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: dHeight * 0.35, //mediaQuery.size.height,
                width: dWith * 0.6,
                child: Center(
                  child: Image.asset("assets/img/logo.png"),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText("Логин"),
                          DefaultInput(
                            hint: "Логин",
                            textController: phoneController,
                          ),
                          MainText("Пароль"),
                          PassInput("Пароль", passController),
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            child: DefaultButton("Войти", () {
                              getLogin();
                            }, Color(0xff153E90)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
