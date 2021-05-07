import 'package:artel/helper.dart';
import 'package:artel/screen/qr_scan.dart';
import 'package:artel/screen/report_screen.dart';
import 'package:artel/screen/user_form.dart';
import 'package:artel/screen/widget/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:artel/globals.dart' as globals;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:requests/requests.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Helper helpers = new Helper();
  final MaskedTextController phoneController = MaskedTextController(
      mask: '00 000 00 00', translator: {"0": RegExp(r'[0-9]')});
  TextEditingController fioController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  var result = null;
  getQR(BuildContext context) async {
    var resultScan = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return QRScan();
    }));
    if (resultScan != null) {
      var url = '${globals.api_link}/action/scan';

      // Map<String, String> headers = {"Authorization": "token ${globals.token}"};

      var response = await Requests.post(url,
          body: {"sn": resultScan.code, "userId": globals.userData["userId"]});

      result = response.json();
      setState(() {});
    }
  }

  cancel() {
    result = null;
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  customDialog(BuildContext context) {
    phoneController.text = "";
    fioController.text = "";
    addressController.text = "";
    var dWidth = MediaQuery.of(context).size.width;
    final node = FocusScope.of(context);
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
            heightFactor: 10.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: Scaffold(
                resizeToAvoidBottomPadding: false,
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Text(
                          "Данные клиента",
                          style:
                              TextStyle(fontSize: dWidth * globals.fontSize22),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextField(
                                  autofocus: true,
                                  controller: fioController,
                                  decoration: InputDecoration(hintText: 'ФИО'),
                                  onEditingComplete: () => node.nextFocus()),
                              TextField(
                                  controller: addressController,
                                  decoration:
                                      InputDecoration(hintText: 'Адрес'),
                                  onEditingComplete: () => node.nextFocus()),
                              TextField(
                                  autocorrect: false,
                                  // focusNode: widget.textFocusNode,
                                  // inputFormatters: [maskFormatter],
                                  controller: phoneController,
                                  onChanged: (v) {
                                    // print(v);
                                  },
                                  maxLines: 1,
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      InputDecoration(hintText: 'Телефон'),
                                  onEditingComplete: () => node.nextFocus()),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: dWidth * 0.1),
                          child: InkWell(
                            onTap: () {
                              sell();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green,
                              ),
                              child: Text(
                                "Сохранить",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: dWidth * globals.fontSize22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  sell() async {
    var url = '${globals.api_link}/action/addSell';

    Map<String, String> body = {
      "phone": "+998${phoneController.text}",
      "address": addressController.text,
      "name": fioController.text,
      "userId": globals.userData["userId"],
      "snNum": result["sn"],
      "printId": result["printId"]
    };

    var response = await Requests.post(url, body: body);

    if (response.statusCode == 200) {
      var res = response.json();
      if (res["success"] == false) {
        helpers.getToast("Что то пошло не так. Попробуйте по позже", context);
      } else if (res["success"] == true) {
        cancel();
      } else if (res["success"] == "sell") {
        helpers.getToast("Телефон уже продан", context);
        cancel();
      }
      print(res);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var dWeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Продажа",
        centerTitle: true,
        actionFunc: () async {
          getQR(context);
        },
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
            ),
            result != null && result["success"]
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Text(
                          "Модель: ${result["phone"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: dWeight * globals.fontSize20,
                          ),
                        ),
                        Divider(),
                        Text(
                          "SN: ${result["sn"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: dWeight * globals.fontSize20,
                          ),
                        ),
                        Divider(),
                        Text(
                          "IMEI1: ${result["imei1"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: dWeight * globals.fontSize20,
                          ),
                        ),
                        Divider(),
                        Text(
                          "IMEI2: ${result["imei2"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: dWeight * globals.fontSize20,
                          ),
                        ),
                        Divider(),
                        Text(
                          "Дата выпуска: ${result["date"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: dWeight * globals.fontSize20,
                          ),
                        ),
                        Divider(),
                        Text(
                          "Статус: ${result["status"] == "0" ? "Не продано" : "Продано"}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: dWeight * globals.fontSize20,
                          ),
                        ),
                        result["status"] == "0"
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cancel();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          "Отмена",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                dWeight * globals.fontSize22,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        customDialog(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.green,
                                        ),
                                        child: Text(
                                          "Продать",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                dWeight * globals.fontSize22,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(vertical: 50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cancel();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          "Очистить",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                dWeight * globals.fontSize22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
