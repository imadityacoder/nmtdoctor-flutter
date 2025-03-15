import 'package:flutter/material.dart';

AppBar nmtdAppbar({required title, Widget? actionWidget}) {
  return AppBar(
    title: title,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: actionWidget,
      ),
    ],
  );
}
