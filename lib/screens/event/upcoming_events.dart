// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_element
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/screens/event/event_detail_page.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  String auth_val = '';
  Future<List<Events>> eventListUpcoming() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    final response = await http.get(
      Uri.parse(all_event_url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Authorization': 'Bearer $auth_val'
      },
    );
    var responseval = json.decode(response.body);
    var responseData = responseval['events']["documents"];
    List<Events> event1 = [];
    for (int i = 0; i < responseData.length; i++) {
      Events eventfile = Events.fromJson(responseData[i]);
      event1.add(eventfile);
    }
    return event1;
  }

  Future<Future<List<Events>>> _refreshUpcomingEvents(
      BuildContext context) async {
    setState(() {});
    return eventListUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshUpcomingEvents(context),
      child: FutureBuilder(
          future: eventListUpcoming(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(child: loadingwidget()),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 10, left: 8, right: 8),
                        child: EventCardDisplay(context, snapshot.data[index]));
                  });
            }
          }),
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

    String startTime = event.startTime!;
    int m = int.parse(startTime.substring(4, 6));
    String day = startTime.substring(8, 10);
    List<String> month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return Container(
      decoration: BoxDecoration(
          color: primaryColor1, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 14, top: 22, bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                smbold(event.title ?? ''),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return confirmDeleteDialogEvent(
                                event.sId!, context, 'Delete the Event ?');
                          });
                    },
                    icon: Icon(FontAwesome5.trash_alt,
                        color: allcancel, size: 22))
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                ctext1(
                    'By ${event.eventOrganiserClub!.name!}', subtitleColor, 12),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  children: [
                    ctext1(month[m], textcolor2, 18),
                    const SizedBox(height: 6),
                    ctext1(day, containerColor, 14),
                  ],
                ),
                const SizedBox(width: 20),
                Container(
                  height: 25,
                  width: 2,
                  color: containerColor,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ctext1('Tech Fest Espektro', textcolor2, 12),
                    const SizedBox(height: 6),
                    ctext1(event.tagLine!, containerColor, 12),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: containerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, left: 0, right: 0),
                      child: ctext1('Get Details', primaryColor1, 12),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmDeleteDialogEvent(
      String id, BuildContext context, String text) {
    return Column(
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
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Container(
              decoration: BoxDecoration(
                  color: modalbackColor2,
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 4, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Icon(FontAwesome.trash,
                              color: textcolor2, size: 30),
                        )),
                    const SizedBox(height: 30),
                    ctext1(text, textcolor5, 18),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                showLoaderDialog(context);
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                deleteEvent(id.toString(), context);
                                eventListUpcoming();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: allcancel,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Yes, Delete it',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: textcolor5),
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
