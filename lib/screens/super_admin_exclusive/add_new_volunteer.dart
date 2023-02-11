// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/screens/super_admin_exclusive/volunteer_control.dart';

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
    showLoaderDialog(context);
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
    Navigator.pop(context); //stop loading widget
    if (responseval.length < 10) {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          context: context,
          builder: (context) {
            return errorModal2(
                responseval['message'], context);
          });
    } else {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          context: context,
          builder: (context) {
            return successModal2('Successfully Added Volunteer !!!', context,
                const VolunteerControl());
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: appbar1('Add Volunteer', context),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(FontAwesome.user_plus, color: containerColor, size: 120),
              const SizedBox(height: 40),
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
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: containerColor),
                          borderRadius: BorderRadius.circular(14))),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ctext1('Confirm', textcolor2.withOpacity(0.8), 16),
                        const SizedBox(width: 14),
                        Icon(Typicons.user_add_outline,
                            color: textcolor2.withOpacity(0.8), size: 16),
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
