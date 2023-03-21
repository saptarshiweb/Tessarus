// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../color_constants.dart';
import '../drawer/drawer_custom_appbar.dart';
import '../drawer/simple_drawer_custom.dart';

class DeveloperContactMain extends StatefulWidget {
  const DeveloperContactMain({super.key});

  @override
  State<DeveloperContactMain> createState() => _DeveloperContactMainState();
}

class _DeveloperContactMainState extends State<DeveloperContactMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        drawer: const SimpleDrawerCustom(),
        appBar: customAppBar('Developer Contact', containerColor),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
            child: Column(
              children: [
                devWidget(
                    context,
                    'Saptarshi Mandal',
                    'IT',
                    'https://www.linkedin.com/in/saptarshi-mandal-100',
                    'https://github.com/saptarshiweb',
                    'Tessarus App Developer',
                    'https://www.facebook.com/profile.php?id=100056183545630&mibextid=ZbWKwL',
                    '',
                    'assets/Saptarshi_Mandal.jpg',
                    '9903178863',
                    'saptarshicoding@gmail.com'),
                const SizedBox(height: 50),
                devWidget(
                    context,
                    'Sudip Maiti',
                    'IT',
                    'https://www.linkedin.com/in/sudip-maiti-51a86b206',
                    'https://github.com/sudip-101',
                    'Tessarus Website Developer',
                    'https://www.facebook.com/sudip.maity.5095?mibextid=ZbWKwL',
                    'https://instagram.com/its_sudip101?igshid=ZDdkNTZiNTM=',
                    'assets/Sudip_Maiti.jpg',
                    '7584929770',
                    'maitisudip2002@gmail.com'),
                const SizedBox(height: 50),
                devWidget(
                    context,
                    'Soumyajit Datta',
                    'CSE',
                    'https://www.linkedin.com/in/codehackerone/',
                    'https://github.com/codehackerone',
                    'Tessarus Backend Developer, Project Lead',
                    '',
                    'https://instagram.com/__mess1er__?igshid=ZDdkNTZiNTM=',
                    'assets/Soumyajit_Datta.jpeg',
                    '6290376589',
                    'soumyajitdatta123@gmail.com'),
                    const SizedBox(height: 50),
                devWidget(
                    context,
                    'Amit Samui',
                    'CSE',
                    'https://www.linkedin.com/in/amit-samui-3780631ba/',
                    'https://github.com/AmitSamui',
                    'Tessarus Website Designer',
                    '',
                    'https://www.instagram.com/fdgod_decipher_it/',
                    'assets/Amit_Samui.jpg',
                    '8609073328',
                    'amitsamui257@gmail.com'),
              ],
            ),
          ),
        ));
  }

  Widget devWidget(
      BuildContext context,
      String name,
      String dept,
      String linkedin,
      String github,
      String tagline,
      String facebook,
      String instagram,
      String photo,
      String phone,
      String email) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 0, left: 0, right: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(photo),
                  radius: 50,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ctext1(name, textcolor2, 18),
            const SizedBox(height: 8),
            ctext1(phone, containerColor, 14),
            const SizedBox(height: 8),
            ctext1(tagline, textcolor2, 14),
            const SizedBox(height: 20),
            ctext1(email, textcolor6, 12),
            const SizedBox(height: 20),
            design1(context, name, dept, linkedin, github, tagline, instagram,
                facebook, photo, phone, email),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget design1(
      BuildContext context,
      String name,
      String dept,
      String linkedin,
      String github,
      String tagline,
      String instagram,
      String facebook,
      String photo,
      String phone,
      String email) {
    return Container(
      decoration: BoxDecoration(
          color: textcolor1.withOpacity(0.6),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 40, left: 30, right: 30),
        child: (instagram != '')
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        _launchWhatsapp(phone);
                      },
                      icon: Icon(FontAwesome.whatsapp,
                          color: containerColor, size: 20)),
                  IconButton(
                      onPressed: () {
                        _launchURL(linkedin);
                      },
                      icon: Icon(EvaIcons.linkedin,
                          color: containerColor, size: 20)),
                  IconButton(
                      onPressed: () {
                        _launchURL(github);
                      },
                      icon: Icon(FontAwesome.github,
                          color: containerColor, size: 20)),
                  IconButton(
                      onPressed: () {
                        _launchURL(facebook);
                      },
                      icon: Icon(EvaIcons.facebook,
                          color: containerColor, size: 20)),
                  IconButton(
                      onPressed: () {
                        _launchURL(instagram);
                      },
                      icon: Icon(FontAwesome.instagram,
                          color: containerColor, size: 20))
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        _launchWhatsapp(phone);
                      },
                      icon: Icon(FontAwesome.whatsapp,
                          color: containerColor, size: 20)),
                  IconButton(
                      onPressed: () {
                        _launchURL(linkedin);
                      },
                      icon: Icon(EvaIcons.linkedin,
                          color: containerColor, size: 20)),
                  IconButton(
                      onPressed: () {
                        _launchURL(github);
                      },
                      icon: Icon(FontAwesome.github,
                          color: containerColor, size: 20)),
                  IconButton(
                      onPressed: () {
                        _launchURL(facebook);
                      },
                      icon: Icon(EvaIcons.facebook,
                          color: containerColor, size: 20)),
                ],
              ),
      ),
    );
  }

  _launchWhatsapp(String phone) async {
    var contact = "+91$phone";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hello";
    //  var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi')}";
    await launchUrl(Uri.parse(androidUrl));
  }
}
