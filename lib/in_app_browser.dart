import 'package:browse_in/widgets/IconInkWell.dart';
import 'package:browse_in/widgets/IconWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share_plus/share_plus.dart';

/// Write comment and a great docs
/// change the name of package

// ignore: must_be_immutable
class InAppWebView extends StatefulWidget {
  /// [mUrl] which is loaded and displayed by web view and it will be show on the appbar
  /// and share by share button
  String mUrl;

  /// To change the direction of web view
  final TextDirection mDirection;

  /// You can set your title widget by [titleWidget]
  final Widget closeIcon,
      titleWidget,
  /// Bottom Sheet Icons
      backIcon,
      nextIcon,
      shareIcon,
      refreshIcon;

  // Bottom Sheet parameters
  final Color bottomNavColor;
  final double btmSheetSize;
  final ShapeBorder btmSheetShape;

  // AppBar parameters
  final Color appBarBGColor, appBarFGColor;
  final bool showAppTitle, centerTitle, primary, excludeHeaderSemantics;
  final List<Widget> actionWidget;
  final Color shadowColor;
  final IconThemeData iconTheme, actionsIconTheme;

  final double titleSpacing, toolbarHeight, leadingWidth, elevationVal;
  final TextStyle toolbarTextStyle, titleTextStyle;

  InAppWebView(
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
    this.showAppTitle = false,
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
  _InAppWebViewState createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView>
    with TickerProviderStateMixin {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // onChange listener is used to change the value of mUrl variable
    flutterWebViewPlugin.onUrlChanged.forEach((element) {
      widget.mUrl = element;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      key: widget.key,
      onWillPop: () async {
        mDispose();
        return true;
      },
      child: Directionality(
        textDirection: widget.mDirection,
        child: WebviewScaffold(
          /// App bar screen
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
                ? widget.showAppTitle
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
            leading: IconInkWell(
              func: mDispose,
              iconWidget: widget.closeIcon == null
                  ? IconWidget(Icons.close)
                  : widget.closeIcon,
            ),
          ),

          /// Web view screen
          url: widget.mUrl,

          /// Bottom sheet screen
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
                  /// Go to previous link
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

                  /// Go to next link
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

                  /// share the current link
                  IconInkWell(
                    func: () {
                      Share.share(widget.mUrl);
                    },
                    iconWidget: widget.shareIcon == null
                        ? IconWidget(Icons.share)
                        : widget.shareIcon,
                  ),

                  /// Refresh the current link
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

  /// [mDispose] will dispose and hide web view and then close the page
  void mDispose() {
    flutterWebViewPlugin.dispose();
    flutterWebViewPlugin.hide();

    Future.delayed(Duration(microseconds: 10), () {
      Navigator.pop(context);
    });
  }
}
