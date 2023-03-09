// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_buttons.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'dart:convert';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/new_event_model.dart';

import 'package:tessarus_volunteer/models/volunteer_model.dart';
import 'package:tessarus_volunteer/screens/dashboard/dashboard_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool showPassword = false;

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
    var responseval = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      String name = '';
      int level = 1;
      String email = '';
      String auth = '';
      String profileImage = '';
      String volId = '';

      VolunteerLogin vol1 = VolunteerLogin.fromJson(jsonDecode(response.body));
      if (vol1.volunteer?.name != null) {
        name = vol1.volunteer!.name!;
        level = vol1.volunteer!.accessLevel!;
        email = vol1.volunteer!.email!;
        auth = vol1.authToken!;
        profileImage = vol1.volunteer!.profileImageUrl!;
        volId = vol1.volunteer!.sId!;
      }
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('signIn', true);
      await prefs.setString('Name', name);
      await prefs.setInt('Level', level);
      await prefs.setString('Email', email);
      await prefs.setString('Auth', auth);
      await prefs.setString('VolID', volId);
      await prefs.setString('DrawerItem', 'Dashboard');
      await prefs.setString('profileImage', profileImage);
      await prefs.setBool('genInfoComplete', false);
      await prefs.setBool('comInfoComplete', false);
      await prefs.setBool('imgInfoComplete', false);
      await prefs.setBool('coordinatorInfoComplete', false);
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
          eventCoordinators: [],
          eventMaxParticipants: 1,
          eventMinParticipants: 1,
          eventOrganiserClub: EventOrganiserClub(name: '', image: ''),
          sponsors: []);
      String newEvent = jsonEncode(event1);
      await prefs.setString('newEvent', newEvent);

      Navigator.pop(context);
      easyNavigation(const DashboardMain(), context);
    } else {
      Navigator.pop(context);
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return errorModal2(responseval['message'], context);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/techtixLogo.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                ctext1('Tessarus Volunteer', containerColor, 22),
              ],
            ),
            const SizedBox(height: 50),
            tfield1(controller: email_controller, label: 'your Email'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: textfieldColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: TextFormField(
                controller: password_controller,
                obscureText: !showPassword,
                style: TextStyle(
                    color: textcolor2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                          (showPassword == false)
                              ? FontAwesome5.eye
                              : FontAwesome5.eye_slash,
                          color: containerColor,
                          size: 20)),
                  hintText: 'Enter your Password',
                  labelText: 'Enter your Password',
                  labelStyle: TextStyle(
                      color: textcolor5,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ebutton4(
                fun: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    currentFocus.focusedChild!.unfocus();
                  }
                  await Future.delayed(const Duration(milliseconds: 20));
                  LoginRequest(email_controller.text, password_controller.text);
                },
                t: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ctext1('Login', primaryColor1, 16),
                    const SizedBox(width: 4),
                    Icon(EvaIcons.arrowForwardOutline,
                        color: primaryColor1, size: 22)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
