import 'package:flutter/cupertino.dart';

String dateConvert(String s) {
  String val = "";
  String date = s.substring(0, 10);
  String time = s.substring(11, 19);
  val = "$date $time";
  return val;
}

shiftFocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    currentFocus.focusedChild!.unfocus();
  }
}

normalNavigation(Widget route, BuildContext context) {
  Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => route),
  );
}

easyNavigation(Widget route, BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => route),
      (Route<dynamic> route) => false);
}
