import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

AppBar appbar1(String text,BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    title: smbold(text),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.backspace))
    ],
  );
}
