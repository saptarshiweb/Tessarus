// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';

import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

Widget CustomTextEditor(String title, String value, BuildContext context) {
  HtmlEditorController controller = HtmlEditorController();
  return Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: appbar1(title, context),
    body: Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 6),
      child: ListView(
        children: [
          HtmlEditor(
            htmlToolbarOptions: HtmlToolbarOptions(
                textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: textcolor1),
                toolbarType: ToolbarType.nativeExpandable,
                toolbarPosition: ToolbarPosition.belowEditor,
                defaultToolbarButtons: [
                  const ListButtons(listStyles: false),
                  const StyleButtons(style: true),
                  const FontSettingButtons(
                      fontSizeUnit: false, fontSize: true, fontName: true),
                  const FontButtons(
                      superscript: false,
                      subscript: false,
                      clearAll: false,
                      strikethrough: false),
                  const ColorButtons(
                      foregroundColor: true, highlightColor: true),
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
                      hr: false)
                ]),
            otherOptions: const OtherOptions(),
            controller: controller,
            htmlEditorOptions:
                const HtmlEditorOptions(hint: 'Enter your text here...'),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: containerColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () async {
                  String v = await controller.getText();
                  print(v);

                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 14),
                  child: ctext1('Done', primaryColor1, 14),
                )),
          )
        ],
      ),
    ),
  );
}

// class CustomTextEditor extends StatelessWidget {
//   CustomTextEditor(this.title, this.value, {super.key});

//   final String title;
//   String value;
//   HtmlEditorController controller = HtmlEditorController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: appbar1(title, context),
//       body: Padding(
//         padding: const EdgeInsets.only(bottom: 15, top: 6),
//         child: ListView(
//           children: [
//             HtmlEditor(
//               htmlToolbarOptions: HtmlToolbarOptions(
//                   textStyle: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: textcolor1),
//                   toolbarType: ToolbarType.nativeExpandable,
//                   toolbarPosition: ToolbarPosition.belowEditor,
//                   defaultToolbarButtons: [
//                     const ListButtons(listStyles: false),
//                     const StyleButtons(style: true),
//                     const FontSettingButtons(
//                         fontSizeUnit: false, fontSize: true, fontName: true),
//                     const FontButtons(
//                         superscript: false,
//                         subscript: false,
//                         clearAll: false,
//                         strikethrough: false),
//                     const ColorButtons(
//                         foregroundColor: true, highlightColor: true),
//                     const ParagraphButtons(
//                         textDirection: false,
//                         caseConverter: false,
//                         lineHeight: false,
//                         increaseIndent: false,
//                         decreaseIndent: false),
//                     const InsertButtons(
//                         link: false,
//                         picture: false,
//                         audio: false,
//                         video: false,
//                         otherFile: false,
//                         table: false,
//                         hr: false)
//                   ]),
//               otherOptions: const OtherOptions(),
//               controller: controller,
//               htmlEditorOptions:
//                   const HtmlEditorOptions(hint: 'Enter your text here...'),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: containerColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12))),
//                   onPressed: () async {
//                     String v = await controller.getText();
//                     value = v;
//                     Navigator.pop(context);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 14, bottom: 14),
//                     child: ctext1('Done', primaryColor1, 14),
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
