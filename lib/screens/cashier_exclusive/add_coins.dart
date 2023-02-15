// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/user_model_qr.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';

class AddCoins extends StatefulWidget {
  const AddCoins({super.key});

  @override
  State<AddCoins> createState() => _AddCoinsState();
}

class _AddCoinsState extends State<AddCoins> {
  bool addcoinwidgetshow = false;
  User selectedUser = User();
  String auth_val = '';
  String qrvalue = 'Sample';
  String user_id = '';
  int amount = 0;
  TextEditingController addCoincontroller = TextEditingController();

  addCoinFunction() async {
    showLoaderDialog(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    var body = {'amount': addCoincontroller.text, 'userId': selectedUser.sId};
    final response = await http.post(Uri.parse(add_coin),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
          'Authorization': 'Bearer $auth_val'
        },
        body: json.encode(body));
    setState(() {
      addCoincontroller = TextEditingController();
      addcoinwidgetshow = false;
    });

    Navigator.pop(context);
    fetchUserDetails();
  }

  Future fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    var body = {'qrText': user_id};
    final response = await http.post(Uri.parse(user_qr_scan),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
          'Authorization': 'Bearer $auth_val'
        },
        // body: jsonEncode(<String, String>),

        body: json.encode(body));

    // print(response.body);
    var responseval = json.decode(response.body);
    // print(responseval);
    if (responseval['message'] == 'User fetched successfully') {
      setState(() {
        qrvalue = user_id;
        var responseData = responseval['user'];
        selectedUser = User.fromJson(responseData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const SimpleDrawerCustom(),
      appBar: customAppBar('Add Coins', containerColor),
      body: (qrvalue != 'Sample')
          ? SingleChildScrollView(
              child: userSelectedWidget(context, selectedUser))
          : noUserSelectedWidget(context),
    );
  }

  Widget userSelectedWidget(BuildContext context, User user1) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 35),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ctext1('  Selected User', textcolor2, 18),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: userProfileWidget(context, user1)),
            ],
          ),
          (addcoinwidgetshow == true)
              ? addCoinModalWidget(context)
              : const SizedBox(height: 0, width: 0),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: containerColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  onPressed: () async {
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SimpleBarcodeScannerPage(
                            scanType: ScanType.qr,
                            centerTitle: true,
                            appBarTitle: 'Scan User Profile',
                            lineColor: '#FFA500',
                          ),
                        ));
                    setState(() {
                      if (res is String) {
                        // qrvalue = res;
                        user_id = res;
                        fetchUserDetails();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: ctext1('Scan New User', textcolor5, 15),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    onPressed: () {
                      setState(() {
                        qrvalue = 'Sample';
                        user_id = '';
                        selectedUser = User();
                        // fetchUserDetails();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome.left,
                            color: containerColor,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Go Back',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: containerColor),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget userProfileWidget(BuildContext context, User user1) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: containerColor, width: 1),
          color: primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 18, bottom: 18, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                ctext1(user1.name ?? '', textcolor2, 18),
                const Spacer(), //Image Show
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(14)),
                  child: Image(
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      image: NetworkImage(user1.profileImageUrl ?? '')),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ctext1(user1.email ?? '', textcolor5, 12),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ctext1(user1.college ?? '', textcolor5, 15),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ctext1('Espektro ID ', textcolor5, 15),
                ctext1(user1.espektroId ?? '', containerColor, 14),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ctext1('Coins ', textcolor5, 16),
                const SizedBox(width: 9),
                Icon(FontAwesome5.magento, color: containerColor, size: 16),
                const SizedBox(width: 6),
                ctext1(user1.coins.toString(), textcolor5, 14),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      addcoinwidgetshow = true;
                    });
                  },
                  child: Row(
                    children: [
                      ctext1('Add Coin ', textcolor2, 14),
                      Icon(Iconic.plus_circle, color: containerColor, size: 18)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget noUserSelectedWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: containerColor),
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: PrettyQr(
                  elementColor: textcolor1,
                  data: '',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        smbold('No Users Detected! Scan QR Code'),
        smbold('to capture User details.'),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: containerColor),
                  onPressed: () async {
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SimpleBarcodeScannerPage(
                            scanType: ScanType.qr,
                            centerTitle: true,
                            appBarTitle: 'Scan User Profile',
                            lineColor: '#FFA500',
                          ),
                        ));
                    setState(() {
                      if (res is String) {
                        // qrvalue = res;
                        user_id = res;
                        fetchUserDetails();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: smbold1('Open Scanner'),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget addCoinModalWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: containerColor),
            color: primaryColor,
            borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 6),
          child: Column(
            children: [
              numfield1(controller: addCoincontroller, label: 'Coins'),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: containerColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          addCoinFunction();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: ctext1('Confirm', textcolor5, 14),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 0),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent),
                        onPressed: () {
                          setState(() {
                            addcoinwidgetshow = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesome.left,
                                color: allcancel,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: allcancel),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
