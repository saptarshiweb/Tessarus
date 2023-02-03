import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/screens/drawer/drawer_custom_appbar.dart';

class AddCoins extends StatefulWidget {
  const AddCoins({super.key});

  @override
  State<AddCoins> createState() => _AddCoinsState();
}

class _AddCoinsState extends State<AddCoins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Add Coins', Colors.orange),
    );
  }
}