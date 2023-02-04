import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/screens/event/ongoing_events.dart';
import 'package:tessarus_volunteer/screens/event/past_events.dart';
import 'package:tessarus_volunteer/screens/event/upcoming_events.dart';

class EventTabbar extends StatelessWidget {
  const EventTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Material(
              color: alltemp,
              child: TabBar(
                unselectedLabelColor: Colors.grey.shade300,
                indicatorWeight: 6.0,
                indicatorColor: Colors.deepPurple.shade600,
                labelColor: Colors.black,
                labelStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Ongoing'),
                  Tab(text: 'Past'),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 8,
            child: TabBarView(
                children: [UpcomingEvents(), OngoingEvents(), PastEvents()]),
          ),
        ],
      ),
    );
  }
}
