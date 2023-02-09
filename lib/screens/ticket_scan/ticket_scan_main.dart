// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/models/ticket_model_scan.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';
import 'package:http/http.dart' as http;
import '../../custom_widget/custom_text.dart';

class TicketScanMain extends StatefulWidget {
  const TicketScanMain({super.key});

  @override
  State<TicketScanMain> createState() => _TicketScanMainState();
}

class _TicketScanMainState extends State<TicketScanMain> {
  bool addcoinwidgetshow = false;
  Tickets selectedTicket = Tickets();
  Events event1 = Events();
  String auth_val = '';
  String ticket_id = '';
  String ticket_qr_value = 'Sample';

  Future checkInFunctio() async {
    showLoaderDialog(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    final response = await http.post(
      Uri.parse(checkIn_ticket_url + ticket_id),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Authorization': 'Bearer $auth_val'
      },
      // body: jsonEncode(<String, String>),
    );

    // print(response.body);
    var responseval = json.decode(response.body);
    Navigator.pop(context);
    successModal2(responseval.message, context, const TicketScanMain());
  }

  Future fetchTicketDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;

    final response = await http.get(
      Uri.parse(fetch_ticket_url + ticket_id),
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
    print(responseval);
    if (responseval['message'] == 'Ticket fetched successfully') {
      setState(() {
        ticket_qr_value = ticket_id;
        var responseData = responseval['ticket'];
        var responseData2 = responseval['event'];
        selectedTicket = Tickets.fromJson(responseData);
        event1 = Events.fromJson(responseData2);
      });
    }

    // print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const SimpleDrawerCustom(),
      appBar: customAppBar('Scan Ticket', Colors.orange),
      body: (ticket_qr_value != 'Sample')
          ? ticketSelectedWidget(context)
          : noTicketSelectedWidget(context),
    );
  }

  Widget ticketSelectedWidget(BuildContext context) {
    String name = "";
    name = selectedTicket.team!.name!;
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15, left: 20, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ctext('Your Ticket', containerColor),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: ticketWidget()),
            ],
          ),
          const SizedBox(height: 15),
          (selectedTicket.checkedIn == true)
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Center(
                            child: smbold1(
                                'Your Ticket is not valid for Checking In!'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : checkinButton(context),
          // const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    onPressed: () {
                      setState(() {
                        // qrvalue = 'Sample';
                        // user_id = '';
                        // selectedUser = User();
                        ticket_qr_value = 'Sample';
                        ticket_id = '';
                        selectedTicket = Tickets();
                        event1 = Events();
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
                            color: textcolor2,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Go Back',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: textcolor2),
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

  Widget checkinButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: containerColor),
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
            ticket_id = res;
            fetchTicketDetails();
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: smbold1('Scan New User'),
      ),
    );
  }

  Widget ticketWidget() {
    return Container(
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: textcolor2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ctext('ESPEKTRO', containerColor),
                    )),
                const Spacer(),
                ctext1(selectedTicket.ticketNumber ?? '', textcolor2, 14),
              ],
            ),
            const SizedBox(height: 10),
            teamWidget(),
            const SizedBox(height: 10),
            eventWidget()
          ],
        ),
      ),
    );
  }

  Widget eventWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: textcolor2),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ctext(event1.title ?? '', containerColor),
                      const Spacer(),
                      Icon(Icons.event, color: textcolor1, size: 22)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(FontAwesome.star, color: textcolor1, size: 20),
                      const SizedBox(width: 7),
                      ctext1(event1.eventOrganiserClub!.name ?? '', textcolor1,
                          14),
                      const Spacer(),
                      subtitletext('Organiser')
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.place_rounded,
                          color: containerColor, size: 20),
                      const SizedBox(width: 7),
                      subtitletext(event1.eventVenue ?? ''),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget teamWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: textcolor2),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ctext(selectedTicket.team!.name!, containerColor),
                      const Spacer(),
                      Icon(Elusive.group, color: containerColor, size: 22)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Typicons.user, color: containerColor, size: 20),
                      const SizedBox(width: 7),
                      ctext(selectedTicket.team!.members![0].name!,
                          containerColor),
                      const Spacer(),
                      subtitletext('Team Leader')
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(FontAwesome5.orcid, color: containerColor, size: 20),
                      const SizedBox(width: 7),
                      ctext1(selectedTicket.team!.members![0].espektroId!,
                          textcolor1, 12),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget noTicketSelectedWidget(BuildContext context) {
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
        smbold('No Tickets Detected! Scan QR Code'),
        smbold('to capture Ticket details.'),
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
                            appBarTitle: 'Scan Ticket',
                            lineColor: '#FFA500',
                          ),
                        ));
                    setState(() {
                      if (res is String) {
                        // qrvalue = res;
                        ticket_id = res;
                        fetchTicketDetails();
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
}
