// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/system_logs_model.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';

import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';

import '../../color_constants.dart';

class SystemLogsPage extends StatefulWidget {
  const SystemLogsPage({super.key});

  @override
  State<SystemLogsPage> createState() => _SystemLogsPageState();
}

class _SystemLogsPageState extends State<SystemLogsPage> {
  final int _numPages = 10;
  int _currentPage = 0;
  String logtype = 'All Logs';
  // List<Documents> log1 = [];

  var items = [
    "All Logs",
    "USER_SIGNUP",
    "USER_VERIFIED",
    "USER_LOGIN",
    "USER_UPDATED",
    "USER_PASSWORD_RESET",
    "EVENT_CREATED",
    "EVENT_UPDATED",
    "EVENT_DELETED",
    "EVENT_REGISTERED",
    "CHECKED_IN",
    "PAYMENT",
    "COINS_UPDATED",
    "EMAIL_SENT",
    "VOLUNTEER_CREATED",
    "VOLUNTEER_UPDATED",
    "VOLUNTEER_DELETED",
    "VOLUNTEER_LOGIN",
    "OTP_SENT",
    "OTP_VERIFIED",
  ];

  String auth_val = '';
  String log_url = all_logs;
  int dpp = 10;
  Future<List<Documents>> LogsPrint() async {
    List<Documents> log1 = [];

    // log_url = '$all_logs?dpp=$dpp';
    // if (logtype != 'All Logs') {
    //   log_url = '$log_url?&logType=$logtype';
    // }
    // int page1 = _currentPage + 1;
    // log_url += '&page=$page1';

    print(log_url);
    var queryParams = (logtype != 'All Logs')
        ? {'dpp': 10, 'logType': logtype, 'page': _currentPage + 1}
        : {'dpp': 10, 'page': _currentPage + 1};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    final response = await http.get(
      Uri.parse(log_url).replace(
        queryParameters:
            queryParams.map((key, value) => MapEntry(key, value.toString())),
      ),
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
    var responseData = responseval["logs"]["documents"];

    for (int i = 0; i < responseData.length; i++) {
      Documents l1 = Documents.fromJson(responseData[i]);
      log1.add(l1);
    }
    return log1;
  }

  // print(responseval);
  Future<Future<List<Documents>>> _refreshLogs(BuildContext context) async {
    setState(() {});
    return LogsPrint();
  }

  @override
  Widget build(BuildContext context) {
    var pages = List.generate(
      _numPages,
      (index) => Padding(
        padding:
            const EdgeInsets.only(top: 14, left: 18, right: 18, bottom: 10),
        child: Column(
          children: [
            dropDownWidgetLogType(context),
            const SizedBox(height: 15),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshLogs(context),
                child: FutureBuilder(
                    future: LogsPrint(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(child: loadingwidget()),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return logDisplayWidget(snapshot.data[index]);
                            });
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const SimpleDrawerCustom(),
      appBar: customAppBar('System Logs', Colors.orange),
      body: pages[_currentPage],
      // card for elevation
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
        child: NumberPaginator(
          controller: NumberPaginatorController(),
          config: NumberPaginatorUIConfig(
              height: 40,
              buttonUnselectedForegroundColor: alltemp,
              buttonSelectedBackgroundColor: alltemp),
          numberPages: _numPages,
          onPageChange: (int index) {
            setState(() {
              _currentPage = index;
            });
            LogsPrint();
          },
        ),
      ),
    );
  }

  Widget logDisplayWidget(Documents l) {
    String createdAt = '';
    createdAt = l.createdAt ?? '';
    String date = createdAt.substring(0, 10);
    String time = createdAt.substring(11, 16);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: primaryColor1.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ctext1(l.logType ?? '', textcolor2, 18),
                ],
              ),
              const SizedBox(height: 8),
              ctext1(l.description ?? '', textcolor2.withOpacity(0.8), 14),
              const SizedBox(height: 8),
              subtitletext('Created At:  $date $time'),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownWidgetLogType(BuildContext context) {
    return SingleChildScrollView(
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSelectedItems: true,
        ),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: textcolor2),
          dropdownSearchDecoration: InputDecoration(
            labelStyle: TextStyle(color: textcolor2),
            hintStyle: TextStyle(color: textcolor2),
            suffixIconColor: textcolor2,
            prefixStyle: TextStyle(color: textcolor2),
            labelText: "Select Log Type",
            hintText: "Log Type",
          ),
        ),
        onSaved: (value) async {
          setState(() {
            logtype = value!;
            _currentPage = 0;
          });
          LogsPrint();
        },
        onChanged: (value) async {
          setState(() {
            logtype = value!;
            _currentPage = 0;
          });
          LogsPrint();
        },
        selectedItem: logtype,
      ),
    );
  }
}
