import 'package:flutter/material.dart';
import 'package:learn_stateful/ColorLogic.dart';
import 'package:learn_stateful/ColorPicker.dart';
import 'package:learn_stateful/Quiz/HomePageV1.dart';
import 'package:learn_stateful/Quiz/HomePageV2.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: HomePageV2()));
    // return MaterialApp(home: Scaffold(body: HomePageV2()));

    /*
    return ChangeNotifierProvider(
      create: (context) => ColorLogic(),
      child: const MaterialApp(home: Colorpicker()),
    );
    */
  }
}
