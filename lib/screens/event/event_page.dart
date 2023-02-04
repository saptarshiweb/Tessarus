import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:tessarus_volunteer/screens/event/event_tabbar.dart';
import 'package:tessarus_volunteer/screens/event/ongoing_events.dart';
import 'package:tessarus_volunteer/screens/event/past_events.dart';
import 'package:tessarus_volunteer/screens/event/upcoming_events.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final List<Widget> _eventTabs = [
    const UpcomingEvents(),
    const OngoingEvents(),
    const PastEvents()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Events', Colors.orange),
      body: Column(
        children: const [
          Expanded(child: EventTabbar()),
        ],
      ),
    );
  }
}
