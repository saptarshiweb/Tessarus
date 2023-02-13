import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'dart:io';
import "package:images_picker/images_picker.dart";
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import '../../../models/api_url.dart';

class AddEventImage extends StatefulWidget {
  const AddEventImage({super.key});

  @override
  State<AddEventImage> createState() => _AddEventImageState();
}

class _AddEventImageState extends State<AddEventImage> {
  File? imageFile;

  Future uploadImage() async {
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
        print(value);
      });
    }).catchError((e) {
      print(e);
    });
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
      // backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: appbar1('Add Event Images', context),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
        child: Column(
          children: [imagePickerWidget()],
        ),
      ),
    );
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  _getFileFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print(file.path);
    } else {
      print("No file selected");
    }
  }

  Widget imagePickerWidget() {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              getImage();
            },
            child: const Text('pick image')),
        const SizedBox(width: 30),
        ElevatedButton(
            onPressed: () {
              uploadImage();
            },
            child: const Text('Upload')),
        SizedBox(
          height: 60,
          width: 60,
          child: Image.network(
              'https://tessarus.s3.ap-south-1.amazonaws.com/75fd99f34b654890252425f39bf3d891'),
        ),
      ],
    );
  }
}
