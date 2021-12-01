import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowser {
  static WebViewController _webViewController;
  static String myUrl = "";
  static List<String> _myList = [];

  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();

  // static const MethodChannel _channel = const MethodChannel('in_app_browser');
  //
  // static Future<String> get platformVersion async {
  //   final String version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }

  static Widget launchUrl({
    @required String url,
    @required BuildContext contextParam,
    @required paddingRight,
  }) {
    myUrl = url;
    return Scaffold(
      appBar: AppBar(
        title: Text(myUrl),
        leading: Icon(Icons.close),
        actions: [
          InkWell(
            child: Icon(Icons.bookmark_outline_sharp),
            onTap: () {
              _webViewController.currentUrl().then((value) {
                if (!_myList.contains(value)) {
                  _myList.add(value);
                }
              });
            },
          ),
          SizedBox(width: paddingRight),
        ],
      ),
      body: WebView(
        initialUrl: myUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webCtrl) async {
          myUrl = await webCtrl.currentUrl();
          _webViewController = webCtrl;
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: Card(
          color: Colors.blue,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
                onTap: () {
                  _webViewController.canGoBack().then((value) {
                    if (value) _webViewController.goBack();
                  });
                },
              ),
              InkWell(
                child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onTap: () {
                  _webViewController.canGoForward().then((value) {
                    if (value) _webViewController.goForward();
                  });
                },
              ),
              InkWell(
                child: Icon(Icons.send, color: Colors.white),
                onTap: () {
                  _webViewController
                      .currentUrl()
                      .then((value) => Share.share(value));
                },
              ),
              MediaQuery(
                data: new MediaQueryData(),
                child: InkWell(
                  child: Icon(Icons.history_rounded, color: Colors.white),
                  onTap: () {
                    showModalBottomSheet(
                      context: contextParam,
                      builder: (BuildContext ctx) {
                        return ListView.builder(
                          itemCount: _myList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_myList[index]),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                              onTap: () {},
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  _webViewController.currentUrl().then((value) {
                    myUrl = value;
                    _webViewController.reload();
                  });
                },
                child: Icon(Icons.refresh, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.arrow_forward_ios)),
      //   ],
      // ),
    );
  }
}
