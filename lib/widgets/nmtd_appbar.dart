import 'package:flutter/material.dart';

AppBar nmtdAppbar({required title,IconData? actionIcon, VoidCallback? actionFunction}) {
  return AppBar(
    elevation: 10,
    title: title,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: IconButton(
          onPressed: actionFunction,
          icon: Icon(actionIcon),
        ),
      ),
    ],
  );
}
