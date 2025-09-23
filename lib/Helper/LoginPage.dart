import 'accountService.dart';
import 'package:flutter/material.dart';
import 'package:learn_stateful/Helper/HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static bool _isPasswordVisible = false;
  final AccountService _accountService = AccountService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _userToken;
  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    final token = await _accountService.readToken();
    if (token != null) {
      setState(() {
        _userToken = token;
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const HomePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      });
    }
  }

  Future<void> _saveUser() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password.')),
      );
      return; // Stop execution if fields are empty
    }

    await _accountService.saveUser(_usernameController.text);
    await _accountService.saveToken("User${_usernameController.text}001");
    _checkIfLoggedIn(); // This will update _userToken if successful

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const HomePage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );

    _usernameController.clear();
    _passwordController.clear(); // Clear password field as well
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
