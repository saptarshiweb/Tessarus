import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({super.key});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SimpleDrawerCustom(),
      appBar: customAppBar('Dashboard', Colors.orange),
      body: Center(
        child: smtext('Hello'),
      ),
    );
  }
}
