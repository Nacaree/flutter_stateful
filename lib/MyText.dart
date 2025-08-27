import 'package:flutter/material.dart';
import 'package:learn_stateful/provider01.dart';
import 'package:provider/provider.dart';

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterLogic cm = context.watch<CounterLogic>();
    int counter = context.select<CounterLogic, int>((cl) => cl.counter);
    /*
    ! for listening to certain states
    * int counter = context.select<CounterLogic, int>((cl) => cl. * counter);
    */
    return Expanded(
      child: Center(child: Text("$counter", style: TextStyle(fontSize: 50))),
    );
  }
}
