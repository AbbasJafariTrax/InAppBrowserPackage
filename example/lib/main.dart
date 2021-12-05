import 'package:flutter/material.dart';
import 'package:in_app_browser/in_app_browser.dart';
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

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     platformVersion = await InAppBrowser.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

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
      // home: InAppBrowser.launchUrl(
      //   url: "https://www.google.com/",
      //   contextParam: context,
      //   paddingRight: 5.0,
      // ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Plugin example app'),
      //   ),
      //   body: Center(
      //     child: InAppBrowser.launchUrl(
      //       url: "https://www.google.com/",
      //       context: context,
      //     ),
      //   ),
      // ),
    );
  }
}
