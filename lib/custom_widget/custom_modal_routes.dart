import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_main_screen.dart';

Widget confirm(String id, BuildContext context) {
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
                          deleteVolunteer(id);
                          Navigator.pop(context);
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

Widget errorModal(String message, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 4, left: 10, right: 10),
          child: Column(
            children: [
              Text(
                message,
                style: TextStyle(
                    color: Colors.redAccent.shade700,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreenAccent.shade700),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Try Again',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textcolor2),
                          ),
                        )),
                  ),
                ],
              )
              // Row(
              //   children: [

              //     const SizedBox(width: 14),
              //     const Icon(FontAwesome5.facebook_messenger,
              //         color: Colors.redAccent, size: 17)
              //   ],
              // ),
            ],
          ),
        )),
  );
}

Widget successModal(String message, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 4, left: 10, right: 10),
          child: Column(
            children: [
              Text(
                message,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const DrawerScreen()),
                              (Route<dynamic> route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreenAccent.shade700),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Typicons.left_open_outline,
                                  color: textcolor1, size: 22),
                              const SizedBox(width: 14),
                              Text(
                                'Back to Home',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: textcolor2),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              )
              // Row(
              //   children: [

              //     const SizedBox(width: 14),
              //     const Icon(FontAwesome5.facebook_messenger,
              //         color: Colors.redAccent, size: 17)
              //   ],
              // ),
            ],
          ),
        )),
  );
}
