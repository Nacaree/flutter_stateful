// * Find out why this is not working:
import 'package:flutter/material.dart';

class CounterPageTwo extends StatefulWidget {
  const CounterPageTwo({super.key});

  @override
  State<CounterPageTwo> createState() => _CounterPageTwoState();
}

class _CounterPageTwoState extends State<CounterPageTwo> {
  int counter = 0;

  void _increaseCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SetState Problem")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CounterButton(onPressed: _increaseCounter),
          const SizedBox(height: 20),
          CounterText(),
        ],
      ),
    );
  }
}