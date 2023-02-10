import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';

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

Widget errorModal2(String message, BuildContext context) {
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
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14, bottom: 14, left: 8, right: 8),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: textcolor2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesome.left,
                              color: alltemp.withOpacity(0.5),
                              size: 22,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Try Again',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: alltemp.withOpacity(0.5),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        )),
  );
}

Widget successModal2(String message, BuildContext context, Widget route) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: successModalColor, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 6, bottom: 4, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent.shade700,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: textcolor2,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              TextButton(
                  onPressed: () {
                    normalNavigation(route, context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesome.left,
                        color: alltemp.withOpacity(0.5),
                        size: 22,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'Go Back To Home',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: alltemp.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ))
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
