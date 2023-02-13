// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/image_picker_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'custom_modal_routes.dart';

class ImagePickWidget extends StatefulWidget {
  ImagePickerModel img1;
  ImagePickWidget({super.key, required this.img1});

  @override
  State<ImagePickWidget> createState() => _ImagePickWidgetState();
}

class _ImagePickWidgetState extends State<ImagePickWidget> {
  @override
  Widget build(BuildContext context) {
    io.File? pickedImage;

    Future uploadImage() async {
      //API PUT
      // var body = {'images': pickedImage};
      var postUri = Uri.parse(image_upload_url);
      var request = http.MultipartRequest("PUT", postUri);
      request.headers.addAll(<String, String>{
        "Content-Type": "application/x-www-form-urlencoded",
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'UTILS-API-KEY': image_api_key
      });
      request.files.add(http.MultipartFile.fromBytes('file',
          await io.File.fromUri(Uri.parse(pickedImage!.path)).readAsBytes(),
          contentType: MediaType('image', 'jpeg')));

      request.send().then((response) {
        print(response);
        if (response.statusCode == 200) print("Uploaded!");
      });
      // final response = await http.put(Uri.parse(image_upload_url),
      //     headers: <String, String>{
      //       // 'Content-Type': 'application/json',
      //       "Content-Type": "application/x-www-form-urlencoded",
      //       // 'Accept': 'application/json',
      //       'Access-Control-Allow-Origin': '*',
      //       'Access-Control-Allow-Credentials': 'true',
      //       'Access-Control-Allow-Headers': 'Content-Type',
      //       'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
      //       'UTILS-API-KEY': image_api_key
      //     },
      //     encoding: Encoding.getByName('utf-8'),
      //     // body: jsonEncode(<String, String>),

      //     body: {
      //       {'images': pickedImage}
      //     });

      // print(response.body);
    }

    Future pickImage() async {
      // final picker = ImagePicker();
      // // Pick an image
      // final pickedfile = await picker.pickImage(source: ImageSource.gallery);

      // if (pickedfile == null) return;
      // final imageTemporary = io.File(pickedfile.path);

      // setState(() {
      //   pickedImage = imageTemporary;
      //   print(pickedImage!.path);
      // });

      FilePickerResult? result = await FilePicker.platform.pickFiles();
      io.File file = io.File(result!.files.single.path!);

      if (result != null) {
        setState(() {
          pickedImage = file;
          print(pickedImage!.path);
        });
      } else {
        // User canceled the picker
      }
    }

    // Image convertFileToImage(io.File picture) {
    //   List<int> imageBase64 = picture.readAsBytesSync();
    //   String imageAsString = base64Encode(imageBase64);
    //   Uint8List uint8list = base64.decode(imageAsString);
    //   Image image = Image.memory(uint8list);
    //   return image;
    // }

    return Container(
      decoration: BoxDecoration(
          color: primaryColor1, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                (widget.img1.uploadstate == false)
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: DottedBorder(
                            color: containerColor,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(18),
                            strokeWidth: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Icon(FontAwesome.upload,
                                        color: containerColor, size: 22),
                                  ),
                                  const SizedBox(height: 10),
                                  ctext1('Upload an Image', containerColor, 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(widget.img1.imageurl!),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                ctext1(widget.img1.imagename!, textcolor2, 20),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: containerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () {
                      uploadImage();
                    },
                    child: ctext1('Upload', primaryColor1, 12)),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {
                      uploadImage();
                      if (widget.img1.uploadstate == false) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return errorModal2(
                                  'No Image Uploaded to be deleted!', context);
                            });
                      }
                    },
                    icon: Icon(FontAwesome.trash, color: allcancel, size: 22))
              ],
            ),
            // pickedImage != null ? Image.file(pickedImage!) : Container(),
          ],
        ),
      ),
    );
  }
}
