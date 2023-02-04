import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';

AppBar appbar1(String text, BuildContext context) {
  return AppBar(
     systemOverlayStyle: SystemUiOverlayStyle(
    // Status bar color
    statusBarColor: alltemp, 

    // Status bar brightness (optional)
   
  ),
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: alltemp,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:
                Icon(Typicons.left_open, color: textcolor1, size: 24)),
        Text(text,
            style: TextStyle(
                color: textcolor1, fontSize: 24, fontWeight: FontWeight.bold)),
        Icon(FontAwesome.question_circle_o, color: textcolor1, size: 24),
      ],
    ),
  );
}
