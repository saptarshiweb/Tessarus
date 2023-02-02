import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/models/drawer_model.dart';
import 'package:tessarus_volunteer/screens/login_screen.dart';

class DrawerItems {
  static const dashboard = DrawerItem('Dashboard', Icons.dashboard);
  static const event = DrawerItem('Event', Icons.event);
  static const help = DrawerItem('Help', Icons.help);
  static const contact = DrawerItem('Contact', Icons.contact_page);
  static const systemlogs =
      DrawerItem('System Logs', Icons.system_security_update_good_rounded);
  static const ticketscan =
      DrawerItem('Ticket Scan', Icons.qr_code_scanner_rounded);

  static const all = <DrawerItem>[
    dashboard,
    event,
    systemlogs,
    ticketscan,
    help,
    contact
  ];
}

class DrawerConstruct extends StatelessWidget {
  int userlevel = 1;
  String username = '';
  String useremail = '';
  getDetails() async {
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
                smbold(username),
                ...DrawerItems.all.map(buildMenuItem).toList(),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const LoginScreen()),
                        );

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('signIn', false);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
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
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                // color: Colors.grey.shade400),
                ),
            onTap: () {
              onSelectedItem(item);
            },
          ),
        ),
      );
}
