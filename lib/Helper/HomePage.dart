import 'package:flutter/material.dart';
import 'package:learn_stateful/Helper/accountService.dart';
import 'package:learn_stateful/Helper/LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AccountService _accountService = AccountService();
  String? _username;
  String? _token;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    // * fake delay
    await Future.delayed(const Duration(seconds: 1));

    final username = await _accountService.readUser();
    final usernameToken = await _accountService.readToken();
    setState(() {
      _username = username;
      _token = usernameToken;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Colors.amber,
        actions: [
          TextButton(
            onPressed: () async {
              await _accountService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Icon(
              Icons.logout_sharp,
              size: 24,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150),
          Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome, $_username!',
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        'User token is , $_token',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
