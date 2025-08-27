import 'package:flutter/material.dart';
import 'package:learn_stateful/provider01.dart';
import 'package:provider/provider.dart';

class MyOtherButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Consumer<CounterLogic>(
          builder: (context, cm, _) {
            return IconButton(
              icon: Icon(Icons.add_circle, size: cm.counter.toDouble()),
              onPressed: () => cm.goUp(),
            );
          },
        ),
      ),
    );
  }
}
