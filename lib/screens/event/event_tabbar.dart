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
              elevation: 1,
              shadowColor: primaryColor,
              color: primaryColor,
              child: TabBar(
                unselectedLabelColor: Colors.grey.shade400,
                indicatorWeight: 3.0,
                indicatorColor: containerColor,
                labelColor: textcolor2,
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
