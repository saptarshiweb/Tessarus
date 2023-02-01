import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Attendly',
    theme: ThemeData(fontFamily: 'lato'),
    debugShowCheckedModeBanner: true,
    home: const DrawerScreen(),
  ));
}
