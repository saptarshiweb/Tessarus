// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/models/new_event_model.dart';

import '../../../custom_widget/loader_widget.dart';

class TextEditorInfo extends StatefulWidget {
  const TextEditorInfo({super.key});

  @override
  State<TextEditorInfo> createState() => _TextEditorInfoState();
}

class _TextEditorInfoState extends State<TextEditorInfo> {
  HtmlEditorController ruleController = HtmlEditorController();
  HtmlEditorController prizesController = HtmlEditorController();
  HtmlEditorController descController = HtmlEditorController();

  // getPreviousInfo() async {
  //   showLoaderDialog(context);
  //   await Future.delayed(const Duration(seconds: 2));

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String str = '';
  //   str = prefs.getString('newEvent') ?? '';
  //   Map<String, dynamic> jsonDetails = {};
  //   jsonDetails = jsonDecode(str);
  //   var newEvent1 = Events.fromJson(jsonDetails);
  //   String d1 = '';
  //   d1 = newEvent1.description!;
  //   descController.setText(d1);

  //   print(d1);
  //   d1 = newEvent1.rules!;
  //   ruleController.setText(d1);
  //   print(d1);
  //   d1 = newEvent1.prizes!;
  //   prizesController.setText(d1);
  //   print(d1);

  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: appbar1('Comprehensive Info', context),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              editorCustom(context, descController, 'Description'),
              const SizedBox(height: 10),
              editorCustom(context, ruleController, 'Rules'),
              const SizedBox(height: 10),
              editorCustom(context, prizesController, 'Prizes'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                    width: 1, color: containerColor))),
                        onPressed: () async {
                          showLoaderDialog(context);
                          String description = await descController.getText();
                          String rules = await ruleController.getText();
                          String prizes = await prizesController.getText();
                          await Future.delayed(const Duration(seconds: 6));
                          Navigator.pop(context);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String str = '';
                          str = prefs.getString('newEvent') ?? '';
                          Map<String, dynamic> jsonDetails = {};
                          jsonDetails = jsonDecode(str);
                          var newEvent1 = Events.fromJson(jsonDetails);

                          newEvent1.description = description;
                          newEvent1.rules = rules;
                          newEvent1.prizes = prizes;

                          await prefs.setString(
                              'newEvent', jsonEncode(newEvent1));
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: ctext1('Confirm All', textcolor2, 16),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editorCustom(
      BuildContext context, HtmlEditorController controller, String s) {
    return HtmlEditor(
      htmlToolbarOptions: HtmlToolbarOptions(
          dropdownBoxDecoration: BoxDecoration(color: textcolor5),
          dropdownIconColor: textcolor2,
          dropdownBackgroundColor: primaryColor,
          buttonBorderColor: textcolor2,
          buttonColor: textcolor2,
          buttonHighlightColor: containerColor,
          buttonSelectedColor: containerColor,
          textStyle: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: textcolor2),
          toolbarType: ToolbarType.nativeGrid,
          toolbarPosition: ToolbarPosition.aboveEditor,
          defaultToolbarButtons: [
            const StyleButtons(style: true),
            const FontSettingButtons(
                fontSizeUnit: false, fontSize: true, fontName: true),
            const FontButtons(
                superscript: false,
                subscript: false,
                clearAll: false,
                strikethrough: false),
            const ColorButtons(foregroundColor: true, highlightColor: true),
            const ParagraphButtons(
                textDirection: false,
                caseConverter: false,
                lineHeight: false,
                increaseIndent: false,
                decreaseIndent: false),
            const InsertButtons(
                link: false,
                picture: false,
                audio: false,
                video: false,
                otherFile: false,
                table: false,
                hr: false),
            const ListButtons(listStyles: false),
          ]),
      otherOptions: OtherOptions(
          decoration: BoxDecoration(
              border: const Border.fromBorderSide(BorderSide.none),
              borderRadius: BorderRadius.circular(6))),
      controller: controller,
      htmlEditorOptions: HtmlEditorOptions(
        darkMode: true,
        hint: 'Enter your $s',
      ),
    );
  }
}
