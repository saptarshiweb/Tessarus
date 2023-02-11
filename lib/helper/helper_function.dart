import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:http/http.dart' as http;

shiftFocus(BuildContext context) {
  Navigator.pop(context);
}

normalNavigation(Widget route, BuildContext context) {
  Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => route),
  );
}

easyNavigation(Widget route, BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => route),
      (Route<dynamic> route) => false);
}



Future deleteEvent(String id, BuildContext context) async {
  String authVal = '';
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? auth = prefs.getString("Auth");
  authVal = auth!;
  final response = await http.delete(
    Uri.parse("$delete_event$id"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers': 'Content-Type',
      'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
      'Authorization': 'Bearer $authVal'
    },
  );

  // ignore: avoid_print
  print(response.body);
}
