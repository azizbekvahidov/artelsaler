import 'package:artel/screen/widget/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:artel/globals.dart' as globals;

class NewsScreen extends StatefulWidget {
  Map<String, dynamic> data;
  NewsScreen({this.data, Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    var dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Новости",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(widget.data["header"],
                    style: TextStyle(fontSize: dWidth * globals.fontSize26)),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: ClipRRect(
                  child: Image.network(
                      "${globals.api_link}/upload/news/${widget.data["foto"]}"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(widget.data["content"]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
