import 'package:browse_in/widgets/IconInkWell.dart';
import 'package:browse_in/widgets/IconWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class InAppBrowser extends StatefulWidget {
  String mUrl;
  final TextDirection mDirection;
  final Widget backIcon,
      nextIcon,
      shareIcon,
      refreshIcon,
      closeIcon,
      titleWidget;

  // Bottom Sheet parameters
  final Color bottomNavColor;
  final double btmSheetSize;
  final ShapeBorder btmSheetShape;

  // AppBar parameters
  final Color appBarBGColor, appBarFGColor;
  final bool showAppBar, centerTitle, primary, excludeHeaderSemantics;
  final List<Widget> actionWidget;
  final Color shadowColor;
  final IconThemeData iconTheme, actionsIconTheme;

  final double titleSpacing, toolbarHeight, leadingWidth, elevationVal;
  final TextStyle toolbarTextStyle, titleTextStyle;

  InAppBrowser(
    this.mUrl, {
    Key key,
    this.mDirection = TextDirection.ltr,
    this.backIcon,
    this.nextIcon,
    this.shareIcon,
    this.refreshIcon,
    this.closeIcon,
    this.appBarBGColor = Colors.white,
    this.bottomNavColor = Colors.white,
    this.titleWidget,
    this.showAppBar = false,
    this.actionWidget,
    this.centerTitle = false,
    this.elevationVal = 0,
    this.appBarFGColor,
    this.shadowColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.btmSheetSize = 56,
    this.btmSheetShape,
  }) : super(key: key);

  @override
  _InAppBrowserState createState() => _InAppBrowserState();
}

class _InAppBrowserState extends State<InAppBrowser>
    with TickerProviderStateMixin {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    flutterWebViewPlugin.onUrlChanged.forEach((element) {
      widget.mUrl = element;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        mDispose();
        return true;
      },
      child: Directionality(
        textDirection: widget.mDirection,
        child: WebviewScaffold(
          appBar: AppBar(
            actions: widget.actionWidget,
            centerTitle: widget.centerTitle,
            primary: widget.primary,
            excludeHeaderSemantics: widget.excludeHeaderSemantics,
            elevation: widget.elevationVal,
            backgroundColor: widget.appBarBGColor,
            shadowColor: widget.shadowColor,
            iconTheme: widget.iconTheme,
            actionsIconTheme: widget.actionsIconTheme,
            titleSpacing: widget.titleSpacing,
            toolbarHeight: widget.toolbarHeight,
            leadingWidth: widget.leadingWidth,
            toolbarTextStyle: widget.toolbarTextStyle,
            titleTextStyle: widget.titleTextStyle,
            title: widget.titleWidget == null
                ? widget.showAppBar
                    ? Text(
                        widget.mUrl,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : SizedBox.shrink()
                : widget.titleWidget,
            leading: InkWell(
              child: widget.closeIcon == null
                  ? IconWidget(Icons.close)
                  : widget.closeIcon,
              onTap: mDispose,
            ),
          ),
          url: widget.mUrl,
          bottomNavigationBar: SizedBox(
            height: widget.btmSheetSize,
            child: Card(
              color: widget.bottomNavColor,
              margin: EdgeInsets.zero,
              shape: widget.btmSheetShape == null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    )
                  : widget.btmSheetShape,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconInkWell(
                    func: () {
                      flutterWebViewPlugin.canGoBack().then((value) {
                        if (value) flutterWebViewPlugin.goBack();
                      });
                    },
                    iconWidget: widget.backIcon == null
                        ? IconWidget(Icons.arrow_back_ios)
                        : widget.backIcon,
                  ),
                  IconInkWell(
                    func: () {
                      flutterWebViewPlugin.canGoForward().then((value) {
                        if (value) flutterWebViewPlugin.goForward();
                      });
                    },
                    iconWidget: widget.nextIcon == null
                        ? IconWidget(Icons.arrow_forward_ios)
                        : widget.nextIcon,
                  ),
                  IconInkWell(
                    func: () {
                      Share.share(widget.mUrl);
                    },
                    iconWidget: widget.shareIcon == null
                        ? IconWidget(Icons.share)
                        : widget.shareIcon,
                  ),
                  IconInkWell(
                    iconWidget: widget.refreshIcon == null
                        ? IconWidget(Icons.refresh)
                        : widget.refreshIcon,
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

  void mDispose() {
    flutterWebViewPlugin.dispose();
    flutterWebViewPlugin.hide();

    Future.delayed(Duration(microseconds: 10), () {
      Navigator.pop(context);
    });
  }
}
