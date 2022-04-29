import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:in_app_browser/MyManagement/HistoryStorage.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

class InAppBrowser extends StatefulWidget {
  String mUrl;
  final TextDirection mDirection;
  final IconData backIcon,
      nextIcon,
      shareIcon,
      historyIcon,
      refreshIcon,
      addBookmarkIcon,
      removeBookmarkIcon,
      closeIcon,
      historyCloseIcon;

  final Color appBarColor,
      bottomNavColor,
      backIconColor,
      nextIconColor,
      shareIconColor,
      historyIconColor,
      refreshIconColor,
      addBookmarkIconColor,
      removeBookmarkIconColor,
      closeIconColor,
      historyCloseIconColor;

  final bool showAppName;
  final String appName;
  final String historyTitle;
  final double appbarTxtSize;
  final FontWeight appbarFontWeight;
  double historyDialogSize;

  InAppBrowser(
    this.mUrl, {
    Key key,
    this.mDirection = TextDirection.ltr,
    this.backIcon,
    this.nextIcon,
    this.shareIcon,
    this.historyIcon,
    this.refreshIcon,
    this.closeIcon,
    this.appBarColor = Colors.white,
    this.bottomNavColor = Colors.white,
    this.backIconColor = Colors.white,
    this.nextIconColor = Colors.white,
    this.shareIconColor = Colors.white,
    this.historyIconColor = Colors.white,
    this.refreshIconColor = Colors.white,
    this.closeIconColor = Colors.white,
    this.showAppName = false,
    this.appName,
    this.addBookmarkIcon,
    this.removeBookmarkIcon,
    this.addBookmarkIconColor = Colors.white,
    this.removeBookmarkIconColor = Colors.white,
    this.historyCloseIcon,
    this.historyTitle,
    this.historyCloseIconColor = Colors.white,
    this.appbarTxtSize = 15,
    this.appbarFontWeight = FontWeight.bold,
    this.historyDialogSize = 200,
  }) : super(key: key);

  @override
  _InAppBrowserState createState() => _InAppBrowserState();
}

class _InAppBrowserState extends State<InAppBrowser>
    with TickerProviderStateMixin {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  SharedPreferences prefs;

  List<Map<dynamic, dynamic>> _myList = [];
  bool isLoading = true;
  bool showDialog = false;
  bool isDialogFull = false;
  double tempHistoryDialogSize = 0;

  static Widget iconInkWell({Function func, IconData mIcon, Color iconColor}) {
    return InkWell(
      onTap: func,
      child: mIcon == null ? SizedBox.shrink() : Icon(mIcon, color: iconColor),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tempHistoryDialogSize = widget.historyDialogSize;

    flutterWebViewPlugin.onUrlChanged.forEach((element) {
      widget.mUrl = element;
      setState(() {});
    });

    Future.delayed(Duration.zero, () {
      isLoading = false;
      initailSP();
    });
  }

  void initailSP() async {
    prefs = await SharedPreferences.getInstance();
    List<String> mKeys = prefs.getKeys().toList();

    if (mKeys.isNotEmpty)
      mKeys.forEach((key) {
        if (key.contains("URL: ")) {
          String value = prefs.getString(key);
          _myList.add({
            "title": value.substring(0, value.indexOf(",")),
            "url": key.substring(5, key.length),
            "time": value.substring(value.indexOf(",") + 2, value.length),
          });
        }
      });

    _myList.forEach((element) {
    });

    setState(() {});
  }

  void mDispose() {
    if (showDialog) {
      showDialog = false;
      isDialogFull = false;
      widget.historyDialogSize = tempHistoryDialogSize;
      setState(() {});
    } else {
      flutterWebViewPlugin.dispose();
      flutterWebViewPlugin.hide();

      Future.delayed(Duration(microseconds: 10), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox.shrink()
        : WillPopScope(
            onWillPop: () {
              mDispose();
            },
            child: Directionality(
              textDirection: widget.mDirection,
              child: WebviewScaffold(
                appBar: isDialogFull
                    ? null
                    : AppBar(
                        backgroundColor: widget.appBarColor,
                        title: Text(
                          widget.showAppName ? widget.appName : widget.mUrl,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: widget.appbarFontWeight,
                            fontSize: widget.appbarTxtSize,
                          ),
                        ),
                        leading: widget.closeIcon == null
                            ? SizedBox.shrink()
                            : InkWell(
                                child: Icon(
                                  widget.closeIcon,
                                  color: widget.closeIconColor,
                                ),
                                onTap: mDispose,
                              ),
                        actions: [
                          (widget.addBookmarkIcon == null ||
                                  widget.removeBookmarkIcon == null)
                              ? SizedBox.shrink()
                              : InkWell(
                                  child: _myList
                                          .where((element) =>
                                              element['url'] == widget.mUrl)
                                          .isNotEmpty
                                      ? Icon(
                                          widget.removeBookmarkIcon,
                                          color: widget.removeBookmarkIconColor,
                                        )
                                      : Icon(
                                          widget.addBookmarkIcon,
                                          color: widget.addBookmarkIconColor,
                                        ),
                                  onTap: () async {
                                    String value =
                                        prefs.getString("URL: ${widget.mUrl}");

                                    if (value == null) {
                                      String html = await flutterWebViewPlugin
                                          .evalJavascript(
                                              "window.document.getElementsByTagName('html')[0].outerHTML;");

                                      String title = "";
                                      if (html.contains("u003Ctitle>") &&
                                          html.contains("u003Ctitle>"))
                                        title = html.substring(
                                            html.indexOf("u003Ctitle>") + 11,
                                            html.indexOf("u003C/title>"));
                                      else
                                        title = "Your Url";

                                      HistoryItem historyItem = HistoryItem();

                                      historyItem.title = title;
                                      historyItem.url = widget.mUrl;
                                      historyItem.time =
                                          DateTime.now().millisecondsSinceEpoch;

                                      prefs.setString(
                                          "URL: " + historyItem.url,
                                          historyItem.title +
                                              ", " +
                                              "${historyItem.time}");

                                      _myList.add({
                                        "title": historyItem.url,
                                        "url": historyItem.url,
                                        "time": historyItem.time,
                                      });
                                    } else {

                                      prefs.remove("URL: " + widget.mUrl);

                                      _myList.removeWhere(
                                        (element) =>
                                            element["url"] == widget.mUrl,
                                      );
                                    }
                                    setState(() {});
                                  },
                                ),
                          SizedBox(width: 10),
                        ],
                      ),
                url: widget.mUrl,
                bottomNavigationBar: showDialog
                    ? Container(
                        height: widget.historyDialogSize,
                        decoration: BoxDecoration(
                          color: widget.bottomNavColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(isDialogFull ? 0 : 10),
                            topRight: Radius.circular(isDialogFull ? 0 : 10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            GestureDetector(
                              onPanUpdate: (details) {

                                double appbarSize =
                                    MediaQuery.of(context).size.height;

                                if (details.delta.dy < -3 &&
                                    widget.historyDialogSize != appbarSize) {
                                  widget.historyDialogSize = appbarSize;
                                  isDialogFull = true;
                                  setState(() {});
                                } else if (details.delta.dy > 3 && showDialog) {
                                  showDialog = false;
                                  isDialogFull = false;
                                  widget.historyDialogSize =
                                      tempHistoryDialogSize;

                                  setState(() {});
                                }
                              },
                              child: Text(
                                "━━",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                                top: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    child: InkWell(
                                      child: Text(
                                        "پاک کردن",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  Text(
                                    widget.historyTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  widget.historyCloseIconColor == null
                                      ? SizedBox.shrink()
                                      : Padding(
                                          padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          child: InkWell(
                                            child: Icon(
                                              widget.historyCloseIcon,
                                              color:
                                                  widget.historyCloseIconColor,
                                            ),
                                            onTap: () {
                                              showDialog = false;
                                              isDialogFull = false;
                                              widget.historyDialogSize =
                                                  tempHistoryDialogSize;

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.white),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _myList.length,
                                itemBuilder: (ctx, index) {
                                  int dayDB =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(
                                              "${_myList[index]["time"]}"))
                                          .day;
                                  int monthDB =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(
                                              "${_myList[index]["time"]}"))
                                          .month;
                                  return Row(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: Icon(
                                          Icons.link_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              "${_myList[index]["title"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              "${_myList[index]["url"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              "${months[monthDB - 1]} $dayDB",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 56,
                        child: Card(
                          color: widget.bottomNavColor,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              iconInkWell(
                                func: () {
                                  flutterWebViewPlugin
                                      .canGoBack()
                                      .then((value) {
                                    if (value) flutterWebViewPlugin.goBack();
                                  });
                                },
                                mIcon: widget.backIcon,
                                iconColor: widget.backIconColor,
                              ),
                              iconInkWell(
                                func: () {
                                  flutterWebViewPlugin
                                      .canGoForward()
                                      .then((value) {
                                    if (value) flutterWebViewPlugin.goForward();
                                  });
                                },
                                mIcon: widget.nextIcon,
                                iconColor: widget.nextIconColor,
                              ),
                              iconInkWell(
                                func: () {
                                  Share.share(widget.mUrl);
                                },
                                mIcon: widget.shareIcon,
                                iconColor: widget.shareIconColor,
                              ),
                              iconInkWell(
                                mIcon: widget.historyIcon,
                                iconColor: widget.historyIconColor,
                                func: () {
                                  showDialog = true;
                                  setState(() {});
                                },
                              ),
                              iconInkWell(
                                mIcon: widget.refreshIcon,
                                iconColor: widget.refreshIconColor,
                                func: () {
                                  flutterWebViewPlugin.reload();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          );
  }
}
