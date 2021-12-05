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
      MaterialPageRoute(
        builder: (context) => InAppBrowser(
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
          historyCloseIconColor: Colors.black,
          historyIcon: Icons.history,
          refreshIcon: Icons.refresh,
          historyTitle: "تاریخچه جستجو",
          shareIcon: Icons.share,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
