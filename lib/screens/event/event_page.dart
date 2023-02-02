import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Events', Colors.orange),
    );
  }
}
