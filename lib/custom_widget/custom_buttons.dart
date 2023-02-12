import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

ElevatedButton ebutton3({required fun, required Widget t}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: containerColor, width: 1))),
      onPressed: () {
        fun();
      },
      child: t);
}

ElevatedButton ebutton({required fun, required String text}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
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

ElevatedButton ebutton2({required fun, required String text}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
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
