import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/models/drawer_model.dart';
import 'package:tessarus_volunteer/screens/admin_exclusive/system_log_page.dart';
import 'package:tessarus_volunteer/screens/cashier_exclusive/add_coins.dart';
import 'package:tessarus_volunteer/screens/contact_us.dart';
import 'package:tessarus_volunteer/screens/dashboard/dashboard_main.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_construct.dart';
import 'package:tessarus_volunteer/screens/event/event_page.dart';
import 'package:tessarus_volunteer/screens/help_page.dart';
import 'package:tessarus_volunteer/screens/super_admin_exclusive/volunteer_control.dart';
import 'package:tessarus_volunteer/screens/ticket_scan/ticket_scan_main.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  DrawerItem currentItem = DrawerItems.event;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      mainScreenTapClose: true,

      // menuScreenTapClose: true,

      openDragSensitivity: 1000,
      closeDragSensitivity: 1000,
      borderRadius: 20,
      showShadow: true,
      menuBackgroundColor: drawer_back,
      disableDragGesture: true,
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
      ),
    );
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

      case DrawerItems.addcoin:
        return const AddCoins();

      case DrawerItems.volunteerControl:
        return const VolunteerControl();

      default:
        return const DashboardMain();
    }
  }
}
