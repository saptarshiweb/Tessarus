import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

String changeVal(String t) {
  String str = "";
  //change USER_PASSWORD_RESET to User Password Reset
  t = t.toLowerCase();
  for (int i = 0; i < t.length; i++) {
    if (t[i] == "_") {
      str += " ";
    } else if (i == 0) {
      str += t[i].toUpperCase();
    } else if (t[i - 1] == "_") {
      str += t[i].toUpperCase();
    } else {
      str += t[i];
    }
  }
  return str;
}

Widget countWidget(BuildContext context, String t) {
  return Countup(
    begin: 0,
    curve: Curves.easeInCirc,
    end: double.parse(t),
    duration: const Duration(seconds: 2),
    separator: ',',
    style: TextStyle(
        fontSize: 14,
        color: containerColor,
        fontFamily: 'lato',
        fontWeight: FontWeight.bold),
  );
}

Widget headerContainer(BuildContext context, String headline, IconData ic) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        ctext1(headline, textcolor6, 14),
        const Spacer(),
        Icon(ic, color: textcolor6, size: 18),
      ],
    ),
  );
}
