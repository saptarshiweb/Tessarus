// ignore_for_file: non_constant_identifier_names, avoid_print, unused_local_variable, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/volunteer_display_model.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';

class VolunteerControl extends StatefulWidget {
  const VolunteerControl({super.key});

  @override
  State<VolunteerControl> createState() => _VolunteerControlState();
}

class _VolunteerControlState extends State<VolunteerControl> {
  String auth_val = '';
  
  TextEditingController search_volunteer = TextEditingController();
  Future deleteVolunteer(String id) async {
    String authVal = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? auth = prefs.getString("Auth");
    authVal = auth!;
    final response = await http.delete(
      Uri.parse("$remove_volunteer$id"),
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
    var responseval = jsonDecode(response.body);
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        context: context,
        builder: (context) {
          return successModal2(
              responseval['message']!, context, const VolunteerControl());
        });
  }

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
      VolunteerDisplayModel volunteer =
          VolunteerDisplayModel.fromJson(responseData[i]);

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
      backgroundColor: primaryColor,
      drawer: const SimpleDrawerCustom(),
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
                                        context, snapshot.data[index]));
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

  Widget volunteerDisplay(BuildContext context, VolunteerDisplayModel v) {
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

    return Container(
      decoration: BoxDecoration(
          color: primaryColor1, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ctext1(v.name ?? '', textcolor2, 18),
                    const SizedBox(height: 12),
                    ctext1(v.email ?? '', textcolor5, 12)
                  ],
                ),
                const Spacer(),
                (v.profileImageUrl == '')
                    ? Icon(
                        Typicons.user,
                        color: textcolor4,
                        size: 38,
                      )
                    : SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(v.profileImageUrl!)),
                      ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ctext1(vol(v.accessLevel.toString()), containerColor, 22),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesome.pencil_squared,
                        color: containerColor, size: 22)),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () {
                      deleteVolunteer(v.sId!);
                      volunteer_detail();
                    },
                    icon: Icon(FontAwesome5.trash_alt,
                        color: allcancel, size: 22))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
