import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
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
    34,
    67,
    14,
    60,
    14,
    50,
    43,
    65,
    86,
    38,
    98,
    45,
    56,
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
    showLoaderDialog(context);
    Timer(const Duration(seconds: 4), () {
      setState(() {
        period = val;
      });
      Navigator.pop(context);
    });
  }

  int period = 100;

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
                const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: displayCard(),
                ),
                const SizedBox(height: 14),
                ctext1('Hello, ', textcolor2, 18),
                helloWidget(),
                const SizedBox(height: 10),
                graph(price, '23'),
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
            changeCoinPeriod(100);
          },
          child: Container(
            decoration: (period == 100) ? selected1() : const BoxDecoration(),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: ctext1('Overview',
                  (period == 100) ? primaryColor1 : Colors.grey, 14),
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

  Widget userbase() {
    return Container();
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
          backgroundColor: primaryColor1,
          foregroundColor: primaryColor1,
          surfaceTintColor: primaryColor1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 14, bottom: 14, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ctext1('User Footfall', textcolor2, 18),
                  const Spacer(),
                  Icon(Typicons.chart_outline, color: textcolor2, size: 24),
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
                  ctext1('  Users', textcolor2, 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 170,
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
            const SizedBox(height: 4),
            graphBar(context)
          ],
        ),
      ),
    );
  }

  Widget displayCard() {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: const [],
      ),
    );
  }

  Widget helloWidget() {
    return Row(
      children: [
        ctext1(username, textcolor2, 22),
        const SizedBox(width: 10),
        SizedBox(
          height: 50,
          width: 50,
          child: Lottie.asset('assets/waving_hand.json', fit: BoxFit.contain),
        )
      ],
    );
  }
}
