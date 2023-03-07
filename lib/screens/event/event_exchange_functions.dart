// ignore_for_file: use_build_context_synchronously, library_prefixes

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/models/new_event_model.dart' as addEvent1;

import '../../helper/helper_function.dart';

import 'edit_event_pages/edit_event_page.dart';

resetToNormal(BuildContext context) async {
  showLoaderDialog(context);
  Future.delayed(const Duration(seconds: 2));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String str = '';
  str = prefs.getString('copyEvent') ?? '';
  Map<String, dynamic> jsonDetails = {};
  jsonDetails = jsonDecode(str);
  var newEvent1 = Events.fromJson(jsonDetails);
  await prefs.setString('newEvent', jsonEncode(newEvent1));
  Navigator.pop(context);
  Navigator.pop(context);
}

declareTemporary(BuildContext context, Events event1) async {
  showLoaderDialog(context);
  Future.delayed(const Duration(seconds: 2));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String str = '';
  str = prefs.getString('newEvent') ?? '';
  Map<String, dynamic> jsonDetails = {};
  jsonDetails = jsonDecode(str);
  var newEvent1 = Events.fromJson(jsonDetails);
  await prefs.setString('copyEvent', jsonEncode(newEvent1));
  addEvent1.Events sendEvent = addEvent1.Events(
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
      eventCoordinators: [],
      eventMaxParticipants: 1,
      eventMinParticipants: 1,
      eventOrganiserClub: addEvent1.EventOrganiserClub(name: '', image: ''),
      sponsors: []);
  //copy to sendEvent from event1
  sendEvent.title = event1.title;
  sendEvent.description = event1.description;
  sendEvent.tagLine = event1.tagLine;
  sendEvent.startTime = event1.startTime;
  sendEvent.endTime = event1.endTime;
  sendEvent.eventVenue = event1.eventVenue;
  sendEvent.rules = event1.rules;
  sendEvent.prizes = event1.prizes;
  var evImage = addEvent1.EventImages();
  for (int i = 0; i < event1.eventImages!.length; i++) {
    evImage.url = event1.eventImages![i].url;
    sendEvent.eventImages!.add(evImage);
  }
  sendEvent.eventType = event1.eventType;
  sendEvent.eventPrice = event1.eventPrice;
  var evCoord = addEvent1.EventCoordinators();

  for (int i = 0; i < event1.eventCoordinators!.length; i++) {
    evCoord.name = event1.eventCoordinators![i].name;
    evCoord.phone = event1.eventCoordinators![i].phone;
    sendEvent.eventCoordinators!.add(evCoord);
  }
  sendEvent.eventMaxParticipants = event1.eventMaxParticipants;
  sendEvent.eventMinParticipants = event1.eventMinParticipants;
  sendEvent.eventOrganiserClub!.image = event1.eventOrganiserClub!.image;
  sendEvent.eventOrganiserClub!.name = event1.eventOrganiserClub!.name;
  var evSpon = addEvent1.Sponsors();
  for (int i = 0; i < event1.sponsors!.length; i++) {
    evSpon.name = event1.sponsors![i].name;
    evSpon.image = event1.sponsors![i].image;
    sendEvent.sponsors!.add(evSpon);
  }
  await prefs.setString('newEvent', jsonEncode(sendEvent));
  Navigator.pop(context);
  normalNavigation(EditEventPage(event1.sId!), context);
}
