import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:artel/globals.dart' as globals;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color backgroundColor;
  final Color textColor;
  final String actionImg;
  final Function actionFunc;
  CustomAppBar(
      {this.title,
      this.centerTitle,
      this.backgroundColor,
      this.textColor,
      this.actionImg,
      this.actionFunc,
      Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: widget.backgroundColor ?? Color.fromRGBO(0, 0, 0, 0.03),
          offset: Offset(4, 6),
          blurRadius: 10.0,
        )
      ]),
      child: AppBar(
        actions: [
          widget.actionImg != null
              ? Container(
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: widget.actionFunc,
                      child: SvgPicture.asset(widget.actionImg)),
                )
              : Container(),
        ],
        backgroundColor: widget.backgroundColor ?? Colors.white,
        centerTitle: widget.centerTitle,
        iconTheme: IconThemeData(color: widget.textColor),
        elevation: 0.0,
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .display2
              .apply(color: widget.textColor)
              .copyWith(
                  fontSize:
                      MediaQuery.of(context).size.width * globals.fontSize20),
        ),
      ),
    );
  }
}
