import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/custom_widget/custom_buttons.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  String auth_val = '';
  int total_coordinator = 0;
  //event add controllers
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController tagLine = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController eventVenue = TextEditingController();
  TextEditingController eventType = TextEditingController();
  TextEditingController eventMax = TextEditingController();
  TextEditingController eventMin = TextEditingController();
  TextEditingController eventPrice = TextEditingController();
  TextEditingController organiserClub = TextEditingController();
  List<TextEditingController> coordinatorName = [];
  List<TextEditingController> coordinatorPhone = [];
  List<int> coordinatorIndex = [];
  bool coordinator_space = false;

  addNewEvent(BuildContext context) {
    eventAdd();
  }

  Future eventAdd() async {
    //organiser club

    EventOrganiserClub club =
        EventOrganiserClub(name: organiserClub.text, image: 'http');

    List<EventCoordinatorsAdd> eventCoordinator1 = [];

    for (int i = 0; i < total_coordinator; i++) {
      EventCoordinatorsAdd e1 = EventCoordinatorsAdd(
          name: coordinatorName[i].text, phone: coordinatorPhone[i].text);
      eventCoordinator1.add(e1);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    var body = {
      'title': title.text,
      'description': description.text,
      'tagLine': tagLine.text,
      'startTime': startTime.text,
      'endTime': endTime.text,
      'eventVenue': eventVenue.text,
      'eventType': eventType.text,
      'eventMaxParticipants': eventMax.text,
      'eventMinParticipants': eventMin.text,
      'eventPrice': eventPrice.text,
      'eventOrganiserClub': {'name': organiserClub.text, 'image': 'http'},
      'eventCoordinators': eventCoordinator1
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

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar1('Add Event Details', context),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 10),
        child: ListView(
          children: [
            tfield1(controller: title, label: 'Event Title'),
            const SizedBox(height: 12),
            tfield1(controller: description, label: 'Event Description'),
            const SizedBox(height: 12),
            tfield1(controller: tagLine, label: 'Event Tagline'),
            const SizedBox(height: 12),
            tfield1(controller: eventVenue, label: 'Event Venue'),
            const SizedBox(height: 12),
            tfield1(controller: startTime, label: 'Event Start Time'),
            const SizedBox(height: 12),
            tfield1(controller: endTime, label: 'Event End Time'),
            const SizedBox(height: 12),
            tfield1(controller: eventType, label: 'Event Type'),
            const SizedBox(height: 12),
            tfield1(controller: eventMax, label: 'Max Participants'),
            const SizedBox(height: 12),
            tfield1(controller: eventMin, label: 'Min Participants'),
            const SizedBox(height: 12),
            tfield1(controller: eventPrice, label: 'Event Price'),
            const SizedBox(height: 12),
            tfield1(controller: organiserClub, label: 'Organiser Club'),
            const SizedBox(height: 12),
            coordinatorContainer(context),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: alltemp),
                      onPressed: () {
                        eventAdd();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            smbold1('Confirm'),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget coordinatorContainer(BuildContext context) {
    int ind = 0;
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    void deleteCoordinator() {
      //  setState(() {
      //                             coordinatorIndex.removeAt(index);
      //                           });
    }

    void addCoordinator() {
      coordinatorName.add(name);
      coordinatorPhone.add(phone);
    }

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200),
      child: Column(
        children: [
          Row(
            children: [
              smbold('Add Coordinator'),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    coordinatorIndex.add(total_coordinator);
                    total_coordinator++;
                    if (!coordinator_space) coordinator_space = true;
                  });
                },
                icon: Icon(Iconic.plus_circle, color: textcolor1, size: 22),
              )
            ],
          ),
          const SizedBox(height: 12),
          (coordinator_space == true)
              ? SizedBox(
                  height:
                      (total_coordinator > 0 && coordinator_space) ? 200 : 0,
                  child: ListView.builder(
                      itemCount: coordinatorIndex.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            // color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    smbold('   Coordinator ${index + 1}'),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          coordinatorIndex.removeAt(index);
                                          total_coordinator--;
                                          if (total_coordinator == 0) {
                                            coordinator_space = false;
                                          }
                                        });
                                      },
                                      icon: Icon(Iconic.minus_circle,
                                          color: textcolor1, size: 22),
                                    )
                                  ],
                                ),
                                tfield1(
                                    controller: name,
                                    label: 'Coordinator Name'),
                                const SizedBox(height: 12),
                                tfield1(
                                    controller: phone,
                                    label: 'Coordinator Phone No.'),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                        child: ebutton(
                                            fun: addCoordinator,
                                            text: 'Add Coordinator')),
                                    // const SizedBox(width: 8),
                                    // Expanded(
                                    //     flex: 2,
                                    //     child: ebutton(
                                    //         fun: deleteCoordinator, text: 'Delete')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : const SizedBox(height: 0, width: 0)
        ],
      ),
    );
  }
}
