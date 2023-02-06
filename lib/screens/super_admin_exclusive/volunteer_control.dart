// ignore_for_file: non_constant_identifier_names, avoid_print, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/custom_widget/custom_container.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/volunteer_display_model.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';

class VolunteerControl extends StatefulWidget {
  const VolunteerControl({super.key});

  @override
  State<VolunteerControl> createState() => _VolunteerControlState();
}

class _VolunteerControlState extends State<VolunteerControl> {
  String auth_val = '';
  TextEditingController search_volunteer = TextEditingController();

  Future<List<VolunteerDisplayModel>> volunteer_detail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    final response = await http.get(
      Uri.parse(all_volunteer),
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

    var responseData = responseval["volunteers"];
    // print(responseData.length);

    List<VolunteerDisplayModel> volunteer1 = [];
    // print(responseData[0]['name']);

    for (int i = 0; i < responseData.length; i++) {
      // print(i);
      // print(responseData[i]['name']);

      VolunteerDisplayModel volunteer = VolunteerDisplayModel(
          sId: responseData[i]['_id'],
          name: responseData[i]['name'],
          email: responseData[i]['email'],
          phone: responseData[i]['phone'],
          events: responseData[i]['events'].cast<String>(),
          accessLevel: responseData[i]['accessLevel'],
          profileImageUrl: responseData[i]['profileImageUrl'],
          createdAt: responseData[i]['createdAt'],
          updatedAt: responseData[i]['updatedAt'],
          iV: responseData[i]['__v']);

      volunteer1.add(volunteer);
    }

    print(volunteer1.length);
    return volunteer1;
  }

  Future<Future<List<VolunteerDisplayModel>>> _refreshVolunteers(
      BuildContext context) async {
    setState(() {});
    return volunteer_detail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: VolunteerControlAppBar('Volunteer Control'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              //top Widget
              Expanded(
                child: SizedBox(
                  height: 300,
                  child: RefreshIndicator(
                    onRefresh: () => _refreshVolunteers(context),
                    child: FutureBuilder(
                      future: volunteer_detail(),
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
                                        bottom: 10, top: 10),
                                    child: volunteerDisplay(
                                        context,
                                        snapshot.data[index].name,
                                        snapshot.data[index].email,
                                        snapshot.data[index].phone,
                                        snapshot.data[index].accessLevel
                                            .toString(),
                                        snapshot.data[index].sId));
                              });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget topWidget() {
  //   return Row(
  //     children: [
  //       Flexible(
  //         flex: 6,
  //         child: tfield1(controller: search_volunteer, label: 'Volunteer ID'),
  //       ),
  //       const SizedBox(width: 12),
  //       Flexible(
  //         flex: 2,
  //         child:
  //       )
  //     ],
  //   );
  // }
}
