import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';

AppBar appbar1(String text, BuildContext context) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: primaryColor,

      // Status bar brightness (optional)
    ),
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: primaryColor,
    title: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(FontAwesome.left_open, color: textcolor2, size: 19)),
          const Spacer(),
          Text(text,
              style: TextStyle(
                  color: textcolor2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          Icon(FontAwesome.question_circle_o, color: textcolor2, size: 22),
        ],
      ),
    ),
  );
}
