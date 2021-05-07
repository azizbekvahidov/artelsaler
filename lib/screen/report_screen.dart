import 'package:artel/screen/widget/custom_appBar.dart';
import 'package:artel/screen/widget/month_picker.dart';
import 'package:flutter/material.dart';
import 'package:artel/globals.dart' as globals;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:date_time_picker/date_time_picker.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime _firstDate;
  DateTime _lastDate;
  String _selectedDate;
  TextEditingController control = TextEditingController();
  Color selectedDateStyleColor;
  Color selectedSingleDateDecorationColor;
  String _url;
  DateFormat formatter = DateFormat("M.yyyy");
  WebViewController wbController;

  selectedDate(val) {
    _selectedDate = formatter.format(new DateFormat("yyyy-MM-dd").parse(val));
    _url =
        "${globals.api_link}/action/getUserReport?userId=${globals.userData["userId"]}&month=$_selectedDate";
    wbController.loadUrl(_url);
    // wbController?.reload();
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = formatter.format(DateTime.now());
    _url =
        "${globals.api_link}/action/getUserReport?userId=${globals.userData["userId"]}&month=$_selectedDate";
    // wbController.loadUrl(_url);
  }

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    var appbar = CustomAppBar(
      title: "Отчет",
      centerTitle: true,
    );
    return Scaffold(
      appBar: appbar,
      body: Container(
        height: dHeight - appbar.preferredSize.height - 150,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              DateTimePicker(
                dateMask: 'M.yyyy',
                locale: Locale("ru", "RU"),
                textAlign: TextAlign.center,
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Месяц',
                onChanged: (val) => {selectedDate(val)},
                validator: (val) {
                  return null;
                },
                onSaved: (val) {
                  print(val);
                },
              ),
              Container(
                height: dHeight + 150,
                child: WebView(
                  onWebViewCreated: (WebViewController controller) {
                    wbController = controller;
                    wbController.loadUrl(_url);
                  },
                  // debuggingEnabled: true,
                  // initialUrl: _url,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
