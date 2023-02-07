import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar1('Event Details', context),
      body: Column(
        children: const [],
      ),
    );
  }
}
