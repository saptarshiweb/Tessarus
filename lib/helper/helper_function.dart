import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:http/http.dart' as http;

deleteVolunteer(String id) async {
  String authVal = '';
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? auth = prefs.getString("Auth");
  authVal = auth!;
  final response = await http.delete(
    Uri.parse("$remove_volunteer$id"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers': 'Content-Type',
      'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
      'Authorization': 'Bearer $authVal'
    },
  );
}
