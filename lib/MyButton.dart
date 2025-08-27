import 'package:flutter/material.dart';
import 'package:learn_stateful/provider01.dart';
import 'package:provider/provider.dart';

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterLogic logic = context.read<CounterLogic>();
    return Expanded(
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add_box_outlined, size: 30),
          onPressed: () => logic.goUp(),
        ),
      ),
    );
  }
}
