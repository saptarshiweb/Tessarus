import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_main_screen.dart';
import 'package:tessarus_volunteer/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: 'Tessarus Volunteer',
    theme: ThemeData(fontFamily: 'lato'),
    debugShowCheckedModeBanner: false,
    home: const StartScreen(),
    // home: const DrawerScreen(),
  ));
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool go = false;
  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? token = prefs.getBool("signIn");
    if (token == true) {
      go = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkToken(),
          builder: ((context, snapshot) {
            if (go == true) return const DrawerScreen();
            return const LoginScreen();
          })),
    );
  }
}
