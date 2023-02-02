import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/models/drawer_model.dart';
import 'package:tessarus_volunteer/screens/admin_exclusive/system_log_page.dart';
import 'package:tessarus_volunteer/screens/contact_us.dart';
import 'package:tessarus_volunteer/screens/dashboard/dashboard_main.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_construct.dart';
import 'package:tessarus_volunteer/screens/event/event_page.dart';
import 'package:tessarus_volunteer/screens/help_page.dart';
import 'package:tessarus_volunteer/screens/ticket_scan/ticket_scan_main.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  DrawerItem currentItem = DrawerItems.event;
  checkVolunteerLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('userLevel', 2);
    final int? level = prefs.getInt("Level");

    return level;
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        style: DrawerStyle.defaultStyle,
        borderRadius: 20,
        showShadow: true,
        menuBackgroundColor: drawer_back,
        angle: 0,
        slideWidth: MediaQuery.of(context).size.width * 0.75,
        mainScreen: getScreen(),
        menuScreen: Builder(
          builder: (context) => DrawerConstruct(
              currentItem: currentItem,
              onSelectedItem: (item) {
                setState(() {
                  currentItem = item;
                });
                ZoomDrawer.of(context)!.close();
              }),
        ));
  }

  Widget getScreen() {
    switch (currentItem) {
      case DrawerItems.dashboard:
        return const DashboardMain();

      case DrawerItems.event:
        return const EventPage();

      case DrawerItems.systemlogs:
        return const SystemLogsPage();

      case DrawerItems.ticketscan:
        return const TicketScanMain();

      case DrawerItems.contact:
        return const ContactUs();

      case DrawerItems.help:
        return const HelpPage();

      default:
        return const DashboardMain();
    }
  }
}
