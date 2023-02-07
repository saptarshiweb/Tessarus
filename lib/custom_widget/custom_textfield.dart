import 'package:flutter/material.dart';

Widget tfield1(
    {required TextEditingController controller,
    required String label,
    obscuretext = false}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200),
    child: TextFormField(
      controller: controller,
      obscureText: obscuretext,
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter $label',
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget descfield1(
    {required TextEditingController controller,
    required String label,
    obscuretext = false}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200),
    child: TextFormField(
      minLines: 2,
      maxLines: 4,
      controller: controller,
      obscureText: obscuretext,
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter $label',
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget datefield1(
    {required TextEditingController controller,
    required String label,
    obscuretext = false}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200),
    child: TextFormField(
      controller: controller,
      obscureText: obscuretext,
      keyboardType: TextInputType.datetime,
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter $label',
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget numfield1(
    {required TextEditingController controller,
    required String label,
    obscuretext = false}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200),
    child: TextFormField(
      controller: controller,
      obscureText: obscuretext,
      keyboardType: TextInputType.number,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter $label',
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
