// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/ticket_model_scan.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_widget/ticket_widget.dart';

import '../../custom_widget/custom_text.dart';

class TicketScanMain extends StatefulWidget {
  const TicketScanMain({super.key});

  @override
  State<TicketScanMain> createState() => _TicketScanMainState();
}

class _TicketScanMainState extends State<TicketScanMain> {
  bool addcoinwidgetshow = false;
  Tickets selectedTicket = Tickets();
  String auth_val = '';
  String ticket_id = '';
  String ticket_qr_value = 'Sample';
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
        selectedTicket = Tickets.fromJson(responseData);
      });
    }

    // print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(flex: 1, child: ctext('Your Ticket', alltemp)),
          const SizedBox(height: 10),
          Expanded(flex: 14, child: ticketWidget()),
        ],
      ),
    );
  }

  Widget checkinButton(BuildContext context) {
    return ElevatedButton(
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
          color: alltemp, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TicketWidget(
          width: double.maxFinite,
          height: double.minPositive,
          isCornerRounded: true,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [],
          ),
        ),
      ),
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
        smbold('No Tickets Detected! Scan QR Code'),
        smbold('to capture Ticket details.'),
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
