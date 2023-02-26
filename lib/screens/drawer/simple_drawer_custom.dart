// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/screens/admin_exclusive/payment_logs_main.dart';
import 'package:tessarus_volunteer/screens/admin_exclusive/system_log_page.dart';
import 'package:tessarus_volunteer/screens/cashier_exclusive/add_coins.dart';
import 'package:tessarus_volunteer/screens/contact_us.dart';
import 'package:tessarus_volunteer/screens/dashboard/dashboard_main.dart';
import 'package:tessarus_volunteer/screens/event/event_page.dart';
import 'package:tessarus_volunteer/screens/help_page.dart';
import 'package:tessarus_volunteer/screens/login_screen.dart';
import 'package:tessarus_volunteer/screens/splash_screens/splash1.dart';
import 'package:tessarus_volunteer/screens/super_admin_exclusive/volunteer_control.dart';
import 'package:tessarus_volunteer/screens/ticket_scan/ticket_scan_main.dart';

class SimpleDrawerCustom extends StatefulWidget {
  const SimpleDrawerCustom({super.key});

  @override
  State<SimpleDrawerCustom> createState() => _SimpleDrawerCustomState();
}

class _SimpleDrawerCustomState extends State<SimpleDrawerCustom> {
  String dval = "";
  int userlevel = 1;
  String username = '';
  String useremail = '';
  String profileImage = '';
  Future getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('userLevel', 2);
    final int? level = prefs.getInt("Level");
    final String? name = prefs.getString("Name");
    final String? email = prefs.getString("Email");
    final String? drawerval = prefs.getString("DrawerItem");
    final String? pImage = prefs.getString("profileImage");

    userlevel = level!;
    username = name!;
    useremail = email!;
    dval = drawerval!;
    profileImage = pImage!;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.76,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: Colors.transparent,
      child: FutureBuilder(
        future: getDetails(),
        builder: (context, snapshot) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: primaryColor1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      topbar(context),
                      const SizedBox(height: 18),
                      profileWidget(context),
                      const SizedBox(height: 20),
                      DrawerListItem(context, 'Dashboard',
                          Elusive.group_circled, const DashboardMain()),
                      DrawerListItem(context, 'Event', Octicons.calendar,
                          const EventPage()),
                      (userlevel >= 2)
                          ? DrawerListItem(
                              context,
                              'Ticket Scan',
                              Icons.qr_code_scanner_rounded,
                              const TicketScanMain())
                          : const SizedBox(),
                      (userlevel >= 2)
                          ? DrawerListItem(context, 'Add Coins',
                              FontAwesome5.rupee_sign, const AddCoins())
                          : const SizedBox(),
                      (userlevel == 4)
                          ? DrawerListItem(context, 'Volunteer Control',
                              RpgAwesome.heavy_shield, const VolunteerControl())
                          : const SizedBox(),
                      (userlevel >= 3)
                          ? DrawerListItem(context, 'System Logs',
                              Typicons.cog_outline, const SystemLogsPage())
                          : const SizedBox(),
                      (userlevel >= 3)
                          ? DrawerListItem(context, 'Payment Logs',
                              FontAwesome.rupee, const PaymentLogsMain())
                          : const SizedBox(),
                      (userlevel <= 2)
                          ? DrawerListItem(
                              context, 'Help', Icons.help, const HelpPage())
                          : const SizedBox(),
                      (userlevel <= 2)
                          ? DrawerListItem(context, 'Contact',
                              Icons.contact_page, const ContactUs())
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: logoutButton(context),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget topbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            FontAwesome5.empire,
            color: containerColor,
            size: 34,
          ),
          const SizedBox(width: 20),
          Text(
            'Tessarus',
            style: TextStyle(
              color: textcolor2,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(EvaIcons.arrowCircleLeftOutline,
                  color: containerColor, size: 26))
        ],
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: containerColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
        onPressed: () async {
          easyNavigation(const SplashScreen1(LoginScreen(), 5), context);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('signIn', false);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesome5.sign_out_alt, color: primaryColor1, size: 20),
              const SizedBox(width: 8),
              ctext1('Logout', primaryColor1, 16)
            ],
          ),
        ));
  }

  Widget profileWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 5, bottom: 4),
      child: Row(
        children: [
          (profileImage == '')
              ? Icon(
                  Typicons.user,
                  color: textcolor4,
                  size: 38,
                )
              : SizedBox(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(profileImage)),
                ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ctext1(username, textcolor2, 18),
              const SizedBox(height: 2),
              ctext1(useremail, textcolor5, 12)
            ],
          )
        ],
      ),
    );
  }

  BoxDecoration dec1() {
    return BoxDecoration(
        color: textfieldColor,
        // color: const Color.fromARGB(255, 53, 21, 81),
        borderRadius: BorderRadius.circular(14));
  }

  Widget DrawerListItem(
      BuildContext context, String text, IconData icon, Widget route) {
    return ListTile(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('DrawerItem', text);
        easyNavigation(route, context);
      },
      title: Container(
        decoration: (dval == text) ? dec1() : const BoxDecoration(),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 14, top: 14, bottom: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 21,
                color: (dval == text) ? textcolor2 : textcolor5,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  fontSize: (dval == text) ? 16 : 14,
                  fontWeight:
                      (dval == text) ? FontWeight.bold : FontWeight.normal,
                  color: (dval == text) ? textcolor2 : textcolor5,
                ),
              ),
              const Spacer(),
              Icon(
                WebSymbols.right_circle,
                size: 20,
                color: (dval == text) ? textcolor2 : textcolor5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
