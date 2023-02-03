import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/models/drawer_model.dart';
import 'package:tessarus_volunteer/screens/login_screen.dart';

class DrawerItems {
  static const dashboard =
      DrawerItem('Dashboard', Icons.dashboard_customize_outlined);
  static const event = DrawerItem('Event', Icons.event);
  static const help = DrawerItem('Help', Icons.help);
  static const contact = DrawerItem('Contact', Icons.contact_page);
  static const systemlogs =
      DrawerItem('System Logs', Icons.system_security_update_good_rounded);
  static const ticketscan =
      DrawerItem('Ticket Scan', Icons.qr_code_scanner_rounded);

  static const addcoin =
      DrawerItem('Add Coins', Icons.add_circle_outline_rounded);
  static const volunteerControl =
      DrawerItem('Volunteer Control', Icons.control_point_duplicate_rounded);

  static const all = <DrawerItem>[
    dashboard,
    event,
    systemlogs,
    ticketscan,
    addcoin,
    volunteerControl,
    help,
    contact
  ];
}

class DrawerConstruct extends StatelessWidget {
  int userlevel = 1;
  String username = '';
  String useremail = '';
  Future getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('userLevel', 2);
    final int? level = prefs.getInt("Level");
    final String? name = prefs.getString("Name");
    final String? email = prefs.getString("Email");

    userlevel = level!;
    username = name!;
    useremail = email!;
  }

  final DrawerItem currentItem;
  final ValueChanged<DrawerItem> onSelectedItem;
  DrawerConstruct(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: drawer_back,
        body: FutureBuilder(
          future: getDetails(),
          builder: ((context, snapshot) {
            return SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: userLevelWidget(),
                      ),
                    ),
                  ],
                ),

                screenSelect(),
                // ...DrawerItems.adminAll.map(buildMenuItem).toList(),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30),
                  child: ElevatedButton(
                      onPressed: () async {
                        // Navigator.push(
                        //   context,
                        //   CupertinoPageRoute(
                        //       builder: (context) => const LoginScreen()),
                        // );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) => false);

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('signIn', false);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
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
                      )),
                )
              ],
            ));
          }),
        ));
  }

  Widget userLevelWidget() {
    String t = '';
    if (userlevel == 4) {
      t = 'Super Admin';
    } else if (userlevel == 3) {
      t = 'Admin';
    } else if (userlevel == 2) {
      t = 'Cashier';
    } else {
      t = 'Volunteer';
    }
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 8, top: 10, bottom: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Text(
                t,
                style: TextStyle(color: Colors.grey.shade300, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            WebSymbols.down_circle,
            color: Colors.white,
            size: 24,
          )
        ],
      ),
    );
  }

  Widget screenSelect() {
    if (userlevel == 4) {
      return superadminAll();
    } else if (userlevel == 3) {
      return adminAll();
    } else if (userlevel == 2) {
      return cashierAll();
    } else {
      return volunteerAll();
    }
  }

  Widget superadminAll() {
    return Column(
      children: [
        buildMenuItem(DrawerItems.dashboard),
        buildMenuItem(DrawerItems.event),
        buildMenuItem(DrawerItems.ticketscan),
        buildMenuItem(DrawerItems.addcoin),
        buildMenuItem(DrawerItems.systemlogs),
        buildMenuItem(DrawerItems.volunteerControl),

        // buildMenuItem(DrawerItems.help),
        // buildMenuItem(DrawerItems.contact),
      ],
    );
  }

  Widget adminAll() {
    return Column(
      children: [
        buildMenuItem(DrawerItems.dashboard),
        buildMenuItem(DrawerItems.event),
        // buildMenuItem(DrawerItems.systemlogs),
        buildMenuItem(DrawerItems.ticketscan),
        buildMenuItem(DrawerItems.help),
        buildMenuItem(DrawerItems.contact),
      ],
    );
  }

  Widget cashierAll() {
    return Column(
      children: [
        buildMenuItem(DrawerItems.dashboard),
        buildMenuItem(DrawerItems.event),
        // buildMenuItem(DrawerItems.systemlogs),
        buildMenuItem(DrawerItems.ticketscan),
        buildMenuItem(DrawerItems.addcoin),
        buildMenuItem(DrawerItems.help),
        buildMenuItem(DrawerItems.contact),
      ],
    );
  }

  Widget volunteerAll() {
    return Column(
      children: [
        buildMenuItem(DrawerItems.dashboard),
        buildMenuItem(DrawerItems.event),
        // buildMenuItem(DrawerItems.systemlogs),
        // buildMenuItem(DrawerItems.ticketscan),
        buildMenuItem(DrawerItems.help),
        buildMenuItem(DrawerItems.contact),
      ],
    );
  }

  Widget buildMenuItem(DrawerItem item) => ListTileTheme(
        selectedColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 18),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            selectedColor: Colors.white,
            selectedTileColor: Colors.transparent,
            style: ListTileStyle.list,
            iconColor: Colors.grey.shade500,
            textColor: Colors.grey.shade500,
            selected: currentItem == item,
            minLeadingWidth: 20,
            leading: Icon(item.icon),
            title: Text(item.title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                // color: Colors.grey.shade400),
                ),
            onTap: () {
              onSelectedItem(item);
            },
          ),
        ),
      );
}
