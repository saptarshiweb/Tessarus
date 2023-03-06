import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../../../color_constants.dart';

class EditEventPage extends StatefulWidget {
  const EditEventPage({super.key});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(FontAwesome.left_open, color: textcolor2, size: 19)),
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text('Edit Event Details',
                  style: TextStyle(
                      color: textcolor2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              Icon(FontAwesome.question_circle_o, color: textcolor2, size: 22),
            ],
          ),
        ),
      ),
      body: Container(),
    );
  }
}
