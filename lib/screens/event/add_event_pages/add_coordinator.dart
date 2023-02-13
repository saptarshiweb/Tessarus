import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';

class AddCoordinatorEvent extends StatefulWidget {
  const AddCoordinatorEvent({super.key});

  @override
  State<AddCoordinatorEvent> createState() => _AddCoordinatorEventState();
}

class _AddCoordinatorEventState extends State<AddCoordinatorEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appbar1('Add Coordinator', context),
    );
  }
}
