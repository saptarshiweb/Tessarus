import 'package:flutter/material.dart';

import '../color_constants.dart';

Widget loadingwidget() {
  return CircularProgressIndicator(
    color: containerColor,
    backgroundColor: Colors.purpleAccent.shade700,
    strokeWidth: 4,
  );

  
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
