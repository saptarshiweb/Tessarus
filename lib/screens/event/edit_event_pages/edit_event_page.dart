// ignore_for_file: use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, library_prefixes, avoid_print, must_be_immutable
import 'package:tessarus_volunteer/models/new_event_model.dart'
    as addEventModel;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/screens/event/event_exchange_functions.dart';
import '../../../color_constants.dart';
import '../../../custom_widget/custom_modal_routes.dart';
import '../../../custom_widget/custom_text.dart';
import '../../../custom_widget/loader_widget.dart';
import '../../../helper/helper_function.dart';
import '../../../models/api_url.dart';
import '../add_event_pages/add_coordinator.dart';
import '../add_event_pages/add_event_image.dart';
import '../add_event_pages/general_info_add.dart';
import '../add_event_pages/sponsor_info_add.dart';
import '../add_event_pages/text_editor_info_add.dart';
import '../event_page.dart';

class EditEventPage extends StatefulWidget {
  EditEventPage(this.id, {super.key});
  String id;

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  String auth_val = '';
  String eventID = 'flag';
  Events goBack = Events();
  Future eventEdit() async {
    //organiser club
    String clubName = '';
    String clubImage = '';
    showLoaderDialog(context);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    String str = '';
    str = prefs.getString('newEvent') ?? '';
    Map<String, dynamic> jsonDetails = {};
    jsonDetails = jsonDecode(str);
    var newEvent1 = Events.fromJson(jsonDetails);

    eventID = widget.id;
    newEvent1.startTime = dateConvert(newEvent1.startTime!);
    newEvent1.endTime = dateConvert(newEvent1.endTime!);

    if (newEvent1.eventOrganiserClub == null) {
      Navigator.pop(context);
      showErrorMessage('Club Details Must be added.', context);
    } else if (newEvent1.title == '') {
      Navigator.pop(context);
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return errorModal2(
                'Please Visit General Info and Add the necessary Details.',
                context);
          });
    } else if (newEvent1.description == '') {
      Navigator.pop(context);
      showErrorMessage(
          'Please visit Comprehensive Info and add the necessary details.',
          context);
    } else {
      clubName = newEvent1.eventOrganiserClub!.name!;
      clubImage = newEvent1.eventOrganiserClub!.image!;
      print(newEvent1.title);
      addEventModel.Events evFinal = addEventModel.Events(
          eventCoordinators: [], sponsors: [], eventImages: []);

      addEventModel.EventCoordinators c2 = addEventModel.EventCoordinators();
      for (int i = 0; i < newEvent1.eventCoordinators!.length; i++) {
        c2.name = newEvent1.eventCoordinators![i].name;
        c2.phone = newEvent1.eventCoordinators![i].phone;
        evFinal.eventCoordinators!.add(c2);
        c2 = addEventModel.EventCoordinators(name: '', phone: '');
      }
      var s2 = addEventModel.Sponsors();
      await Future.delayed(const Duration(seconds: 2));

      for (int i = 0; i < newEvent1.sponsors!.length; i++) {
        s2 = addEventModel.Sponsors(name: '', type: '', image: '');
        s2.name = newEvent1.sponsors![i].name.toString();
        s2.image = newEvent1.sponsors![i].image.toString();
        s2.type = newEvent1.sponsors![i].type.toString();
        evFinal.sponsors!.add(s2);
      }

      var e2 = addEventModel.EventImages();

      for (int i = 0; i < newEvent1.eventImages!.length; i++) {
        e2 = addEventModel.EventImages(url: '');

        e2.url = newEvent1.eventImages![i].url.toString();
        print(e2.url);
        evFinal.eventImages!.add(e2);
      }

      var body = {
        'title': newEvent1.title,
        'description': newEvent1.description,
        'tagLine': newEvent1.tagLine,
        'startTime': newEvent1.startTime,
        'endTime': newEvent1.endTime,
        'eventVenue': newEvent1.eventVenue,
        'rules': newEvent1.rules,
        'prizes': newEvent1.prizes,
        'eventImages': evFinal.eventImages,
        'eventType': newEvent1.eventType!.toLowerCase(),
        'eventMaxParticipants': newEvent1.eventMaxParticipants,
        'eventMinParticipants': newEvent1.eventMinParticipants,
        'eventPrice': newEvent1.eventPrice,
        'eventPriceForKGEC': newEvent1.eventPriceForKGEC,
        'eventOrganiserClub': {
          'name': newEvent1.eventOrganiserClub!.name,
          'image': newEvent1.eventOrganiserClub!.image
        },
        'eventCoordinators': evFinal.eventCoordinators,
        'sponsors': evFinal.sponsors,
        'otherPlatformUrl': newEvent1.otherPlatformUrl
      };
      final response = await http.put(Uri.parse(update_event + eventID),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
            'Authorization': 'Bearer $auth_val'
          },
          // body: jsonEncode(<String, String>),

          body: json.encode(body));

      var responseval = json.decode(response.body);

      if (responseval['statusCode'] != 200) {
        Navigator.pop(context);
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            context: context,
            builder: (context) {
              return errorModal2(responseval['message'], context);
            });
      } else {
        Navigator.pop(context);
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            context: context,
            builder: (context) {
              return successModal2(
                  responseval['message'], context, const EventPage());
            });

        await Future.delayed(const Duration(seconds: 1));
        resetToNormal(context);
        // resetToNormal(context);
      }
      print(newEvent1.eventType);

      print(response.body);
    }
  }

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
              resetToNormal2(context);
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
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              generalInfo(context),
              const SizedBox(height: 14),
              texteditorInfo(context),
              const SizedBox(height: 14),
              eventImageinfo(context),
              const SizedBox(height: 14),
              coordinatorInfo(context),
              const SizedBox(height: 14),
              sponsorInfo(context),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: containerColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            )),
                        onPressed: () async {
                          eventEdit();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
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
                                borderRadius: BorderRadius.circular(6),
                                side: BorderSide(
                                    width: 1, color: containerColor))),
                        onPressed: () async {
                          showLoaderDialog(context);
                          await Future.delayed(const Duration(seconds: 3));

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          Events event1 = Events(
                              title: '',
                              description: '',
                              tagLine: '',
                              startTime: '',
                              endTime: '',
                              eventVenue: '',
                              rules: '',
                              prizes: '',
                              eventImages: [],
                              eventType: '',
                              eventPrice: 0,
                              eventPriceForKGEC: 0,
                              eventCoordinators: [],
                              eventMaxParticipants: 1,
                              eventMinParticipants: 1,
                              sponsors: [],
                              otherPlatformUrl: '');
                          String newEvent = jsonEncode(event1);
                          await prefs.setString('newEvent', newEvent);
                          Navigator.pop(context);
                          showSuccessMessage('Event Entry Data all Deleted!',
                              context, const EventPage());
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
      ),
    );
  }

  Widget sponsorInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNavigation(const SponsorInfoAdd(), context);
      },
      child: Container(
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
                  ctext1('Event Sponsors', textcolor2, 22),
                  const SizedBox(height: 10),
                  ctext1('Add sponsor name, sponsor Type and banners',
                      textcolor5, 12)
                ],
              ),
              const Spacer(),
              Icon(FontAwesome.right_open, color: textcolor2, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget texteditorInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showLoaderDialog(context);
        Timer(const Duration(seconds: 2), () {
          Navigator.pop(context);
          normalNavigation(const TextEditorInfo(), context);
        });
      },
      child: Container(
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
                  ctext1(
                      'Event description, rules, prizes etc.', textcolor5, 12)
                ],
              ),
              const Spacer(),
              Icon(FontAwesome.right_open, color: textcolor2, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventImageinfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNavigation(const AddEventImage(), context);
      },
      child: Container(
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
                  ctext1('Add images by simply picking from gallery',
                      textcolor5, 12)
                ],
              ),
              const Spacer(),
              Icon(FontAwesome.right_open, color: textcolor2, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget coordinatorInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNavigation(const AddCoordinatorEvent(), context);
      },
      child: Container(
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
                  ctext1('Organizing Club, Coordinator Details etc.',
                      textcolor5, 12)
                ],
              ),
              const Spacer(),
              Icon(FontAwesome.right_open, color: textcolor2, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget generalInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNavigation(const AddGeneralInfoEvent(), context);
      },
      child: Container(
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
                  ctext1('Event name, date, time, Price etc.', textcolor5, 12)
                ],
              ),
              const Spacer(),
              Icon(FontAwesome.right_open, color: textcolor2, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
