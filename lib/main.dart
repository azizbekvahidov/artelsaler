import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:artel/screen/home_page.dart';
import 'package:artel/screen/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const periodicTask = "periodicTask";
const simpleTaskKey = "simpleTask";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(EasyLocalization(
    child: MyApp(),
    path: "lang",
    saveLocale: true,
    supportedLocales: [
      Locale('uz', 'UZ'),
      Locale('ru', 'RU'),
      Locale('en', 'US'),
    ],
  ));
}

class MyApp extends StatelessWidget {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String token = prefs.getString('userToken');
    String login = prefs.getString('login');
    String userData = prefs.getString('userData');
    // setState(() {
    if (token != null) globals.token = token;
    if (login != null) globals.login = login;
    if (userData != null) globals.userData = json.decode(userData);

    // });
  }

  @override
  Widget build(BuildContext context) {
    getStringValuesSF();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Artel Saler',
      theme: ThemeData(
        primaryColor: Color(0xff153E90),
        fontFamily: 'Gilroy',
        appBarTheme: AppBarTheme(
          elevation: 2,
          color: Colors.white,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              title: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontFeatures: [
                  FontFeature.enable("pnum"),
                  FontFeature.enable("lnum")
                ],
              ),
              display1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Color(0xffB2B7D0),
                fontFeatures: [
                  FontFeature.enable("pnum"),
                  FontFeature.enable("lnum")
                ],
              ),
              display2: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff313B6C),
                fontFeatures: [
                  FontFeature.enable("pnum"),
                  FontFeature.enable("lnum")
                ],
              ),

              button: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFeatures: [
                  FontFeature.enable("pnum"),
                  FontFeature.enable("lnum")
                ],
              ),
            ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
      },
    );
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print("data is $data");
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print("notification is $notification");
  }

  // Or do other work.
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _title = "Title";
  String _helper = "helper";
  String _login = null;
  String _token = null;
  String _country = null;
  Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return //Navigator.pushReplacementNamed(context, LoginScreen.routeName)
        HomePage();
    //Navigator.pushReplacementNamed(context, HomePage.routeName);
  }
}
