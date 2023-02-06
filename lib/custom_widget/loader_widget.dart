import 'package:flutter/material.dart';

Widget loadingwidget() {
  return const CircularProgressIndicator(
    color: Colors.orange,
    backgroundColor: Colors.purple,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.white,
    title: Center(child: loadingwidget()),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
