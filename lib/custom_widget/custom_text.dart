import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';

Text smtext(String text) {
  return Text(
    text,
    style: const TextStyle(color: Colors.black, fontSize: 12),
  );
}

Text subtitletext(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
  );
}

Text smbold(String text) {
  return Text(
    text,
    style:
        TextStyle(color: textcolor2, fontWeight: FontWeight.bold, fontSize: 18),
  );
}

Text smbold2(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
  );
}

Text smbold1(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
  );
}

Text headtext(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
  );
}

Text ctext(String text, Color col) {
  return Text(
    text,
    style: TextStyle(color: col, fontSize: 18, fontWeight: FontWeight.bold),
  );
}

Text ctext1(String text, Color col, double s) {
  return Text(
    text,
    maxLines: 2,
    style: TextStyle(color: col, fontSize: s, fontWeight: FontWeight.bold),
  );
}

Text handleOverflowText(String s, Color c, double size) {
  String str = "";

  var splitted = s.split(' ');
  if (splitted.length > 3) {
    // for (int i = 0; i < 4; i++) {
    //   str += "${splitted[i]} ";
    // }
    // str += "...";

    for (int i = 0; i < splitted.length; i++) {
      if (i < splitted.length) str += "${splitted[i++]} ";
      if (i < splitted.length) str += "${splitted[i++]} ";
      if (i < splitted.length) str += "${splitted[i]} ";
      str += "\n";
    }
  } else {
    str = s;
  }

  return Text(
    str,
    style: TextStyle(color: c, fontSize: size, fontWeight: FontWeight.bold),
  );
}

Text handleOverflowText2(String s, Color c, double size) {
  String str = "";
  var splitted = s.split(' ');
  if (splitted.length > 4) {
    // for (int i = 0; i < 4; i++) {
    //   str += "${splitted[i]} ";
    // }
    // str += "...";

    for (int i = 0; i < splitted.length; i++) {
      if (i < splitted.length) str += "${splitted[i++]} ";
      if (i < splitted.length) str += "${splitted[i++]} ";
      if (i < splitted.length) str += "${splitted[i++]} ";

      if (i < splitted.length) str += "${splitted[i]} ";
      str += "\n";
    }
  } else {
    str = s;
  }

  return Text(
    str,
    style: TextStyle(color: c, fontSize: size, fontWeight: FontWeight.bold),
  );
}

Text handleOverflowText3(String s, Color c, double size, int num) {
  String str = "";
  var splitted = s.split(' ');
  if (splitted.length > num) {
    // for (int i = 0; i < 4; i++) {
    //   str += "${splitted[i]} ";
    // }
    // str += "...";

    for (int i = 0; i < splitted.length; i++) {
      for (int j = 1; j <= num - 1; j++) {
        if (i < splitted.length) str += "${splitted[i++]} ";
      }

      if (i < splitted.length) str += "${splitted[i]} ";
      str += "\n";
    }
  } else {
    str = s;
  }

  return Text(
    str,
    style: TextStyle(color: c, fontSize: size, fontWeight: FontWeight.bold),
  );
}
