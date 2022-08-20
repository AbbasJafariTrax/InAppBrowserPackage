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
      home: InAppBrowser(
        "https://www.google.com/",
        mDirection: TextDirection.ltr,
        appBarBGColor: Color(0xFF262626),
        // backIcon: Icons.arrow_back_ios,
        // nextIcon: Icons.arrow_forward_ios,
        bottomNavColor: Color(0xFF262626),
        // closeIcon: Icons.close,
        // refreshIcon: Icons.refresh,
        // shareIcon: Icons.share,
        showAppBar: true,
      ),
    );
  }
}
