# in_app_webview

Simple in app browser for you application.

![BrowseIn](https://github.com/AbbasJafariTrax/InAppBrowserPackage/blob/master/assets/images/browse_in.jpg)

## Getting Started

### Usage

```
    MaterialApp(
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
```

### InAppWebView parameters

[mUrl] which is loaded and displayed by web view and it will be shown on the appbar and shared by
share button.

```this.mUrl```
```Key key```
To change the direction of web view
```this.mDirection = TextDirection.ltr```
Bottom Sheet Icons

```
this.backIcon
this.nextIcon
this.shareIcon
this.refreshIcon
```

Bottom Sheet Size
```this.btmSheetSize = 56```
Bottom Sheet Shape
```this.btmSheetShape```

AppBar Parameters

```
this.closeIcon
this.appBarBGColor = Colors.white
this.bottomNavColor = Colors.white
```

If ```widget.titleWidget == null``` and ```showAppTitle == true``` then the current URL will show on
the appbar

```
this.showAppTitle = false
```

```
this.actionWidget
this.centerTitle = false
this.elevationVal = 0
this.appBarFGColor
this.shadowColor
this.iconTheme
this.actionsIconTheme
this.primary = true
this.excludeHeaderSemantics = false
this.titleSpacing
this.toolbarHeight
this.leadingWidth
this.toolbarTextStyle
this.titleTextStyle
```

Git repository of this package
[git_repository](https://github.com/AbbasJafariTrax/InAppBrowserPackage/)

### Contributing

1. Fork it (https://github.com/atiqsamtia/change_app_package_name/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request