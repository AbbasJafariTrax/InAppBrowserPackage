import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
// import 'package:webview_flutter/webview_flutter.dart';

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
  }) : super(key: key);

  @override
  _InAppBrowserState createState() => _InAppBrowserState();
}

class _InAppBrowserState extends State<InAppBrowser> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  List<String> _myList = [];
  bool isLoading = true;
  bool showDialog = false;

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

    flutterWebViewPlugin.onUrlChanged.forEach((element) {
      widget.mUrl = element;
      setState(() {});
    });

    Future.delayed(Duration.zero, () {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Directionality(
            textDirection: widget.mDirection,
            child: WebviewScaffold(
              appBar: AppBar(
                backgroundColor: widget.appBarColor,
                title: Text(
                  widget.showAppName ? widget.appName : widget.mUrl,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: widget.closeIcon == null
                    ? SizedBox.shrink()
                    : InkWell(
                        child: Icon(
                          widget.closeIcon,
                          color: widget.closeIconColor,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                actions: [
                  (widget.addBookmarkIcon == null ||
                          widget.removeBookmarkIcon == null)
                      ? SizedBox.shrink()
                      : InkWell(
                          child: _myList.contains(widget.mUrl)
                              ? Icon(
                                  widget.removeBookmarkIcon,
                                  color: widget.addBookmarkIconColor,
                                )
                              : Icon(
                                  widget.addBookmarkIcon,
                                  color: widget.removeBookmarkIconColor,
                                ),
                          onTap: () {
                            if (!_myList.contains(widget.mUrl)) {
                              _myList.add(widget.mUrl);
                            } else {
                              _myList.remove(widget.mUrl);
                            }
                            setState(() {});
                          },
                        ),
                  SizedBox(width: 10),
                ],
              ),
              url: "https://www.google.com/",
              bottomNavigationBar: showDialog
                  ? Container(
                      height: 150,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.close, color: Colors.transparent),
                              Text(
                                "نتایج جستجو شما",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              widget.historyCloseIconColor == null
                                  ? SizedBox.shrink()
                                  : InkWell(
                                      child: Icon(
                                        widget.historyCloseIcon,
                                        color: widget.historyCloseIconColor,
                                      ),
                                      onTap: () {
                                        showDialog = false;
                                        setState(() {});
                                      },
                                    ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _myList.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: Text("${_myList[index]}"),
                                    onTap: () {
                                      flutterWebViewPlugin
                                          .reloadUrl(_myList[index]);
                                    },
                                  ),
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
                                flutterWebViewPlugin.canGoBack().then((value) {
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
          );
  }
}

// static WebViewController _webViewController;

// final Completer<WebViewController> _controller =
//     Completer<WebViewController>();

// static const MethodChannel _channel = const MethodChannel('in_app_browser');
//
// static Future<String> get platformVersion async {
//   final String version = await _channel.invokeMethod('getPlatformVersion');
//   return version;
// }

// static String myUrl = "";
// static List<String> _myList = [];
// final flutterWebViewPlugin = FlutterWebviewPlugin();
//
// final Set<JavascriptChannel> jsChannels = [
//   JavascriptChannel(
//       name: 'Print',
//       onMessageReceived: (JavascriptMessage message) {
//         print(message.message);
//       }),
// ].toSet();
//
// static Widget launchUrl({
//   @required String url,
//   @required BuildContext contextParam,
//   @required paddingRight,
// }) {
//   myUrl = url;
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(myUrl),
//       leading: InkWell(
//         child: Icon(Icons.close),
//         onTap: () {
//           Navigator.pop(contextParam);
//         },
//       ),
//       actions: [
//         InkWell(
//           child: Icon(Icons.bookmark_outline_sharp),
//           onTap: () {
//             // _webViewController.currentUrl().then((value) {
//             //   if (!_myList.contains(value)) {
//             //     _myList.add(value);
//             //   }
//             // });
//           },
//         ),
//         SizedBox(width: paddingRight),
//       ],
//     ),
//     body: WebviewScaffold(
//       url: myUrl,
//       javascriptChannels: jsChannels,
//       // onWebViewCreated: (WebViewController webCtrl) async {
//       //   myUrl = await webCtrl.currentUrl();
//       //   _webViewController = webCtrl;
//       // },
//     ),
//     bottomNavigationBar: SizedBox(
//       height: 56,
//       child: Card(
//         color: Colors.blue,
//         margin: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(0),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             iconInkWell(
//               func: () {
//                 // _webViewController.canGoBack().then((value) {
//                 //   if (value) _webViewController.goBack();
//                 // });
//
//               },
//               mIcon: Icons.arrow_back_ios,
//               iconColor: Colors.white,
//             ),
//             iconInkWell(
//               func: () {
//                 _webViewController.canGoForward().then((value) {
//                   if (value) _webViewController.goForward();
//                 });
//               },
//               mIcon: Icons.arrow_forward_ios,
//               iconColor: Colors.white,
//             ),
//             iconInkWell(
//               func: () {
//                 _webViewController
//                     .currentUrl()
//                     .then((value) => Share.share(value));
//               },
//               mIcon: Icons.send,
//               iconColor: Colors.white,
//             ),
//             MediaQuery(
//               data: MediaQueryData(),
//               child: InkWell(
//                 child: Icon(Icons.history_rounded, color: Colors.white),
//                 onTap: () {
//                   showModalBottomSheet(
//                     context: contextParam,
//                     builder: (BuildContext ctx) {
//                       return ListView.builder(
//                         itemCount: _myList.length,
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             child: Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(_myList[index]),
//                                 Icon(Icons.arrow_forward_ios_rounded),
//                               ],
//                             ),
//                             onTap: () {},
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             iconInkWell(
//               mIcon: Icons.refresh,
//               iconColor: Colors.white,
//               func: () {
//                 _webViewController.currentUrl().then((value) {
//                   myUrl = value;
//                   _webViewController.reload();
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     ),
//     // bottomNavigationBar: BottomNavigationBar(
//     //   showSelectedLabels: false,
//     //   showUnselectedLabels: false,
//     //   items: [
//     //     BottomNavigationBarItem(icon: Icon(Icons.arrow_forward_ios)),
//     //   ],
//     // ),
//   );
// }
