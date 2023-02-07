// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'dart:convert';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/volunteer_model.dart';

import 'drawer/drawer_main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  Future LoginRequest(String email, String password) async {
    showLoaderDialog(context);
    final response = await http.post(
      Uri.parse(volunteer_login),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      String name = '';
      int level = 1;
      String email = '';
      String auth = '';
      String profileImage = '';

      VolunteerLogin vol1 = VolunteerLogin.fromJson(jsonDecode(response.body));
      if (vol1.volunteer?.name != null) {
        name = vol1.volunteer!.name!;
        level = vol1.volunteer!.accessLevel!;
        email = vol1.volunteer!.email!;
        auth = vol1.authToken!;
        profileImage = vol1.volunteer!.profileImageUrl!;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('signIn', true);
      await prefs.setString('Name', name);
      await prefs.setInt('Level', level);
      await prefs.setString('Email', email);
      await prefs.setString('Auth', auth);
      await prefs.setString('DrawerItem', 'Dasboard');
      await prefs.setString('profileImage', profileImage);

      Navigator.pop(context);
      easyNavigation(const DrawerScreen(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                tfield1(controller: email_controller, label: 'your Email'),
                const SizedBox(height: 10),
                tfield1(
                    controller: password_controller,
                    label: 'your Password',
                    obscuretext: true),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent.shade100),
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              currentFocus.focusedChild!.unfocus();
                            }
                            LoginRequest(email_controller.text,
                                password_controller.text);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: smbold('Confirm'),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
