import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/image_picker_widget.dart';
import 'package:tessarus_volunteer/models/image_picker_model.dart';

class AddEventImage extends StatefulWidget {
  const AddEventImage({super.key});

  @override
  State<AddEventImage> createState() => _AddEventImageState();
}

class _AddEventImageState extends State<AddEventImage> {
  ImagePickerModel img1 = ImagePickerModel(
      imagename: 'Event Image 1', imageurl: '', uploadstate: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: appbar1('Add Event Images', context),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
        child: Column(
          children: [ImagePickWidget(img1: img1)],
        ),
      ),
    );
  }
}
