import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_menu_widget.dart';
import 'package:tessarus_volunteer/screens/event/add_event_page.dart';

import '../../color_constants.dart';

AppBar customAppBar(String text, Color col) {
  return AppBar(
    elevation: 0,
    backgroundColor: col,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: alltemp,
    ),
    title: Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
    ),
    leading: const DrawerMenuWidget(),
  );
}

AppBar eventsPageAppBar(String text, Color col) {
  int userLevel = 1;
  Future decideAddEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? level = prefs.getInt("Level");
    userLevel = level!;
  }

  return AppBar(
    elevation: 0,
    backgroundColor: col,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: alltemp,
    ),
    title: FutureBuilder(
        future: decideAddEvent(),
        builder: ((context, snapshot) {
          if (userLevel >= 3) {
            return Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      normalNavigation(const AddEventPage(), context);
                    },
                    icon: Icon(Iconic.plus_circle, color: textcolor1, size: 26))
              ],
            );
          } else {
            return Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            );
          }
        })),
    leading: const DrawerMenuWidget(),
  );
}
