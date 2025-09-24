import 'dart:math';
import 'accountService.dart';
import 'package:flutter/material.dart';
import 'package:learn_stateful/Helper/HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final AccountService _accountService = AccountService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    final token = await _accountService.readToken();
    if (token != null && mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const HomePage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  Future<void> _saveUser() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          showCloseIcon: true,
          elevation: 1.5,
          content: Text("Please enter both password & username"),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
      return; // Stop execution if fields are empty
    }

    try {
      await _accountService.saveUser(_usernameController.text);
      await _accountService.saveToken("User${_usernameController.text}001");

      _usernameController.clear();
      _passwordController.clear(); // Clear password field as well

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on Exception catch (e) {
      debugPrint('Login error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 190),
            Icon(
              Icons.account_circle,
              size: 150,
              weight: 100,
              color: Color.fromARGB(255, 255, 8, 160),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              cursorColor: Color.fromARGB(255, 0, 0, 0),
              decoration: InputDecoration(
                labelText: 'Email',
                floatingLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 197, 37, 181),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 195, 255, 210),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              cursorColor: Color.fromARGB(255, 0, 0, 0),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible =
                          !_isPasswordVisible; // Toggle visibility
                    });
                  },
                ),

                labelText: 'Password',
                floatingLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 197, 37, 181),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _saveUser(),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(400, 50),
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 255, 8, 160),
              ),
              child: const Text('Login', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
