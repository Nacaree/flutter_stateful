import 'StorageService.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final StorageService _storage = StorageService();
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final value = await _storage.loadCounter();
    setState(() {
      _counter = value;
    });
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _storage.saveCounter(_counter);
  }

  Future<void> _resetCounter() async {
    setState(() {
      _counter = 0;
    });
    await _storage.resetCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SharedPreference demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "you pressed the button this many times:",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text("$_counter", style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetCounter,
              child: const Text("Reset Counter"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
