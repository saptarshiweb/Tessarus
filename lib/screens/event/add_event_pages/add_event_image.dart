// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'dart:io';
import "package:images_picker/images_picker.dart";
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
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
  String url1 = '';
  String url2 = '';
  String url3 = '';

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
        urlList.add(urlVal.toString());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appbar1('Add Event Images', context),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
          child: Column(
            children: [
              (showImageList)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, top: 20, left: 20, right: 20),
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                            // physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: urlList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      urlList[index],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : const SizedBox(height: 0, width: 0),
              Container(
                decoration: BoxDecoration(
                    color: primaryColor1,
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
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
                                        'Upload the Image', containerColor, 18),
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
                                      borderRadius: BorderRadius.circular(12))),
                              onPressed: () {
                                uploadImage(context);
                              },
                              child: ctext1('Upload', primaryColor1, 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
