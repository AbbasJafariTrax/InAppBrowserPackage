import 'package:flutter/material.dart';
import 'package:browse_in/in_app_browser.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InAppWebView(
        "https://www.google.com/",
        mDirection: TextDirection.ltr,
        appBarBGColor: Color(0xFF262626),
        bottomNavColor: Color(0xFF262626),
        showAppTitle: true,
        backIcon: Icon(Icons.arrow_back_ios, color: Colors.white),
        nextIcon: Icon(Icons.arrow_forward_ios, color: Colors.white),
        closeIcon: Icon(Icons.close, color: Colors.white),
        shareIcon: Icon(Icons.share, color: Colors.white),
        refreshIcon: Icon(Icons.refresh, color: Colors.white),
        actionWidget: [],
        actionsIconTheme: IconThemeData(),
        centerTitle: true,
        titleTextStyle: TextStyle(),
        toolbarTextStyle: TextStyle(),
        toolbarHeight: 56,
      ),
    );
  }
}
