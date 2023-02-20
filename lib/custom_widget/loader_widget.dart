import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loadingwidget() {
  return Lottie.asset('assets/loading.json', fit: BoxFit.contain);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.white,
      title: Center(child: loadingwidget()));
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
