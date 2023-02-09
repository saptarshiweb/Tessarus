// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_buttons.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/screens/event/event_detail_page.dart';

Widget EventCardDisplay(BuildContext context, Events event) {
  void eventDetailgo() async {
    String eventID = '';
    eventID = event.sId!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('specificEvent', eventID);
    normalNavigation(const EventDetailPage(), context);
  }

  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
        backgroundColor: containerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              smbold(event.title ?? ''),
              const Spacer(),
              ebutton(fun: eventDetailgo, text: 'Details'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              subtitletext(event.tagLine ?? ''),
              const Spacer(),
              // smbold(event.tagLine ?? 'sdd')
            ],
          ),
          const SizedBox(height: 12),
          smtext(event.description ?? ''),
        ],
      ),
    ),
  );
}
