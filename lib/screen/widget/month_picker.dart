import 'package:flutter/material.dart';

import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class MonthPickerPage extends StatefulWidget {
  MonthPickerPage({Key key}) : super(key: key);

  @override
  _MonthPickerPageState createState() => _MonthPickerPageState();
}

class _MonthPickerPageState extends State<MonthPickerPage> {
  DateTime _firstDate;
  DateTime _lastDate;
  DateTime _selectedDate;

  Color selectedDateStyleColor;
  Color selectedSingleDateDecorationColor;

  @override
  void initState() {
    super.initState();

    _firstDate = DateTime.now().subtract(Duration(days: 350));
    _lastDate = DateTime.now().add(Duration(days: 350));

    _selectedDate = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedDateStyleColor = Colors.white;
    selectedSingleDateDecorationColor = Color(0xff778BEB);
  }

  @override
  Widget build(BuildContext context) {
    // add selected colors to default settings
    dp.DatePickerStyles styles = dp.DatePickerStyles(
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: selectedDateStyleColor),
        selectedSingleDateDecoration: BoxDecoration(
            color: selectedSingleDateDecorationColor, shape: BoxShape.circle));

    return Container(
        // child: dp.MonthPicker(
        //   selectedDate: _selectedDate,
        //   onChanged: _onSelectedDateChanged,
        //   firstDate: _firstDate,
        //   lastDate: _lastDate,
        //   datePickerStyles: styles,
        // ),
        );
  }
}
