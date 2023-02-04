import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

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
          
        ],
      ),
    );
  }
}
