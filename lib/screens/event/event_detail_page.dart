import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appbar1('Event Details', context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      color: alltemp),
                  height: 600,
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [headtext("TITLE"), headtext("ID")],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: subtitletext(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: smbold1("tagline : checkmate"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: smbold("time : 00:00 to 00:00"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: smbold("venue : administrative building"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: smbold("Event cordinator : name"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            smbold("max participants"),
                            smbold("min participants")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
