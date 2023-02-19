// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:images_picker/images_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:tessarus_volunteer/models/new_event_model.dart';

class AddCoordinatorEvent extends StatefulWidget {
  const AddCoordinatorEvent({super.key});

  @override
  State<AddCoordinatorEvent> createState() => _AddCoordinatorEventState();
}

class _AddCoordinatorEventState extends State<AddCoordinatorEvent> {
  int ind = 1;
  File? imageFile;
  String clubImageUrl = '';
  bool showClubimage = false;
  List<EventCoordinators> c = [];
  List<String> cName = [];
  List<String> cPhone = [];
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController clubName = TextEditingController();
  bool showcList = false;
  Future uploadImage(BuildContext context) async {
    showLoaderDialog(context);
    var responseval;
    String urlVal = 'Error';
    var stream = http.ByteStream(DelegatingStream.typed(imageFile!.openRead()));

    var length = await imageFile!.length();

    var uri = Uri.parse(image_upload_url);

    var request = http.MultipartRequest("PUT", uri);

    var multipartFile = http.MultipartFile('images', stream, length,
        filename: basename(imageFile!.path));
    request.headers.addAll({
      "Content-Type": "application/x-www-form-urlencoded",
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers': 'Content-Type',
      'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
      'UTILS-API-KEY': image_api_key
    });

    request.files.add(multipartFile);

    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        // print(value);
        responseval = json.decode(value);
        urlVal = responseval['images'][0].toString();
        print(urlVal);

        setState(() {
          showClubimage = true;
          clubImageUrl = urlVal.toString();
        });
      });
    }).catchError((e) {
      print(e);
    });
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pop(context);
  }

  getImage() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
    );
    setState(() {
      imageFile = File(res![0].path);
    });
  }

  @override
  void initState() {
    getPreviousCoordinatorInfo();
    super.initState();
  }

  Future getPreviousCoordinatorInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = '';
    str = prefs.getString('newEvent') ?? '';
    Map<String, dynamic> jsonDetails = {};
    jsonDetails = jsonDecode(str);
    var newEvent1 = Events.fromJson(jsonDetails);
    String d1 = '';

    setState(() {
      d1 = newEvent1.eventOrganiserClub!.name!;
      clubName.text = d1;
      d1 = newEvent1.eventOrganiserClub!.image!;
      clubImageUrl = d1;
      if (clubImageUrl != '') showClubimage = true;
      cName = [];
      cPhone = [];
      int coo = newEvent1.eventCoordinators!.length;
      for (int i = 0; i < coo; i++) {
        cName.add(newEvent1.eventCoordinators![i].name!);
        cPhone.add(newEvent1.eventCoordinators![i].phone!);
      }
      if (cName.isNotEmpty) showcList = true;
      ind = cName.length + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: primaryColor,
        appBar: appbar1('Add Coordinator', context),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tfield1(controller: clubName, label: 'Organizing Club'),
                const SizedBox(height: 10),
                (showClubimage == false)
                    ? Row(
                        children: [
                          Expanded(
                            child: DottedBorder(
                              color: containerColor,
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(7),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  children: [
                                    Center(
                                        child: IconButton(
                                      onPressed: () {
                                        getImage();
                                      },
                                      icon: Icon(FontAwesome.upload,
                                          color: containerColor, size: 22),
                                    )),
                                    const SizedBox(height: 15),
                                    ctext1('Upload the Club Image',
                                        containerColor, 18),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              clubImageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: containerColor),
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () async {
                            if (showClubimage == false) {
                              uploadImage(context);
                            } else {
                              showLoaderDialog(context);
                              setState(() {
                                showClubimage = false;
                                clubImageUrl = '';
                              });
                              await Future.delayed(const Duration(seconds: 2));
                              Navigator.pop(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: ctext1(
                                (showClubimage == false) ? 'Upload' : 'Delete',
                                textcolor2,
                                15),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                (showcList == true)
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: ListView.builder(
                              itemCount: cName.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 8, bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 1, color: containerColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ctext1('Coordinator ${index + 1}',
                                                  textcolor2, 16),
                                              const SizedBox(width: 20),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      cName.removeAt(index);
                                                      cPhone.removeAt(index);
                                                      ind--;
                                                    });
                                                    if (cName.isEmpty) {
                                                      showcList = false;
                                                    }
                                                  },
                                                  icon: Icon(Icons.delete,
                                                      color: allcancel,
                                                      size: 18))
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          ctext1(cName[index], textcolor2, 14),
                                          const SizedBox(height: 10),
                                          ctext1(cPhone[index], textcolor2, 14),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : const SizedBox(height: 0, width: 0),
                ctext1('Add Coordinator $ind', textcolor2, 18),
                const SizedBox(height: 20),
                tfield1(controller: name, label: 'Name'),
                const SizedBox(height: 10),
                numfield1(controller: phone, label: 'Phone'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: containerColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7))),
                          onPressed: () {
                            if (name.text == '' || phone.text == '') {
                              if (name.text == '') {
                                showErrorMessage(
                                    'Coordinator Name cannot be empty',
                                    context);
                              } else {
                                showErrorMessage(
                                    'Coordinator Phone cannot be empty',
                                    context);
                              }
                            } else {
                              // cName.add(name.text);
                              // cPhone.add(phone.text);
                              cName.insert(0, name.text);
                              cPhone.insert(0, phone.text);
                              setState(() {
                                ind++;
                                name.text = '';
                                phone.text = '';
                                showcList = true;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: ctext1('Add Coordinator', primaryColor1, 12),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: containerColor),
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () async {
                            if (clubName.text == '' ||
                                clubImageUrl == '' ||
                                cName.isEmpty) {
                              if (clubName.text == '') {
                                showErrorMessage(
                                    'Club Name need to be added.', context);
                              } else if (clubImageUrl == '') {
                                showErrorMessage(
                                    'Club Image Must be Uploaded.', context);
                              } else {
                                showErrorMessage(
                                    'Atleast one coordinator need to be added.',
                                    context);
                              }
                            } else {
                              showLoaderDialog(context);
                              await Future.delayed(const Duration(seconds: 6));
                              Navigator.pop(context);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String str = '';
                              str = prefs.getString('newEvent') ?? '';
                              Map<String, dynamic> jsonDetails = {};
                              jsonDetails = jsonDecode(str);
                              var newEvent1 = Events.fromJson(jsonDetails);
                              EventOrganiserClub club1 = EventOrganiserClub(
                                  name: clubName.text, image: clubImageUrl);
                              newEvent1.eventOrganiserClub = club1;
                              print(newEvent1.eventOrganiserClub!.name);
                              newEvent1.eventCoordinators!.clear();

                              for (int i = 0; i < cName.length; i++) {
                                EventCoordinators c = EventCoordinators(
                                    name: cName[i], phone: cPhone[i]);
                                newEvent1.eventCoordinators!.add(c);
                              }
                              // print(newEvent1.eventCoordinators![0].name);
                              // print(newEvent1.eventCoordinators![0].phone);
                              await prefs.setString(
                                  'newEvent', jsonEncode(newEvent1));

                              Navigator.pop(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: ctext1('Submit All', textcolor2, 15),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
