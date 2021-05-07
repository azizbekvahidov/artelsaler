import 'package:artel/screen/login_screen.dart';
import 'package:artel/screen/news_screen.dart';
import 'package:artel/screen/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:artel/globals.dart' as globals;
import 'package:flutter_svg/svg.dart';
import 'package:requests/requests.dart';
import 'package:skeleton_text/skeleton_text.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<dynamic> _news;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _news = getNews();
  }

  Future getNews() async {
    try {
      var url = '${globals.api_link}/api/getNews';

      // Map<String, String> headers = {"Authorization": "token ${globals.token}"};

      var response = await Requests.get(url);

      var reply = response.json();
      return reply;
    } catch (e) {
      print("news => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWeight = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff54E346),
        onPressed: () {
          if (globals.token != null)
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ScanPage();
            }));
          else
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LoginScreen();
                },
              ),
              // ModalRoute.withName(HomePage.routeName),
            );
        },
        child: SvgPicture.asset("assets/img/mobile_scan.svg"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xff153E90),
                      Color(0xff0E49B5),
                    ],
                  ),
                ),
                height: dHeight * 0.20,
                width: dWeight,
                padding: EdgeInsets.only(right: 20, bottom: 50, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: dWeight - 120,
                      child: Text(
                        "Привет, ${globals.login != null ? globals.login : ""}\nДобро пожаловать",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    globals.token != null
                        ? Container()
                        : InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return LoginScreen();
                                  },
                                ),
                                // ModalRoute.withName(HomePage.routeName),
                              );
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/img/user.svg",
                                height: 50,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: dHeight * 0.75,
                  child: FutureBuilder(
                    future: _news,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (content, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return NewsScreen(
                                        data: snapshot.data[index],
                                      );
                                    }));
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 90,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Image.network(
                                                      "${globals.api_link}/upload/news/${snapshot.data[index]["foto"]}"),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  top: 10,
                                                  bottom: 10),
                                              width: dWeight - 140,
                                              height: 110,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      snapshot.data[index]
                                                          ["header"],
                                                      style: TextStyle(
                                                          fontSize: dWeight *
                                                              globals
                                                                  .fontSize20),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot.data[index]
                                                            ["newsDate"]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (BuildContext ctx, index) {
                                // print(_list);
                                return SkeletonAnimation(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 110,
                                        color: Color.fromRGBO(49, 59, 108, 0.1),
                                        width: dWeight - 40,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                );
                              },
                            );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
