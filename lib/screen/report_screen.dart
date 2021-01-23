import 'package:artel/screen/widget/custom_appBar.dart';
import 'package:artel/screen/widget/month_picker.dart';
import 'package:flutter/material.dart';
import 'package:artel/globals.dart' as globals;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
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

  @override
  void initState() {
    super.initState();
    DateFormat formatter = DateFormat("M.yyyy");
    _selectedDate = formatter.format(DateTime.now());
    print(_selectedDate);
    _url =
        "${globals.api_link}/action/getUserReport?userId=${globals.userData["userId"]}&month=$_selectedDate";
  }

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var appbar = CustomAppBar(
      title: "Отчет",
      centerTitle: true,
    );
    return Scaffold(
      appBar: appbar,
      body: Container(
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
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              Container(
                color: Colors.transparent,
                height: dHeight - appbar.preferredSize.height - 150,
                child: WebView(
                  initialUrl: _url,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
