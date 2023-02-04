import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

class OngoingEvents extends StatefulWidget {
  const OngoingEvents({super.key});

  @override
  State<OngoingEvents> createState() => _OngoingEventsState();
}

class _OngoingEventsState extends State<OngoingEvents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        'Ongoing',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
