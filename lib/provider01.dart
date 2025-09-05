// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:learn_stateful/MyButton.dart';
import 'package:learn_stateful/MyOtherButton.dart';
import 'package:learn_stateful/MyText.dart';
import 'package:provider/provider.dart';

class Provider01 extends StatelessWidget {
  const Provider01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Py ptgtuygage")),
      body: ChangeNotifierProvider(
        create: (context) => CounterLogic(),
        child: Container(
          child: Column(children: [MyButton(), MyText(), MyOtherButton()]),
        ),
      ),
    );
  }
}

class CounterLogic extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void goUp() {
    _counter++;
    notifyListeners();
  }
}
