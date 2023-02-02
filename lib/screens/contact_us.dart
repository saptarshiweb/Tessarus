import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Contact Us', Colors.orange),
    );
  }
}
