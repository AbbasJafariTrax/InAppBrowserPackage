# in_app_browser

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

Git repository of this package
[git_repository](https://github.com/AbbasJafariTrax/InAppBrowserPackage/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.a new flutter plugin project