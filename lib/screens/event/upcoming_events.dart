import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/custom_widget/custom_container.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';

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
    // print(responseval);

    var responseData = responseval['events']["documents"];
    // print(responseData.length);

    List<Events> event1 = [];

    for (int i = 0; i < responseData.length; i++) {
      print(i);
      Events eventfile = Events(
        sId: responseData[i]["_id"],
        title: responseData[i]["title"],
        description: responseData[i]["description"],
        tagLine: responseData[i]["tagLine"],
        startTime: responseData[i]["startTime"],
        endTime: responseData[i]["endTime"],
        eventVenue: responseData[i]["eventVenue"],
        // eventImages: responseData[i]["eventImages"].cast<String>(),
        eventMinParticipants: responseData[i]["eventMinParticipants"],
        eventMaxParticipants: responseData[i]["eventMaxParticipants"],
        eventPrice: responseData[i]["eventPrice"],
        // eventCoordinators: responseData[i]["eventCoordinators"],
        createdBy: responseData[i]["createdBy"],
        createdAt: responseData[i]["createdAt"],
        updatedAt: responseData[i]["updatedAt"],
        iV: responseData[i]["__v"],
        // eventOrganiserClub: responseData[i]["eventOrganiserClub"],
        eventType: responseData[i]["eventType"],
      );
      event1.add(eventfile);
    }
    print(event1.length);
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
                        padding: const EdgeInsets.only(bottom: 10, top: 10,left:8,right:8),
                        child: EventCardDisplay(
                            context, snapshot.data[index]));
                  });
            }
          }),
    );
  }
}
