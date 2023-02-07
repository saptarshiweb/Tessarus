// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:http/http.dart' as http;

class AddVolunteer extends StatefulWidget {
  const AddVolunteer({super.key});

  @override
  State<AddVolunteer> createState() => _AddVolunteerState();
}

class _AddVolunteerState extends State<AddVolunteer> {
  TextEditingController volunteer_name = TextEditingController();
  TextEditingController volunteer_email = TextEditingController();
  TextEditingController volunteer_phone = TextEditingController();
  TextEditingController volunteer_accessLevel = TextEditingController();
  String auth_val = '';
  Future volunteer_add(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    final response = await http.post(
      Uri.parse(add_volunteer),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Authorization': 'Bearer $auth_val'
      },
      body: jsonEncode(<String, String>{
        'name': volunteer_name.text,
        'email': volunteer_email.text,
        'phone': volunteer_phone.text,
        'accessLevel': volunteer_accessLevel.text
      }),
    );
    var responseval = json.decode(response.body);
    // print(response.body);
    if (responseval.length < 10) {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          context: context,
          builder: (context) {
            return errorModal2(responseval['message'], context);
          });
    } else {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          context: context,
          builder: (context) {
            return successModal2('Successfully Added Volunteer !!!', context);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar1('Add Volunteer', context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 40),
          child: Column(
            children: [
              tfield1(controller: volunteer_name, label: 'Name'),
              const SizedBox(height: 12),
              tfield1(controller: volunteer_email, label: 'Email'),
              const SizedBox(height: 12),
              tfield1(controller: volunteer_phone, label: 'Phone'),
              const SizedBox(height: 12),
              tfield1(controller: volunteer_accessLevel, label: 'Access Level'),
              const SizedBox(height: 24),
              //confirm add
              ElevatedButton(
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      currentFocus.focusedChild!.unfocus();
                    }
                    volunteer_add(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent.shade400),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        smbold('Confirm'),
                        const SizedBox(width: 14),
                        Icon(Typicons.user_add_outline,
                            color: textcolor1, size: 18),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
