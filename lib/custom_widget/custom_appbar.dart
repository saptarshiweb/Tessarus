import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';

AppBar appbar1(String text, BuildContext context) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ),
    titleSpacing: 0,
    elevation: 0,
    backgroundColor: primaryColor,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(FontAwesome.left_open, color: textcolor2, size: 19)),
    title: Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(text,
              style: TextStyle(
                  color: textcolor2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(
              'assets/espektroicon2.png',
              fit: BoxFit.contain,
            ),
          )
         
        ],
      ),
    ),
  );
}
