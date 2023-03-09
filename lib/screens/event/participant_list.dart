// ignore_for_file: must_be_immutable, non_constant_identifier_names, library_prefixes

import 'dart:convert';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/participants_model.dart' as pEvent;

class ParticipantList extends StatefulWidget {
  ParticipantList(this.id, {super.key});
  String id;

  @override
  State<ParticipantList> createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  String auth_val = '';
  pEvent.ParticipantsModel event1 = pEvent.ParticipantsModel();

  Future<List<pEvent.Events>> getParticipants() async {
    List<pEvent.Events> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    final response = await http.get(
      Uri.parse(get_participants + widget.id.toString()),
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

    var responseData = responseval['events'];

    for (int i = 0; i < responseData.length; i++) {
      pEvent.Events e1 = pEvent.Events.fromJson(responseData[i]);
      list.add(e1);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      appBar: appbar1('Event Participants', context),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 300,
                  child: FutureBuilder(
                      future: getParticipants(),
                      builder: ((BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(child: loadingwidget()),
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: participantDisplay(
                                      context, snapshot.data[index]));
                            });
                      })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget participantDisplay(BuildContext context, pEvent.Events e1) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.4, color: containerColor),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 14, bottom: 14, left: 12, right: 12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Elusive.group_circled, color: containerColor, size: 28),
                ctext1('   Team Name', textcolor6, 16),
                const Spacer(),
                ctext1(e1.team!.name!, textcolor2, 18),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(EvaIcons.peopleOutline, color: containerColor, size: 28),
                ctext1('   Team Leader', textcolor6, 16),
                const Spacer(),
                ctext1(e1.userName!, textcolor2, 18),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ctext1("ID ${e1.userEspektroId!}", textcolor2, 16),
                const Spacer(),
                ctext1(e1.userEmail!, textcolor2, 12),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Maki.college, color: containerColor, size: 24),
                ctext1("    ${e1.userCollege!}", textcolor2, 16),
              ],
            ),
            const SizedBox(height: 20),
            addWinner(context, e1.userId!),
          ],
        ),
      ),
    );
  }

  Widget addWinner(BuildContext context, String userid) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: containerColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ctext1('Add as Winner', primaryColor1, 14),
              )),
        )
      ],
    );
  }
}
