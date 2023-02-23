// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';

import '../../custom_widget/loader_widget.dart';
import '../drawer/drawer_custom_appbar.dart';
import 'payment_logs_model.dart';

class PaymentLogsMain extends StatefulWidget {
  const PaymentLogsMain({super.key});

  @override
  State<PaymentLogsMain> createState() => _PaymentLogsMainState();
}

class _PaymentLogsMainState extends State<PaymentLogsMain> {
  final int _numPages = 10;
  int _currentPage = 0;
  String logtype = 'All Logs';
  var items = ["All Logs", "COINS_ADDED", "COINS_USED"];
  String auth_val = '';
  String log_url = payment_logs;
  int dpp = 10;
  Future<List<Documents>> LogsPrint() async {
    List<Documents> log1 = [];

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
      appBar: customAppBar('Payment Logs', Colors.orange),
      body: pages[_currentPage],
      // card for elevation
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
        child: NumberPaginator(
          controller: NumberPaginatorController(),
          config: NumberPaginatorUIConfig(
              height: 40,
              buttonUnselectedForegroundColor: containerColor,
              buttonSelectedBackgroundColor: containerColor),
          numberPages: _numPages,
          onPageChange: (int index) async {
            showLoaderDialog(context);
            await Future.delayed(const Duration(seconds: 1));

            setState(() {
              _currentPage = index;
            });
            LogsPrint();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget logDisplayWidget(Documents l) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1.4, color: containerColor),
            color: primaryColor,
            borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ctext1(l.logType ?? '', containerColor, 15),
                ],
              ),
              const SizedBox(height: 8),
              ctext1(l.description ?? '', textcolor5, 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownWidgetLogType(BuildContext context) {
    return SingleChildScrollView(
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
            //change text color in popupWidget
            itemBuilder: (context, item, isSelected) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () async {
                  setState(() {
                    isSelected = true;
                    logtype = item;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ctext1(item, textcolor2, 16),
                  ],
                ),
              );
            },
            showSelectedItems: true,
            menuProps: MenuProps(backgroundColor: primaryColor)),
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
          showLoaderDialog(context);
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            logtype = value!;
            _currentPage = 0;
          });
          LogsPrint();
          Navigator.pop(context);
        },
        onChanged: (value) async {
          showLoaderDialog(context);
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            logtype = value!;
            _currentPage = 0;
          });
          LogsPrint();
          Navigator.pop(context);
        },
        selectedItem: logtype,
      ),
    );
  }
}
