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
    var body = {'amount': addCoincontroller.text, 'userId': user_id};
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

    print(response.body);
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
    print('0');
    // print(response.body);
    var responseval = json.decode(response.body);
    // print(responseval);
    if (responseval['message'] == 'User fetched successfully') {
      setState(() {
        qrvalue = user_id;
        var responseData = responseval['user'];
        selectedUser = User.fromJson(responseData);
        print(selectedUser.college);
      });
    }

    // print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Add Coins', alltemp),
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
          headtext('  Selected User'),
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
                  style: ElevatedButton.styleFrom(backgroundColor: alltemp),
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
                    child: smbold1('Scan New User'),
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
                            color: alltemp.withOpacity(0.5),
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Go Back',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: alltemp.withOpacity(0.5)),
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
          color: alltemp.withOpacity(0.2),
          borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              children: [
                smbold(user1.name ?? ''),
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
                subtitletext(user1.email ?? ''),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                subtitletext(user1.college ?? ''),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                smbold('Espektro ID '),
                smbold(user1.espektroId ?? ''),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                smbold('Coins '),
                const SizedBox(width: 9),
                Icon(FontAwesome5.magento, color: alltemp, size: 16),
                const SizedBox(width: 6),
                smbold(user1.coins.toString()),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //     backgroundColor: Colors.transparent,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12)),
                    //     context: context,
                    //     builder: (context) {
                    //       return addCoinModalWidget(context);
                    //     });

                    setState(() {
                      addcoinwidgetshow = true;
                    });
                  },
                  child: Row(
                    children: [
                      smbold('Add Coin '),
                      Icon(Iconic.plus_circle, color: alltemp, size: 22)
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
                  gradient: LinearGradient(colors: [
                    alltemp,
                    alltemp.withOpacity(0.7),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
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
                  style: ElevatedButton.styleFrom(backgroundColor: alltemp),
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
            color: alltemp.withOpacity(0.2),
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
                        style:
                            ElevatedButton.styleFrom(backgroundColor: alltemp),
                        onPressed: () async {
                          addCoinFunction();
                          // setState(() {
                          //   addcoinwidgetshow = false;
                          // });
                          // addCoinFunction();
                        },
                        child: smbold1('Confirm')),
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
                                color: allcancel.withOpacity(0.5),
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: allcancel.withOpacity(0.5)),
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
