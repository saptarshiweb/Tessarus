// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/drawer/simple_drawer_custom.dart';
import 'package:tessarus_volunteer/screens/event/event_tabbar.dart';
import 'package:tessarus_volunteer/screens/event/upcoming_events.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final List<Widget> _eventTabs = [
    const UpcomingEvents('upcoming'),
    const UpcomingEvents('ongoing'),
    const UpcomingEvents('past'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customAppBar('Events', Colors.orange),
      backgroundColor: primaryColor,
      drawer: const SimpleDrawerCustom(),
      appBar: eventsPageAppBar('Events', alltemp),
      body: Column(
        children: const [
          Expanded(child: EventTabbar()),
        ],
      ),
    );
  }
}
