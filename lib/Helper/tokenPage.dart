import 'package:flutter/material.dart';
import 'SecureStorageService.dart';

class TokenPage extends StatefulWidget {
  const TokenPage({super.key});

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  final _secureStorageService = SecureStorageService();
  final TextEditingController _controller = TextEditingController();
  String? _storedToken;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await _secureStorageService.readToken();
    setState(() {
      _storedToken = token;
    });
  }

  Future<void> _saveToken() async {
    if (_controller.text.isNotEmpty) {
      await _secureStorageService.saveToken(_controller.text);
      _loadToken();
    }
    _controller.clear();
  }

  Future<void> _deleteToken() async {
    await _secureStorageService.deleteToken();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Secure Storage Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter Token",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveToken,
              child: const Text("Save Token"),
            ),
            const SizedBox(height: 20),
            Text(
              _storedToken == null
                  ? "No token saved."
                  : "Stored Token: $_storedToken",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteToken,
              child: const Text("Delete Token"),
            ),
          ],
        ),
      ),
    );
  }
}
