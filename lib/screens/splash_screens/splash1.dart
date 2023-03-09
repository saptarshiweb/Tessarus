// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/main.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1(this.widget, this.time, {super.key});
  final int time;
  final Widget widget;

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: widget.time),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const StartScreen())));
  }

  var colorizeColors = [
    containerColor,
    Colors.deepPurpleAccent.shade700,
    Colors.yellowAccent.shade700,
    Colors.lightGreenAccent.shade700,
  ];

  var colorizeTextStyle = const TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'cas');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ctext1('Tessarus Volunteer', textcolor2, 26),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/espektroLogo.png',
              fit: BoxFit.contain,
            ),
          ),
          Lottie.asset('assets/gdsc-logo.json', repeat: false),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ctext1('Powered By', textcolor6, 16),
              const SizedBox(width: 10),
              ctext1('GDSC KGEC', containerColor, 20),
            ],
          ),
        ],
      ),
    );
  }
}
