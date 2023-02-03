import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

Widget confirm(String id,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 4, left: 10, right: 10),
          child: Column(
            children: [
              smbold('Are you sure you want to delete ?'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          // deleteVolunteer(id);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttongreen),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textcolor2),
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.shade700),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textcolor2),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        )),
  );
}
