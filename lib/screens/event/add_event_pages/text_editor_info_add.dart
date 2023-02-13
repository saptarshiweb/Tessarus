import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
class TextEditorInfo extends StatefulWidget {
  const TextEditorInfo({super.key});

  @override
  State<TextEditorInfo> createState() => _TextEditorInfoState();
}

class _TextEditorInfoState extends State<TextEditorInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: appbar1('Comprehensive Info', context),
    );
  }
}