import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';

class SystemLogsPage extends StatefulWidget {
  const SystemLogsPage({super.key});

  @override
  State<SystemLogsPage> createState() => _SystemLogsPageState();
}

class _SystemLogsPageState extends State<SystemLogsPage> {
  String logtype = 'EVENT_CREATED';
  var items = ['EVENT_CREATED'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('System Logs', Colors.orange),
      body: Padding(
        padding: const EdgeInsets.only(top: 14, left: 15, right: 15),
        child: ListView(
          children: [
            dropDownWidget(context),
          ],
        ),
      ),
    );
  }

  Widget dropDownWidget(BuildContext context) {
    return DropdownButton(
      value: logtype,
      dropdownColor: textcolor2,
      icon: Icon(FontAwesome.down_open, color: textcolor1, size: 22),
      elevation: 0,
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              '$items      ',
              style: TextStyle(color: textcolor1, fontSize: 22),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          logtype = value!;
        });
      },
    );
  }
}
