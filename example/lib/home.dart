import 'package:flutter/material.dart';
import 'package:in_app_browser/in_app_browser.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InAppBrowser()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
