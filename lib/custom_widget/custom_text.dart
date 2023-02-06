import 'package:flutter/material.dart';

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
    style: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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
