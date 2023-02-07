import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';

class TicketScanMain extends StatefulWidget {
  const TicketScanMain({super.key});

  @override
  State<TicketScanMain> createState() => _TicketScanMainState();
}

class _TicketScanMainState extends State<TicketScanMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SimpleDrawerCustom(),
      appBar: customAppBar('Scan Ticket', Colors.orange),
    );
  }
}
