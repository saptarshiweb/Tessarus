// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/custom_widget/custom_buttons.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import '../../../color_constants.dart';
import '../../../custom_widget/custom_appbar.dart';
import '../../../custom_widget/custom_modal_routes.dart';
import '../../../custom_widget/custom_text.dart';
import '../../../custom_widget/loader_widget.dart';
import '../../../models/api_url.dart';
import '../../../models/new_event_model.dart';

class SponsorInfoAdd extends StatefulWidget {
  const SponsorInfoAdd({super.key});

  @override
  State<SponsorInfoAdd> createState() => _SponsorInfoAddState();
}

class _SponsorInfoAddState extends State<SponsorInfoAdd> {
  File? imageFile;
  bool showSponsorList = false;
  int ind = 0;
  String url = 'no image';
  bool imgSelected = false;

  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  List<String> sname = [];
  List<String> stype = [];
  List<String> surl = [];
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
          url = urlVal.toString();
        });

        // urlList.insert(0, urlVal.toString());
        // urlInd++;
        // print(urlList.length);
        // setState(() {
        //   showImageList = true;
        // });
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
      imgSelected = true;
    });
  }

  Future getPreviousSponsorInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = '';
    str = prefs.getString('newEvent') ?? '';
    Map<String, dynamic> jsonDetails = {};
    jsonDetails = jsonDecode(str);
    var newEvent1 = Events.fromJson(jsonDetails);
    // String d1 = '';

    setState(() {
      int splen = newEvent1.sponsors!.length;
      if (splen > 0) {
        for (int i = 0; i < splen; i++) {
          sname.add(newEvent1.sponsors![i].name!);
          stype.add(newEvent1.sponsors![i].type!);
          surl.add(newEvent1.sponsors![i].image!);
        }
        ind = sname.length;
        if (sname.isNotEmpty) showSponsorList = true;
      }
    });

    // setState(() {
    //   int imgAll = newEvent1.eventImages!.length;
    //   if (imgAll > 0) {
    //     for (int i = 0; i < imgAll; i++) {
    //       urlList.add(newEvent1.eventImages![i].url!);
    //     }
    //     if (urlList.isNotEmpty) showImageList = true;
    //   }
    //   urlInd = urlList.length + 1;
    // });
  }

  @override
  void initState() {
    getPreviousSponsorInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: appbar1('Add Event Sponsors', context),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              (showSponsorList == true)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: sname.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: sponsorTile(context, sname[index],
                                  surl[index], stype[index], index),
                            );
                          }),
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),
              (imgSelected == false)
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
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Column(
                                children: [
                                  Center(
                                      child: IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: Icon(EvaIcons.cloudUploadOutline,
                                        color: containerColor, size: 32),
                                  )),
                                  const SizedBox(height: 15),
                                  ctext1(
                                      'Select the Image.', containerColor, 18),
                                  const SizedBox(height: 4),
                                  ctext1(
                                      'Click on the Delete button to delete it.',
                                      textcolor6,
                                      12)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.7,
                      //display image from the file
                      child: Image.file(imageFile!),
                    ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ctext1('Sponsor Image ${ind + 1}', textcolor2, 18),
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: containerColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                      onPressed: () {
                        uploadImage(context);
                      },
                      child: ctext1('Upload Sponsor Image', primaryColor1, 12)),
                ],
              ),
              const SizedBox(height: 10),
              tfield1(controller: name, label: 'Sponsor Name'),
              const SizedBox(height: 10),
              tfield1(controller: type, label: 'Sponsor Type'),
              const SizedBox(height: 20),
              ebutton1(context, ctext1('Add Sponsor', primaryColor1, 12),
                  () async {
                if (name.text == '' || type.text == '') {
                  if (name.text == '') {
                    showErrorMessage('Sponsor Name cannot be empty', context);
                  } else {
                    showErrorMessage('Sponsor Type cannot be empty', context);
                  }
                } else {
                  // cName.add(name.text);
                  // cPhone.add(phone.text);
                  // sname.insert(0, name.text);
                  // stype.insert(0, type.text);
                  // stype.insert(0, url);

                  sname.add(name.text);
                  stype.add(type.text);
                  surl.add(url);
                  setState(() {
                    ind++;

                    name.text = '';
                    type.text = '';
                    url = 'no image';
                    showSponsorList = true;
                    imgSelected = false;
                  });
                }
              }),
              const SizedBox(height: 12),
              ebutton3(
                  fun: () async {
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
                    List<Sponsors> sponsor1 = [];
                    for (int i = 0; i < sname.length; i++) {
                      Sponsors s1 = Sponsors(
                          name: sname[i], type: stype[i], image: surl[i]);
                      sponsor1.add(s1);
                    }
                    newEvent1.sponsors = sponsor1;
                    print(newEvent1.sponsors!.length);
                    await prefs.setString('newEvent', jsonEncode(newEvent1));

                    Navigator.pop(context);
                  },
                  t: ctext1('Submit All', containerColor, 15))
            ],
          ),
        ),
      ),
    );
  }

  Widget sponsorTile(
      BuildContext context, String name, String image, String type, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: primaryColor1, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            (image == 'no image')
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: Center(
                        child: Text(
                      'No Sponsor Image Detected',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textcolor2,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(height: 10),
            Row(
              children: [
                ctext1('Sponsor Name', textcolor6, 12),
                const Spacer(),
                ctext1(name, containerColor, 18),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                ctext1('Sponsor Type', textcolor6, 12),
                const Spacer(),
                ctext1(type, containerColor, 18),
              ],
            ),
            const SizedBox(height: 7),
            ebutton3(
                fun: () {
                  setState(() {
                    sname.removeAt(index);
                    stype.removeAt(index);
                    surl.removeAt(index);
                    ind--;
                    if (sname.isEmpty) {
                      showSponsorList = false;
                      ind = 0;
                    }
                  });
                },
                t: ctext1('Delete Sponsor', textcolor2, 12))
          ],
        ),
      ),
    );
  }
}
