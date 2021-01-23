import 'package:artel/screen/report_screen.dart';
import 'package:artel/screen/widget/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:artel/globals.dart' as globals;

class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    var dWeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Продажа",
        centerTitle: true,
        actionFunc: () {},
        actionImg: "assets/img/qr_scan.svg",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Инфо о телефоне",
                  style: TextStyle(
                    fontSize: dWeight * globals.fontSize24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ReportScreen();
                    }));
                  },
                  child: Text(
                    "Отчет",
                    style: TextStyle(
                        color: Color(0xff0E49B5),
                        fontSize: dWeight * globals.fontSize16,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
