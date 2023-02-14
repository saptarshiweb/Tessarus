// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print, use_build_context_synchronously, unused_field
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/screens/event/add_event_pages/add_coordinator.dart';
import 'package:tessarus_volunteer/screens/event/add_event_pages/add_event_image.dart';
import 'package:tessarus_volunteer/screens/event/add_event_pages/general_info_add.dart';
import 'package:tessarus_volunteer/screens/event/add_event_pages/text_editor_info_add.dart';
import 'package:tessarus_volunteer/screens/event/event_page.dart';
import 'package:http/http.dart' as http;

import '../../../custom_widget/custom_modal_routes.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  String auth_val = '';

  Future eventAdd() async {
    //organiser club
    showLoaderDialog(context);
    await Future.delayed(const Duration(seconds: 6));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    String str = '';
    str = prefs.getString('newEvent') ?? '';
    Map<String, dynamic> jsonDetails = {};
    jsonDetails = jsonDecode(str);
    var newEvent1 = Events.fromJson(jsonDetails);
    print(newEvent1.title);
    var body = {
      'title': newEvent1.title,
      'description': newEvent1.title,
      'tagLine': newEvent1.tagLine,
      'startTime': newEvent1.startTime,
      'endTime': newEvent1.endTime,
      'eventVenue': newEvent1.eventVenue,
      'rules': newEvent1.rules,
      'prizes': newEvent1.prizes,
      'eventImages': newEvent1.eventImages,
      'eventType': newEvent1.eventType,
      'eventMaxParticipants': newEvent1.eventMaxParticipants,
      'eventMinParticipants': newEvent1.eventMinParticipants,
      'eventPrice': newEvent1.eventPrice,
      'eventOrganiserClub': {
        'name': newEvent1.eventOrganiserClub!.name,
        'image': newEvent1.eventOrganiserClub!.image
      },
      'eventCoordinators': newEvent1.eventCoordinators
    };
    final response = await http.post(Uri.parse(add_event),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
          'Authorization': 'Bearer $auth_val'
        },
        // body: jsonEncode(<String, String>),

        body: json.encode(body));

    var responseval = json.decode(response.body);
    Navigator.pop(context);
    if (responseval['message'] != 'Event added successfully') {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          context: context,
          builder: (context) {
            return errorModal2(responseval['message'], context);
          });
    } else {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          context: context,
          builder: (context) {
            return successModal2(
                responseval['message'], context, const EventPage());
          });
    }

    print(response.body);
  }

  //coordinator Space

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appbar1('Add Event Details', context),
      backgroundColor: primaryColor,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 22),
        child: Column(
          children: [
            generalInfo(context),
            const SizedBox(height: 20),
            texteditorInfo(context),
            const SizedBox(height: 20),
            eventImageinfo(context),
            const SizedBox(height: 20),
            coordinatorInfo(context),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: containerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () async {
                        eventAdd();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ctext1('Confirm', primaryColor, 16),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side:
                                  BorderSide(width: 1, color: containerColor))),
                      onPressed: () async {
                        showLoaderDialog(context);
                        await Future.delayed(const Duration(seconds: 6));
                        Navigator.pop(context);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String str = '';
                        str = prefs.getString('newEvent') ?? '';
                        Map<String, dynamic> jsonDetails = {};
                        jsonDetails = jsonDecode(str);
                        var newEvent1 = Events.fromJson(jsonDetails);
                        print(newEvent1.eventCoordinators![0].name);
                        print(newEvent1.eventImages![0].url);
                        print(newEvent1.title);
                        print(newEvent1.eventPrice);
                        print(newEvent1.startTime);
                        print(newEvent1.endTime);
                        print(newEvent1.description);
                        print(newEvent1.rules);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ctext1('Reset All', textcolor2, 16),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget texteditorInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor1, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ctext1('Comprehensive Info', textcolor2, 22),
                const SizedBox(height: 10),
                ctext1('Event description, rules, prizes etc.', textcolor5, 12)
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                normalNavigation(const TextEditorInfo(), context);
              },
              icon: const Icon(FontAwesome.right_open),
              iconSize: 22,
              color: textcolor2,
            ),
          ],
        ),
      ),
    );
  }

  Widget eventImageinfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor1, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ctext1('Event Images', textcolor2, 22),
                const SizedBox(height: 10),
                ctext1(
                    'Add images by simply picking from gallery', textcolor5, 12)
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                normalNavigation(const AddEventImage(), context);
              },
              icon: const Icon(FontAwesome.right_open),
              iconSize: 22,
              color: textcolor2,
            ),
          ],
        ),
      ),
    );
  }

  Widget coordinatorInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor1, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ctext1('Coordinator Info', textcolor2, 22),
                const SizedBox(height: 10),
                ctext1('Coordinator name, phone etc.', textcolor5, 12)
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                normalNavigation(const AddCoordinatorEvent(), context);
              },
              icon: const Icon(FontAwesome.right_open),
              iconSize: 22,
              color: textcolor2,
            ),
          ],
        ),
      ),
    );
  }

  Widget generalInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor1, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ctext1('General Info', textcolor2, 22),
                const SizedBox(height: 10),
                ctext1('Event name, date, time etc.', textcolor5, 12)
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                normalNavigation(const AddGeneralInfoEvent(), context);
              },
              icon: const Icon(FontAwesome.right_open),
              iconSize: 22,
              color: textcolor2,
            ),
          ],
        ),
      ),
    );
  }
}
