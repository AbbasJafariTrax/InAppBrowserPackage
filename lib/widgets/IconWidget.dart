import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData iconWidget;
  final Color iconColor;

  const IconWidget(this.iconWidget, {this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Icon(iconWidget, color: iconColor);
  }
}
