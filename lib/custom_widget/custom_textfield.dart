import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';

Widget tfield1(
    {required TextEditingController controller,
    required String label,
    obscuretext = false}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
        backgroundColor: textcolor5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    child: TextFormField(
      controller: controller,
      obscureText: obscuretext,
      style: TextStyle(
          color: textcolor2, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter $label',
        labelText: 'Enter $label',
        labelStyle: TextStyle(
            color: textcolor5,
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
    style: ElevatedButton.styleFrom(
        backgroundColor: textcolor5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    child: TextFormField(
      minLines: 1,
      maxLines: 4,
      controller: controller,
      obscureText: obscuretext,
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter $label',
        labelText: 'Enter $label',
        labelStyle: TextStyle(
            color: textcolor5,
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
    style: ElevatedButton.styleFrom(
        backgroundColor: textcolor5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    child: TextFormField(
      controller: controller,
      obscureText: obscuretext,
      keyboardType: TextInputType.datetime,
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter $label',
        labelText: 'Enter $label',
        labelStyle: TextStyle(
            color: textcolor5,
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
    style: ElevatedButton.styleFrom(
        backgroundColor: textcolor5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    child: TextFormField(
      controller: controller,
      obscureText: obscuretext,
      keyboardType: TextInputType.number,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter $label',
        labelText: 'Enter $label',
        labelStyle: TextStyle(
            color: textcolor5,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
