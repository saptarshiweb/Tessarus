// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_buttons.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/screens/event/event_detail_page.dart';

Widget volunteerDisplay(BuildContext context, String name, String email,
    String phone, String access, String id) {
  String vol(String access) {
    if (access == '4') {
      return 'Super Admin';
    } else if (access == '3') {
      return 'Admin';
    } else if (access == '2') {
      return 'Cashier';
    }
    return 'Volunteer';
  }

  return Padding(
    padding: const EdgeInsets.only(top: 3, bottom: 3),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          shadowColor: Colors.grey.shade900,
          surfaceTintColor: Colors.grey,
          backgroundColor: Colors.grey.shade100),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 2, right: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  phone,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  vol(access),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {},
                    child: const Text('Edit')),
                const SizedBox(width: 8),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return confirm(id, context);
                          });
                    },
                    child: const Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget EventCardDisplay(BuildContext context, Events event) {
  void eventDetailgo() async {
    String eventID = '';
    eventID = event.sId!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('specificEvent', eventID);
    normalNavigation(const EventDetailPage(), context);
  }

  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1.8, color: alltemp),
      borderRadius: BorderRadius.circular(6),
    ),
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
