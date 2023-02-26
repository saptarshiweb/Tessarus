// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_buttons.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/screens/event/event_custom_containers.dart';

import '../../custom_widget/custom_modal_routes.dart';
import '../../models/volunteer_display_model.dart';

class EventDetailPage extends StatefulWidget {
  EventDetailPage(this.event1, {super.key});
  Events event1;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  var imgList = [];
  bool showVol = false;
  String auth_val = '';
  String clubImageurl = '';
  loadImages(BuildContext context) async {
    setState(() {
      clubImageurl = widget.event1.eventOrganiserClub!.image!;
      for (int i = 0; i < widget.event1.eventImages!.length; i++) {
        imgList.add(widget.event1.eventImages![i].url);
      }
    });
  }

  Future volunteer_edit(BuildContext context, String name, String volID) async {
    showLoaderDialog(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? auth = prefs.getString("Auth");
    auth_val = auth!;

    var val1 = {
      'name': name,
      'events': [widget.event1.sId.toString()]
    };
    print(edit_volunteer + widget.event1.sId!);
    final response = await http.put(Uri.parse(edit_volunteer + volID),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
          'Authorization': 'Bearer $auth_val'
        },
        body: jsonEncode(val1));
    var responseval = json.decode(response.body);
    print(response.body);
    Navigator.pop(context); //stop loading widget
    if (responseval['statusCode'] != 200) {
      showErrorMessage(responseval['message'], context);
    } else {
      showSuccessMessage2(responseval['message'], context);
    }
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
    var responseData = responseval["volunteers"];
    List<VolunteerDisplayModel> volunteer1 = [];
    for (int i = 0; i < responseData.length; i++) {
      VolunteerDisplayModel volunteer =
          VolunteerDisplayModel.fromJson(responseData[i]);

      volunteer1.add(volunteer);
    }

    print(volunteer1.length);
    return volunteer1;
  }

  bool geninfo = true;
  bool desinfo = false;
  bool cooinfo = false;

  @override
  void initState() {
    loadImages(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: appbar1('Event Details', context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageShowWidget(),
              const SizedBox(height: 15),
              primaryInfo(),
              const SizedBox(height: 15),
              ebutton1(context, ctext1('Add CheckIn Access', primaryColor1, 14),
                  () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.9,
                        child: volunteerSelect(context),
                      );
                    });
              }),
              const SizedBox(height: 25),
              selectDetailType(context),
              const SizedBox(height: 20),
              (geninfo == true)
                  ? geninfoDisplay(context, widget.event1)
                  : const SizedBox(),
              (desinfo == true)
                  ? desinfoDisplay(context, widget.event1)
                  : const SizedBox(),
              (cooinfo == true)
                  ? cooinfoDisplay(context, widget.event1)
                  : const SizedBox(),
              const SizedBox(height: 15)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration selected1() {
    return BoxDecoration(
        color: containerColor, borderRadius: BorderRadius.circular(14));
  }

  Widget selectDetailType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            setState(() {
              geninfo = true;
              desinfo = false;
              cooinfo = false;
            });
          },
          child: Container(
            decoration: (geninfo == true) ? selected1() : const BoxDecoration(),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: ctext1('General Info',
                  (geninfo == true) ? primaryColor1 : Colors.grey, 14),
            ),
          ),
        ), //1 week
        GestureDetector(
          onTap: () async {
            setState(() {
              geninfo = false;
              desinfo = true;
              cooinfo = false;
            });
          },
          child: Container(
            decoration: (desinfo == true) ? selected1() : const BoxDecoration(),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: ctext1('Rules and Prizes',
                  (desinfo == true) ? primaryColor1 : Colors.grey, 14),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              geninfo = false;
              desinfo = false;
              cooinfo = true;
            });
          },
          child: Container(
            decoration: (cooinfo == true) ? selected1() : const BoxDecoration(),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: ctext1('Coordinators',
                  (cooinfo == true) ? primaryColor1 : Colors.grey, 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget primaryInfo() {
    int m = int.parse(widget.event1.startTime!.substring(5, 7));
    String day = widget.event1.startTime!.substring(8, 10);

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
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              // border: Border.all(color: containerColor, width: 1.4),
              borderRadius: BorderRadius.circular(12),
              color: primaryColor1),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ctext1(month[m - 1], textcolor2, 18),
                const SizedBox(height: 6),
                ctext1(day, containerColor, 16),
              ],
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: primaryColor1),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ctext1(widget.event1.title!, containerColor, 18),
                        // const Spacer(),
                        // ctext1(widget.event1.tagLine!, containerColor, 20),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ctext1(
                        'Organized By ${widget.event1.eventOrganiserClub!.name!}',
                        textcolor5,
                        14),
                    const SizedBox(height: 10),
                  ],
                ),
                const Spacer(),
                Container(
                  // width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      // border: Border.all(color: containerColor, width: 1.4),
                      borderRadius: BorderRadius.circular(12),
                      color: containerColor),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Icon(FontAwesome.star, color: primaryColor1, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget volunteerSelect(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(FontAwesome.cancel_circled),
            iconSize: 22,
            color: textcolor2),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            color: primaryColor,
            // height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: volunteer_detail(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loadingwidget(),
                        ],
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                child: volunteerDisplay(
                                    context, snapshot.data[index]));
                          });
                    }
                  }),
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
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

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
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
              const SizedBox(height: 20),
              Row(
                children: [
                  ctext1(vol(v.accessLevel.toString()), containerColor, 22),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      volunteer_edit(context, v.name!, v.sId!);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: containerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    child: ctext1('Give Access', primaryColor1, 12),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageShowWidget() {
    return Container(
      child: (imgList.isEmpty)
          ? Container()
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: imgList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imgList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
