import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  const CounterButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  
  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: const Text("Add 1 to counter"),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Counter: 0", style: TextStyle(fontSize: 30));
  }
}
