
import 'package:flutter/material.dart';

class IconInkWell extends StatelessWidget {
  final Function func;
  final Widget iconWidget;

  const IconInkWell({this.func, this.iconWidget});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: iconWidget == null ? SizedBox.shrink() : iconWidget,
    );
  }
}
