import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';

Widget errorModal2(String message, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(FontAwesome.cancel_circled),
            iconSize: 22,
            color: textcolor2),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Container(
              height: 210,
              decoration: BoxDecoration(
                  color: modalbackColor2,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 4, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(WebSymbols.attention,
                            color: containerColor, size: 24),
                        const SizedBox(width: 14),
                        ctext1('Something Went Wrong!', containerColor, 24),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      message,
                      style: TextStyle(
                          color: textcolor5,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: containerColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesome.left,
                                        color: primaryColor1,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 14),
                                      Text(
                                        'Try Again',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor1,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    ),
  );
}

Widget successModal2(String message, BuildContext context, Widget route) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(FontAwesome.cancel_circled),
            iconSize: 22,
            color: textcolor2),
        const SizedBox(height: 6),
        Container(
            height: 210,
            decoration: BoxDecoration(
                color: modalbackColor2,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 6, bottom: 4, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(WebSymbols.ok, color: containerColor, size: 24),
                      const SizedBox(width: 14),
                      ctext1('Successfully Done!', containerColor, 24),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    style: TextStyle(
                        color: textcolor5,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextButton(
                        onPressed: () {
                          normalNavigation(route, context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: containerColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesome.left,
                                color: primaryColor1,
                                size: 22,
                              ),
                              const SizedBox(width: 14),
                              Text(
                                'Back To Home',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor1,
                                ),
                              ),
                            ],
                          ),
                        )),
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
      ],
    ),
  );
}
