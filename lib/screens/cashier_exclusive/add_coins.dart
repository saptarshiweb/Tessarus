import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';

class AddCoins extends StatefulWidget {
  const AddCoins({super.key});

  @override
  State<AddCoins> createState() => _AddCoinsState();
}

class _AddCoinsState extends State<AddCoins> {
  String qrvalue = 'SampleText';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Add Coins', Colors.orange),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: AiBarcodeScanner(
              onScan: (String value) {
                setState(() {
                  qrvalue = value;
                });
              },
            ),
          ),
          Expanded(flex: 1, child: smbold(qrvalue)),
        ],
      ),
    );
  }
}
