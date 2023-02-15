// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/screens/event/add_event_pages/add_event_page.dart';
import 'package:tessarus_volunteer/screens/super_admin_exclusive/add_new_volunteer.dart';
import '../../color_constants.dart';

AppBar customAppBar(String text, Color col) {
  return AppBar(
    iconTheme: IconThemeData(color: textcolor2),
    elevation: 0,
    backgroundColor: primaryColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: primaryColor,
    ),
    title: Text(
      text,
      style: TextStyle(
          color: textcolor2, fontWeight: FontWeight.bold, fontSize: 24),
    ),
    // leading: const DrawerMenuWidget(),
    // leading: const SimpleDrawerCustom(),
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
    iconTheme: IconThemeData(color: textcolor2),
    elevation: 0,
    backgroundColor: primaryColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: primaryColor,
    ),
    title: FutureBuilder(
        future: decideAddEvent(),
        builder: ((context, snapshot) {
          if (userLevel >= 3) {
            return Row(
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: textcolor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      normalNavigation(const AddEventPage(), context);
                    },
                    icon: Icon(Iconic.plus_circle, color: textcolor2, size: 26))
              ],
            );
          } else {
            return Text(
              text,
              style: TextStyle(
                  color: textcolor2, fontWeight: FontWeight.bold, fontSize: 24),
            );
          }
        })),
    // leading: const DrawerMenuWidget(),
  );
}

AppBar VolunteerControlAppBar(String text) {
  int userLevel = 1;
  Future decideVolunteerLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? level = prefs.getInt("Level");
    userLevel = level!;
  }

  return AppBar(
    iconTheme: IconThemeData(color: textcolor2),
    elevation: 0,
    backgroundColor: primaryColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: primaryColor,
    ),
    title: FutureBuilder(
        future: decideVolunteerLevel(),
        builder: ((context, snapshot) {
          if (userLevel >= 3) {
            return Row(
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: textcolor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      normalNavigation(const AddVolunteer(), context);
                    },
                    icon: Icon(Typicons.user_add_outline,
                        color: textcolor2, size: 22)),
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
    // leading: const DrawerMenuWidget(),
  );
}
