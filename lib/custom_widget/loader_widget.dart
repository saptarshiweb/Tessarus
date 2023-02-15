import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

Widget loadingwidget() {
  return CircularProgressIndicator(
    color: containerColor,
    backgroundColor: primaryColor1,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.white,
    title: Center(
        child: Column(
      children: [
        loadingwidget(),
        const SizedBox(height: 20),
        ctext1('Powered By GDSC', containerColor, 12),
      ],
    )),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
