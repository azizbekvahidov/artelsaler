import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:artel/globals.dart' as globals;

class NewsScreen extends StatefulWidget {
  NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: WebView(
        initialUrl: '${globals.site_link}/action/news',
      ),
    );
  }
}
