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
        hintText: 'Enter your $label',

        labelText: label,
        labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
            fontWeight: FontWeight.bold),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(color: Colors.black, width: 2.3),
        //     borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
