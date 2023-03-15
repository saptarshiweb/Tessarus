// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/helper/helper_function.dart';
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
  String descInitial = '';
  String ruleInitial = '';
  String prizeInitial = '';
  String? sumval;

  Future getPreviousInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = '';
    str = prefs.getString('newEvent') ?? '';
    Map<String, dynamic> jsonDetails = {};
    jsonDetails = jsonDecode(str);
    var newEvent1 = Events.fromJson(jsonDetails);
    String d1 = '';

    setState(() {
      d1 = newEvent1.description!;
      descInitial = d1;

      d1 = newEvent1.rules!;
      ruleInitial = d1;

      d1 = newEvent1.prizes!;
      prizeInitial = d1;
    });
  }

  @override
  void initState() {
    getPreviousInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: appbar1('Comprehensive Info', context),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 100, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor1,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                            child: ctext1('Event Description', textcolor2, 12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              editorCustom(context, descController, 'Description', descInitial),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor1,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                            child: ctext1('Event Rules', textcolor2, 12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              editorCustom(context, ruleController, 'Rules', ruleInitial),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor1,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                            child: ctext1('Event Prizes', textcolor2, 12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              editorCustom(context, prizesController, 'Prizes', prizeInitial),
              const SizedBox(height: 30),
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
                          shiftFocus(context);
                          showLoaderDialog(context);
                          String description = await descController.getText();
                          String rules = await ruleController.getText();
                          String prizes = await prizesController.getText();
                          await Future.delayed(const Duration(seconds: 3));
                          Navigator.pop(context);

                          if (rules == '' ||
                              description == '' ||
                              prizes == '') {
                            if (rules == '') {
                              showErrorMessage(
                                  'Rules is not Allowed to be empty.', context);
                            } else if (description == '') {
                              showErrorMessage(
                                  'Description is not Allowed to be empty.',
                                  context);
                            } else {
                              showErrorMessage(
                                  'Prizes is not Allowed to be empty.',
                                  context);
                            }
                          } else {
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
                          }
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

  Widget editorCustom(BuildContext context, HtmlEditorController controller,
      String s, String initial) {
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
          height: 500,
          decoration: BoxDecoration(
              border: const Border.fromBorderSide(BorderSide.none),
              borderRadius: BorderRadius.circular(6))),
      controller: controller,
      htmlEditorOptions: HtmlEditorOptions(
        initialText: initial,
        darkMode: true,
        hint: 'Enter your $s',
      ),
    );
  }
}
