import 'package:flutter/material.dart';
import 'package:learn_stateful/Quiz2/JokeService.dart';
import 'package:learn_stateful/Quiz2/model/JokeModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  JokeModel? _joke;
  bool _loading = false;

  void _getJoke() async {
    setState(() {
      _loading = true;
    });
    JokeModel joke = await fetchJoke();
    setState(() {
      _joke = joke;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 52, 109),
        title: const Text('Random Joke'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Best Joke Generator 🔥🤡",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 350,
              height: 200,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(65, 254, 52, 109),
                        valueColor: AlwaysStoppedAnimation(
                          Color.fromARGB(255, 254, 52, 109),
                        ),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _joke?.setup ??
                              'Joke will be displayed here (The set up)',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _joke?.punchline ?? "Punch Line",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  const Color.fromARGB(255, 254, 52, 109),
                ),
              ),
              onPressed: _getJoke,
              label: const Text("Get Another Joke"),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
