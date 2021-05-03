import 'package:flutter/material.dart';
import 'package:artel/globals.dart' as globals;
import 'package:webview_flutter/webview_flutter.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({Key key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    print('${globals.site_link}/action/shop?id=${globals.token}');
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: WebView(
        initialUrl: '${globals.site_link}/action/shop?id=${globals.token}',
      ),
    );
  }
}
