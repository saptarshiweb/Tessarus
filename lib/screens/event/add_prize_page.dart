// ignore_for_file: use_build_context_synchronously, must_be_immutable, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/custom_widget/custom_buttons.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';

class AddPrizePage extends StatefulWidget {
  AddPrizePage(this.eventid, this.userid, {super.key});
  String eventid;
  String userid;

  @override
  State<AddPrizePage> createState() => _AddPrizePageState();
}

class _AddPrizePageState extends State<AddPrizePage> {
  String auth_val = '';
  TextEditingController amount = TextEditingController();
  TextEditingController position = TextEditingController();

  Future addPrize(BuildContext contex) async {
    showLoaderDialog(context);
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");

    auth_val = auth!;
    print(widget.eventid);
    print(widget.userid);
    final response = await http.post(
      Uri.parse(add_prize),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Authorization': 'Bearer $auth_val'
      },
      body: jsonEncode(<String, String>{
        "userId": widget.userid,
        "eventId": widget.eventid,
        "position": position.text.toString(),
        "prize": "Rs. ${amount.text}"
      }),
    );

    var responseval = json.decode(response.body);
    print(responseval);
    Navigator.pop(context);
    if (responseval['statusCode'] == 200) {
      showSuccessMessage2(responseval['message'], context);
    } else {
      showErrorMessage(responseval['message'], context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: appbar1('Add Prize', context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              numfield1(controller: amount, label: 'Prize Amount (in Rs.)'),
              const SizedBox(height: 20),
              numfield1(controller: position, label: 'Winner Position'),
              const SizedBox(height: 20),
              ebutton4(
                  fun: () async {
                    if (amount.text == '') {
                      showErrorMessage('Prize Money cannot be empty', context);
                    } else {
                      addPrize(context);
                    }
                  },
                  t: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ctext1('Add Reward', primaryColor1, 12),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
