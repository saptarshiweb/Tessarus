import 'package:flutter/material.dart';

Text smtext(String text) {
  return Text(
    text,
    style: const TextStyle(color: Colors.black, fontSize: 12),
  );
}

Text smbold(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
  );
}

Text headtext(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  );
}
