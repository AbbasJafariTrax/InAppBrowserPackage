import 'package:flutter/material.dart';
import 'package:browse_in/in_app_browser.dart';
import 'dart:async';

import 'package:in_app_browser_example/home.dart';

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
        addBookmarkIcon: Icons.bookmark_outline,
        removeBookmarkIcon: Icons.bookmark,
        appBarColor: Color(0xFF262626),
        backIcon: Icons.arrow_back_ios,
        nextIcon: Icons.arrow_forward_ios,
        bottomNavColor: Color(0xFF262626),
        closeIcon: Icons.close,
        historyCloseIcon: Icons.close,
        historyCloseIconColor: Colors.white,
        historyIcon: Icons.history,
        refreshIcon: Icons.refresh,
        historyTitle: "ذخیره شده ها",
        shareIcon: Icons.share,
        historyDialogSize: 600,
      ),
    );
  }
}
