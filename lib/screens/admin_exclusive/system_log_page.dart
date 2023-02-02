import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';

class SystemLogsPage extends StatefulWidget {
  const SystemLogsPage({super.key});

  @override
  State<SystemLogsPage> createState() => _SystemLogsPageState();
}

class _SystemLogsPageState extends State<SystemLogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('System Logs', Colors.orange),
    );
  }
}
