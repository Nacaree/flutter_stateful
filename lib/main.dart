import 'package:flutter/material.dart';
import 'package:learn_stateful/ColorLogic.dart';
import 'package:learn_stateful/ColorPicker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ColorLogic(),
      child: const MaterialApp(home: Colorpicker()),
    );
  }
}
