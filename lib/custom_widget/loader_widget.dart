import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loadingwidget() {
  // return CircularProgressIndicator(
  //   color: containerColor,
  //   backgroundColor: Colors.purpleAccent.shade700,
  // );
  // return LoadingAnimationWidget.discreteCircle(
  //     color: containerColor,
  //     secondRingColor: Colors.lightGreenAccent.shade700,
  //     thirdRingColor: textcolor1,
  //     size: 50);
  return Lottie.asset('assets/gdsc-logo.json', fit: BoxFit.contain);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.white,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Lottie.asset(
                'assets/gdsc-logo.json',
                fit: BoxFit.contain,
              ),
            ),
          ],
        )
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
