// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
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
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesome5.empire,
                color: containerColor,
                size: 34,
              ),
              const SizedBox(width: 8),
              ctext1('Tessarus', textcolor2, 20),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Lottie.asset('assets/gdsc-logo.json',
          repeat: false
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ctext1('Powered By', textcolor2, 20),
              const SizedBox(width: 10),
              ctext1('GDSC KGEC', textcolor2, 20),
            ],
          )

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.30,
          //       width: MediaQuery.of(context).size.width * 0.40,
          //       // height: 50, width: 50,
          //       // height: MediaQuery.of(context).size.height * 30,
          //       // width: MediaQuery.of(context).size.width * 35,
          //       child: Lottie.asset('assets/gdsc-text.json'),
          //     ),
          //     SizedBox(width: 30),
          //     AnimatedTextKit(animatedTexts: [
          //       RotateAnimatedText('KGEC',
          //           textStyle: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               color: textcolor2,
          //               fontSize: 40)),
          //     ])
          //   ],
          // )
          // // AnimatedTextKit(
          // //   animatedTexts: [
          // //     ColorizeAnimatedText(
          // //       'Larry Page',
          // //       textStyle: colorizeTextStyle,
          // //       colors: colorizeColors,
          // //     ),
          // //     ColorizeAnimatedText(
          // //       'Bill Gates',
          // //       textStyle: colorizeTextStyle,
          // //       colors: colorizeColors,
          // //     ),
          // //     ColorizeAnimatedText(
          // //       'Steve Jobs',
          // //       textStyle: colorizeTextStyle,
          // //       colors: colorizeColors,
          // //     ),
          // //   ],
          // //   isRepeatingAnimation: true,
          // //   onTap: () {
          // //     print("Tap Event");
          // //   },
          // // ),
        ],
      ),
    );
  }
}
