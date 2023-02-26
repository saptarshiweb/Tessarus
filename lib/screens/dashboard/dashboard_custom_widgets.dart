import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';

BoxDecoration d1() {
  return const BoxDecoration();
}

Widget transactionStats(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.6,
    decoration: d1(),
    child: Column(
      children: [
        ctext1('Transaction Stats', textcolor6, 14),
      ],
    ),
  );
}
