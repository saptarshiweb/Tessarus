import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';

Widget sponsorinfoDisplay(BuildContext context, Events event1) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.20,
    child: ListView.builder(
        itemCount: event1.sponsors!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              decoration: BoxDecoration(
                color: primaryColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ctext1('Sponsor No. ${index + 1}', textcolor6, 18),
                        const Spacer(),
                        Icon(Icons.verified_user_rounded,
                            color: containerColor, size: 22),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(EvaIcons.personDoneOutline,
                            color: containerColor, size: 20),
                        const SizedBox(width: 15),
                        ctext1(event1.sponsors![index].name!, textcolor2, 16),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ctext1(event1.sponsors![index].type!, textcolor2, 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

Widget cooinfoDisplay(BuildContext context, Events event1) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.20,
    child: ListView.builder(
        itemCount: event1.eventCoordinators!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              decoration: BoxDecoration(
                color: primaryColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ctext1('Coordinator No. ${index + 1}', textcolor6, 18),
                        const Spacer(),
                        Icon(Icons.verified_user_rounded,
                            color: containerColor, size: 22),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(FontAwesome5.user_circle,
                            color: containerColor, size: 20),
                        const SizedBox(width: 15),
                        ctext1(event1.eventCoordinators![index].name!,
                            textcolor2, 16),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(FontAwesome5.phone_alt,
                            color: containerColor, size: 20),
                        const SizedBox(width: 15),
                        ctext1(event1.eventCoordinators![index].phone!,
                            textcolor2, 15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

Widget desinfoDisplay(BuildContext context, Events event1) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.25,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: htmlViewTextDisplay(
              context, event1.prizes!, 'Prizes', Icons.wallet_giftcard_rounded),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: htmlViewTextDisplay(
              context, event1.rules!, 'Rules', Icons.rule_sharp),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: htmlViewTextDisplay(context, event1.description!,
              'Description', Icons.description_sharp),
        ),
      ],
    ),
  );
}

Widget htmlViewTextDisplay(
    BuildContext context, String data, String header, IconData icon) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
        color: primaryColor1, borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 18, left: 25, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              ctext1(header, textcolor2, 18),
              const Spacer(),
              Icon(icon, color: containerColor, size: 24)
            ],
          ),
          const SizedBox(height: 14),
          Html(
            data: data,
            // style: event1.description,
            //style the html text
            style: {
              "body": Style(
                color: textcolor2,
                fontSize: FontSize(14),
                fontWeight: FontWeight.w400,
              ),
            },
          ),
        ],
      ),
    ),
  );
}

Widget geninfoDisplay(BuildContext context, Events event1) {
  String startDate = event1.startTime!.substring(0, 10);
  String startTime = event1.startTime!.substring(11, 16);
  return Container(
    decoration: BoxDecoration(
        color: primaryColor1, borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 18, left: 25, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              ctext1('General Information', textcolor2, 17),
              const Spacer(),
              Icon(Elusive.fire, color: containerColor, size: 24)
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ctext1('TagLine', textcolor6, 14),
              const Spacer(),
              handleOverflowText(event1.tagLine!, containerColor, 12),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ctext1('Date', textcolor6, 14),
              const Spacer(),
              ctext1('Time', textcolor6, 14)
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ctext1(startDate, containerColor, 16),
              const Spacer(),
              ctext1(startTime, containerColor, 16)
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ctext1('Event Venue', textcolor6, 14),
              const Spacer(),
              ctext1('Event Type', textcolor6, 14)
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              handleOverflowText(event1.eventVenue!, containerColor, 12),
              const Spacer(),
              ctext1(
                  event1.eventType!.substring(0, 1).toUpperCase() +
                      event1.eventType!.substring(1),
                  containerColor,
                  18)
            ],
          ),
        ],
      ),
    ),
  );
}
