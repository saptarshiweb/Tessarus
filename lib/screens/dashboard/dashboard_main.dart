import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/screens/dashboard/chartdata_model.dart';
import 'package:tessarus_volunteer/screens/dashboard/dashboard_custom_widgets.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';
import 'package:http/http.dart' as http;

class DashboardMain extends StatefulWidget {
  const DashboardMain({super.key});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  Color dashboardcol1 = textcolor1;
  int userlevel = 1;
  String username = '';
  String useremail = '';
  String profileImage = '';
  String auth_val = '';

  //Stat Variables
  String total_users = '0';
  String total_events = '0';
  String total_logs = '0';

  String kgec_students = '0';
  String numCollege = '0';
  String cse = '0';
  String it = '0';
  String ece = '0';
  String ee = '0';
  String me = '0';
  String other = '0';

  //year wise
  String first_year = '0';
  String second_year = '0';
  String third_year = '0';
  String fourth_year = '0';

  //Event Wise
  List eventname = [];
  List ticketcount = [];
  Map<String, int> userCollege = {};

  //log wise
  List logname = [];
  List logcount = [];
  var price = [
    12,
    25,
    12,
    34,
    35,
    80,
    76,
    87,
    100,
    67,
    89,
    65,
    45,
    52,
    54,
    33,
    21,
    14,
    10,
    9,
    3,
    4,
    5,
    77
  ];
  Future getAllDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('userLevel', 2);
    final int? level = prefs.getInt("Level");
    final String? name = prefs.getString("Name");
    final String? email = prefs.getString("Email");

    final String? pImage = prefs.getString("profileImage");
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    userlevel = level!;
    username = name!;
    useremail = email!;
    profileImage = pImage!;

    //USER RESPONSE API
    final userResponse = await http.get(
      Uri.parse(user_analytics_url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Authorization': 'Bearer $auth_val'
      },
    );
    var userval = json.decode(userResponse.body);

    if (userval['total'] != null) {
      total_users = userval['total'].toString();
    }

    Map<String, dynamic> data = jsonDecode(userResponse.body);

    // Access necessary fields to extract stats
    int total = data['total'];
    List<dynamic> collegeList = data['totalParamList']['college'];
    // List<dynamic> degreeList = data['totalParamList']['degree'];
    List<dynamic> yearList = data['totalParamList']['year'];
    List<dynamic> streamList = data['totalParamList']['stream'];
    numCollege = collegeList.length.toString();
    //stream wise assign
    for (int i = 0; i < collegeList.length; i++) {
      Map<String, dynamic> collegeData = collegeList[i];
      if (collegeData.containsKey('Kalyani Government Engineering College')) {
        kgec_students =
            collegeData['Kalyani Government Engineering College'].toString();
      }
    }
    //in the same way asssign stream wise
    for (int i = 0; i < streamList.length; i++) {
      Map<String, dynamic> streamData = streamList[i];
      if (streamData.containsKey('CSE')) {
        cse = streamData['CSE'].toString();
      }
      if (streamData.containsKey('IT')) {
        it = streamData['IT'].toString();
      }
      if (streamData.containsKey('ECE')) {
        ece = streamData['ECE'].toString();
      }
      if (streamData.containsKey('EE')) {
        ee = streamData['EE'].toString();
      }
      if (streamData.containsKey('ME')) {
        me = streamData['ME'].toString();
      }
      if (streamData.containsKey('Other')) {
        other = streamData['Other'].toString();
      }
    }
    //in the same way assign year wise
    for (int i = 0; i < yearList.length; i++) {
      Map<String, dynamic> yearData = yearList[i];
      if (yearData.containsKey('1')) {
        first_year = yearData['1'].toString();
      }
      if (yearData.containsKey('2')) {
        second_year = yearData['2'].toString();
      }
      if (yearData.containsKey('3')) {
        third_year = yearData['3'].toString();
      }
      if (yearData.containsKey('4')) {
        fourth_year = yearData['4'].toString();
      }
    }

    //EVENT RESPONSE API
    final eventResponse = await http.get(
      Uri.parse(event_analytics_url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Authorization': 'Bearer $auth_val'
      },
    );
    var eventval = json.decode(eventResponse.body);

    //in the same way assign event wise
    Map<String, dynamic> eventdata = jsonDecode(eventResponse.body);
    List<dynamic> eventList = eventdata['eventAnalytics'];
    total_events = eventList.length.toString();
    for (int i = 0; i < eventList.length; i++) {
      Map<String, dynamic> eventData = eventList[i];
      eventname.add(eventData['title'].toString());
      ticketcount.add(eventData['numTickets'].toString());
    }

    //LOG RESPONSE API
    final logResponse = await http.get(
      Uri.parse(log_analytics_url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Authorization': 'Bearer $auth_val'
      },
    );
    var logval = json.decode(logResponse.body);
    //in the same way assign log wise
    Map<String, dynamic> logdata = jsonDecode(logResponse.body);
    List<dynamic> logList = logdata['Log Types'];
    total_logs = logList.length.toString();

    for (int i = 0; i < logList.length; i++) {
      Map<String, dynamic> logData = logList[i];
      logname.add(logData['_id'].toString());
      logcount.add(logData['count'].toString());
    }
  }

  Future changeCoinPeriod(int val) async {
    setState(() {
      period = val;
    });
  }

  int period = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const SimpleDrawerCustom(),
      appBar: customAppBar('Dashboard', Colors.orange),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getAllDetails(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  graph(price, '23'),
                  headerContainer(context, 'User Analytics', EvaIcons.activity),
                  const SizedBox(height: 10),
                  userStats(context),
                  const SizedBox(height: 10),
                  headerContainer(
                      context, 'Event Analytics', EvaIcons.activity),
                  const SizedBox(height: 10),
                  eventStats(context),
                  const SizedBox(height: 10),
                  headerContainer(context, 'Log Analytics', EvaIcons.activity),
                  const SizedBox(height: 10),
                  logStats(context),
                  const SizedBox(height: 20)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget logStats(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: containerColor, width: 1.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  ctext1('Total Number of Logs', textcolor6, 12),
                  const SizedBox(width: 10),
                  countWidget(context, total_logs),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: logname.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor1,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ctext1(changeVal(logname[index]),
                                        textcolor6, 12),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    ctext1('Log Count', textcolor6, 12),
                                    const SizedBox(width: 10),
                                    countWidget(context, logcount[index]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ));
  }

  Widget eventStats(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: containerColor, width: 1.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  ctext1('Total Number of Events', textcolor6, 12),
                  const SizedBox(width: 10),
                  countWidget(context, total_events),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventname.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor1,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ctext1(eventname[index], textcolor6, 12),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    ctext1('Tickets Issued', textcolor6, 12),
                                    const SizedBox(width: 10),
                                    countWidget(context, ticketcount[index]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ));
  }

  Widget userStats(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: containerColor, width: 1.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                ctext1('No. of Colleges Registered', textcolor6, 14),
                const Spacer(),
                countWidget(context, numCollege),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ctext1('Total Registrations', textcolor6, 12),
                const SizedBox(width: 10),
                countWidget(context, total_users),
                const Spacer(),
                ctext1('KGEC Registrations', textcolor6, 12),
                const SizedBox(width: 10),
                countWidget(context, kgec_students),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ctext1('CSE', textcolor6, 14),
                countWidget(context, cse),
                ctext1('IT', textcolor6, 14),
                countWidget(context, it),
                ctext1('ECE', textcolor6, 14),
                countWidget(context, ece),
                ctext1('EE', textcolor6, 14),
                countWidget(context, ee),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ctext1('ME', textcolor6, 14),
                const SizedBox(width: 7),
                countWidget(context, me),
                const SizedBox(width: 15),
                ctext1('Other', textcolor6, 14),
                const SizedBox(width: 7),
                countWidget(context, other),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ctext1('Year Wise Split', textcolor6, 16),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ctext1('First Year', textcolor6, 14),
                countWidget(context, first_year),
                ctext1('Second Year', textcolor6, 14),
                countWidget(context, second_year),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ctext1('Third Year', textcolor6, 14),
                countWidget(context, third_year),
                ctext1('Fourth Year', textcolor6, 14),
                countWidget(context, fourth_year),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration selected1() {
    return BoxDecoration(
        color: containerColor, borderRadius: BorderRadius.circular(14));
  }

  Widget graphBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            changeCoinPeriod(60);
          },
          child: Container(
            decoration: (period == 60) ? selected1() : const BoxDecoration(),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: ctext1(
                  'Overview', (period == 60) ? primaryColor1 : Colors.grey, 14),
            ),
          ),
        ), //1 week
        GestureDetector(
          onTap: () async {
            changeCoinPeriod(20);
          },
          child: Container(
            decoration: (period == 20) ? selected1() : const BoxDecoration(),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: ctext1('Last 1 week',
                  (period == 20) ? primaryColor1 : Colors.grey, 14),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            changeCoinPeriod(10);
          },
          child: Container(
            decoration: (period == 10) ? selected1() : const BoxDecoration(),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: ctext1(
                  'Today', (period == 10) ? primaryColor1 : Colors.grey, 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget graph(var price, String v) {
    List<ChartData> data = [];

    for (int i = 0; i < min(price.length, period); i++) {
      int tem = price[i];

      data.add(ChartData(i + 100, tem));
    }

    Color col = Colors.deepPurpleAccent.shade400;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: primaryColor1,
          surfaceTintColor: primaryColor1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 14),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 14, bottom: 14, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ctext1('User Footfall', textcolor6, 18),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 1.5, color: containerColor)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 10, right: 10),
                      child: ctext1('Espektro', textcolor6, 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: Row(
                children: [
                  countWidget(context, total_users),
                  ctext1('  Users', textcolor6, 17),
                ],
              ),
            ),
            // const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              width: double.infinity,
              child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  enableAxisAnimation: true,
                  primaryXAxis: CategoryAxis(isVisible: false),
                  primaryYAxis: CategoryAxis(isVisible: false),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<ChartData, String>>[
                    LineSeries(
                        markerSettings: MarkerSettings(
                            isVisible: true,
                            color: containerColor,
                            shape: DataMarkerType.circle),
                        animationDelay: 1,
                        animationDuration: 3,
                        dataSource: data,
                        width: 3.2,
                        color: col,
                        xValueMapper: (ChartData data, _) =>
                            data.val1.toString(),
                        yValueMapper: (ChartData data, _) => data.val2)
                  ]),
            ),
            const SizedBox(height: 6),
            graphBar(context)
          ],
        ),
      ),
    );
  }
}
