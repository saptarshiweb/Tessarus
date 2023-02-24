// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, depend_on_referenced_packages, deprecated_member_use, avoid_print

import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'dart:io';
import "package:images_picker/images_picker.dart";
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/new_event_model.dart';
import '../../../models/api_url.dart';

class AddEventImage extends StatefulWidget {
  const AddEventImage({super.key});

  @override
  State<AddEventImage> createState() => _AddEventImageState();
}

class _AddEventImageState extends State<AddEventImage> {
  File? imageFile;
  List<String> urlList = [];
  bool showImageList = false;
  String url = '';
  int urlInd = 1;

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
        urlList.insert(0, urlVal.toString());
        urlInd++;
        print(urlList.length);
        setState(() {
          showImageList = true;
        });
      });
    }).catchError((e) {
      print(e);
    });

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

  Future getPreviousEventImageInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = '';
    str = prefs.getString('newEvent') ?? '';
    Map<String, dynamic> jsonDetails = {};
    jsonDetails = jsonDecode(str);
    var newEvent1 = Events.fromJson(jsonDetails);
    // String d1 = '';

    setState(() {
      int imgAll = newEvent1.eventImages!.length;
      if (imgAll > 0) {
        for (int i = 0; i < imgAll; i++) {
          urlList.add(newEvent1.eventImages![i].url!);
        }
        if (urlList.isNotEmpty) showImageList = true;
      }
      urlInd = urlList.length + 1;
    });
  }

  @override
  void initState() {
    getPreviousEventImageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: appbar1('Add Event Images', context),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
          child: Column(
            children: [
              (showImageList)
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: SizedBox(
                        height: 150,
                        child: ListView.builder(

                            // physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: urlList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      fit: BoxFit.contain,
                                      urlList[index],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : const SizedBox(height: 0, width: 0),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DottedBorder(
                            color: containerColor,
                            strokeWidth: 2,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(7),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
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
                                  ctext1(
                                      'Select the Image', containerColor, 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ctext1('Event Image $urlInd', textcolor2, 18),
                        const Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: containerColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14))),
                            onPressed: () {
                              uploadImage(context);
                            },
                            child: ctext1('Upload', primaryColor1, 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          // WidgetsFlutterBinding.ensureInitialized();
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

                          List<EventImages> img = [];
                          for (var i = 0; i < urlList.length; i++) {
                            EventImages eventImages =
                                EventImages(url: urlList[i]);
                            img.add(eventImages);
                          }
                          newEvent1.eventImages = img;
                          print(newEvent1.eventImages!.length);
                          await prefs.setString(
                              'newEvent', jsonEncode(newEvent1));

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: containerColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: ctext1('Save', primaryColor1, 18),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
