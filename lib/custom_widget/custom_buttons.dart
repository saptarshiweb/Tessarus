import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

ElevatedButton ebutton({required fun, required String text}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: alltemp),
      onPressed: () {
        fun();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            smbold1(text),
          ],
        ),
      ));
}


TextButton tbutton({required fun, required String text}) {
  return TextButton(
    onPressed: () {
      fun();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesome.left,
          color: alltemp.withOpacity(0.4),
          size: 22,
        ),
        const SizedBox(width: 14),
        Text(
          text,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: alltemp.withOpacity(0.4)),
        )
      ],
    ),
  );
}
