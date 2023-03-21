// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_element, unused_local_variable, avoid_print
import 'dart:async';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/screens/event/event_detail_page.dart';
import 'package:tessarus_volunteer/screens/event/event_page.dart';
import 'package:tessarus_volunteer/screens/event/participant_list.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents(this.val, {super.key});
  final String val;

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  int selectedEventIndex = 1;
  String auth_val = '';
  String volId = '';
  var eventTypeList = [
    'All Events',
    'My Events',
    'GDSC KGEC',
    'KGEC Robotics Society',
    'SAC-KGEC',
    'noScope',
    'Les Quizerables',
    'Litmus',
    'Shutterbug',
    'KeyGEnCoders',
    'CHITRANK',
    'Infinitio',
    'RIYAZ',
    'ELYSIUM'
  ];
  Future<List<Events>> eventListUpcoming() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    final String? vId = prefs.getString("VolID");
    auth_val = auth!;
    volId = vId!;
    String event_url_custom = '$all_event_url?';
    // setState(() {
    //   eventTypeList = ['All Events', 'My Events'];
    // });

    if (eventType != 'All Events' && eventType != 'My Events') {
      event_url_custom =
          '${event_url_custom}eventOrganiserClub.name=$eventType';
    } else if (eventType == 'My Events') {
      event_url_custom = '${event_url_custom}createdBy=$volId';
    }
    final response = await http.get(
      Uri.parse(event_url_custom),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        // 'Authorization': 'Bearer $auth_val'
      },
    );
    var responseval = json.decode(response.body);
    var responseData = responseval['events']["documents"];
    List<Events> event1 = [];

    var clublist = <String>{};
    for (int i = 0; i < responseData.length; i++) {
      Events eventfile = Events.fromJson(responseData[i]);
      DateTime dt1 = DateTime.parse(eventfile.startTime!);
      DateTime dt3 = DateTime.parse(eventfile.endTime!);

      DateTime dt2 = DateTime.now();

      if (dt1.compareTo(dt2) > 0 && widget.val == 'upcoming') {
        event1.add(eventfile);
      } else if (widget.val == 'ongoing' &&
          dt1.compareTo(dt2) < 0 &&
          dt3.compareTo(dt2) > 0) {
        event1.add(eventfile);
      } else if (widget.val == 'past' && dt3.compareTo(dt2) < 0) {
        event1.add(eventfile);
      }
    }
    return event1;
  }

  Future<Future<List<Events>>> _refreshUpcomingEvents(
      BuildContext context) async {
    setState(() {});
    return eventListUpcoming();
  }

  deleteEvent(String id, BuildContext context) async {
    print(id);
    // showLoaderDialog(context);
    // await Future.delayed(const Duration(seconds: 1));
    String authVal = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? auth = prefs.getString("Auth");
    authVal = auth!;

    final response = await http.delete(
      Uri.parse("$delete_event$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Authorization': 'Bearer $authVal'
      },
    );

    print(response.body);
    var responseval = json.decode(response.body);
    print(responseval);
    Navigator.pop(context);
    String statusCode = responseval['statusCode'].toString();
    if (statusCode == '200') {
      showSuccessMessage(responseval['message'], context, const EventPage());
    } else {
      showErrorMessage(responseval['message'], context);
    }
    eventListUpcoming();
  }

  String eventType = 'All Events';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: dropDownWidgetEventType(context),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => _refreshUpcomingEvents(context),
            child: FutureBuilder(
                future: eventListUpcoming(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: loadingwidget());
                  } else if (snapshot.data.length == 0) {
                    return Center(
                        child: ctext1('No events found!', textcolor2, 20));
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, top: 10, left: 8, right: 8),
                              child: EventCardDisplay(
                                  context, snapshot.data[index], index));
                        });
                  }
                }),
          ),
        ),
      ],
    );
  }

  Widget checkParticipants(BuildContext context, Events even1) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: BorderSide(color: containerColor, width: 1.4))),
              onPressed: () {
                normalNavigation(
                    ParticipantList(even1.sId.toString()), context);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ctext1('Check Participants', textcolor2, 15),
              )),
        ),
      ],
    );
  }

  Widget dropDownWidgetEventType(BuildContext context) {
    return SingleChildScrollView(
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
            //change text color in popupWidget
            itemBuilder: (context, item, isSelected) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () async {
                  setState(() {
                    isSelected = true;
                    eventType = item;
                    // logtype = item;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ctext1(item, textcolor2, 16),
                  ],
                ),
              );
            },
            showSelectedItems: true,
            menuProps: MenuProps(backgroundColor: primaryColor)),
        items: eventTypeList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: textcolor2),
          dropdownSearchDecoration: InputDecoration(
            labelStyle: TextStyle(color: textcolor2),
            hintStyle: TextStyle(color: textcolor2),
            suffixIconColor: textcolor2,
            prefixStyle: TextStyle(color: textcolor2),
            labelText: "Select Event Type",
            hintText: "Event Type",
          ),
        ),
        onSaved: (value) async {
          showLoaderDialog(context);
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            eventType = value!;
          });
          // LogsPrint();
          eventListUpcoming();
          Navigator.pop(context);
        },
        onChanged: (value) async {
          showLoaderDialog(context);
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            eventType = value!;
            // logtype = value!;
            // _currentPage = 0;
          });
          // LogsPrint();
          eventListUpcoming();
          Navigator.pop(context);
        },
        selectedItem: eventType,
      ),
    );
  }

  Widget EventCardDisplay(BuildContext context, Events event, int index) {
    void eventDetailgo() async {
      String eventID = '';
      eventID = event.sId!;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('specificEvent', eventID);
      normalNavigation(EventDetailPage(event), context);
    }

    String startTime = event.startTime!;
    int m = int.parse(startTime.substring(5, 7));
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
          color: primaryColor1, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 14, top: 22, bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                handleOverflowText3(event.title ?? '', textcolor2, 18, 3),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      print(event.sId);
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ctext1(month[m - 1], textcolor2, 18),
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
                    handleOverflowText(event.tagLine!, containerColor, 11),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: containerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () {
                      normalNavigation(EventDetailPage(event), context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, left: 0, right: 0),
                      child: ctext1('Get Details', primaryColor1, 12),
                    ))
              ],
            ),
            const SizedBox(height: 14),
            checkParticipants(context, event)
          ],
        ),
      ),
    );
  }

  Widget typeofEventBar(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: eventTypeList.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {},
                child: ctext1(eventTypeList[index], textcolor2, 12));
          }),
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
                                deleteEvent(id.toString(), context);
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
