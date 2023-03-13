import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/screens/dashboard/chartdata_model.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';
import 'package:countup/countup.dart';

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

    userlevel = level!;
    username = name!;
    useremail = email!;

    profileImage = pImage!;
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
      body: FutureBuilder(
        future: getAllDetails(),
        builder: (context, snapshot) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                graph(price, '23'),
                const SizedBox(height: 14),
                // transactionStats(context)
              ],
            ),
          );
        },
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
                  Countup(
                    begin: 0,
                    curve: Curves.easeInCirc,
                    end: 76,
                    duration: const Duration(seconds: 2),
                    separator: ',',
                    style: TextStyle(
                        fontSize: 18,
                        color: containerColor,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.bold),
                  ),
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
