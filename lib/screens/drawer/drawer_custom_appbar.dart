import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_menu_widget.dart';

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
