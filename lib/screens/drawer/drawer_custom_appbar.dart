import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_menu_widget.dart';

AppBar customAppBar(String text, Color col) {
  return AppBar(
    elevation: 0,
    backgroundColor: col,
    title: Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
    ),
    leading: const DrawerMenuWidget(),
  );
}
