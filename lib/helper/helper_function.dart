import 'package:flutter/cupertino.dart';

shiftFocus(BuildContext context) {
  Navigator.pop(context);
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
