// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
import 'package:tessarus_volunteer/screens/admin_exclusive/system_log_page.dart';
import 'package:tessarus_volunteer/screens/cashier_exclusive/add_coins.dart';
import 'package:tessarus_volunteer/screens/contact_us.dart';
import 'package:tessarus_volunteer/screens/dashboard/dashboard_main.dart';
import 'package:tessarus_volunteer/screens/event/event_page.dart';
import 'package:tessarus_volunteer/screens/help_page.dart';
import 'package:tessarus_volunteer/screens/login_screen.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 23, bottom: 8),
      child: Drawer(
        surfaceTintColor: alltemp,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: textcolor2,
        elevation: 10,
        child: FutureBuilder(
          future: getDetails(),
          builder: (context, snapshot) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    topbar(context),
                    const SizedBox(height: 12),
                    profileWidget(context),
                    const Spacer(),
                    DrawerListItem(context, 'Dashboard', Elusive.group_circled,
                        const DashboardMain()),
                    DrawerListItem(
                        context, 'Event', Octicons.calendar, const EventPage()),
                    DrawerListItem(context, 'Ticket Scan',
                        Icons.qr_code_scanner_rounded, const TicketScanMain()),
                    DrawerListItem(context, 'Add Coins',
                        FontAwesome5.rupee_sign, const AddCoins()),
                    DrawerListItem(context, 'Volunteer Control',
                        RpgAwesome.heavy_shield, const VolunteerControl()),
                    (userlevel >= 3)
                        ? DrawerListItem(context, 'System Logs',
                            Typicons.cog_outline, const SystemLogsPage())
                        : const SizedBox(),
                    (userlevel <= 2)
                        ? DrawerListItem(
                            context, 'Help', Icons.help, const HelpPage())
                        : const SizedBox(),
                    (userlevel <= 2)
                        ? DrawerListItem(context, 'Contact', Icons.contact_page,
                            const ContactUs())
                        : const SizedBox(),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: logoutButton(context),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget topbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Entypo.qq,
            color: alltemp,
            size: 34,
          ),
          const SizedBox(width: 20),
          Text(
            'Tessarus',
            style: TextStyle(
              color: textcolor1,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesome5.compress_arrows_alt,
                color: alltemp,
              ))
        ],
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('signIn', false);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.logout_rounded),
              SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  Widget profileWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 0, top: 5, bottom: 4),
      child: Row(
        children: [
          (profileImage == '')
              ? Icon(
                  Typicons.user,
                  color: textcolor4,
                  size: 38,
                )
              : Container(
                  height: 40,
                  width: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(14)),
                  child: Image.network(profileImage)),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              smbold(username),
              const SizedBox(height: 2),
              subtitletext(useremail)
            ],
          )
        ],
      ),
    );
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
        decoration: BoxDecoration(
            color: (dval == text) ? alltemp : textcolor2,
            borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 14, top: 14, bottom: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 21,
                color: (dval == text) ? textcolor2 : textcolor4,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: (dval == text) ? textcolor2 : textcolor4,
                ),
              ),
              const Spacer(),
              Icon(
                WebSymbols.right_circle,
                size: 24,
                color: (dval == text) ? textcolor2 : textcolor4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
