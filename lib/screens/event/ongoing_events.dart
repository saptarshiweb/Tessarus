import 'package:flutter/material.dart';

class OngoingEvents extends StatefulWidget {
  const OngoingEvents({super.key});

  @override
  State<OngoingEvents> createState() => _OngoingEventsState();
}

class _OngoingEventsState extends State<OngoingEvents> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Ongoing',
      style: TextStyle(color: Colors.black),
    );
  }
}
