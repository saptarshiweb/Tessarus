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
Text ctext1(String text, Color col,double s) {
  return Text(
    text,
    style: TextStyle(color: col, fontSize: s, fontWeight: FontWeight.bold),
  );
}
