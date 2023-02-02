import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/models/drawer_model.dart';

class DrawerItems {
  static const dashboard = DrawerItem('Dashboard', Icons.dashboard);
  static const event = DrawerItem('Event', Icons.event);
  static const help = DrawerItem('Help', Icons.help);
  static const contact = DrawerItem('Contact', Icons.contact_page);

  static const all = <DrawerItem>[dashboard, event, help, contact];
}

class DrawerConstruct extends StatelessWidget {
  final DrawerItem currentItem;
  final ValueChanged<DrawerItem> onSelectedItem;
  const DrawerConstruct(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: drawer_back,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 200),
          ...DrawerItems.all.map(buildMenuItem).toList(),
        ],
      )),
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
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
                // color: Colors.grey.shade400),
                ),
            onTap: () {
              onSelectedItem(item);
            },
          ),
        ),
      );
}
