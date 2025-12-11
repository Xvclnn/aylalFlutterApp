// login.dart
import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:http/http.dart' as http; // New import for networking
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

const String _baseUrl = 'http://10.0.2.2:8000';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        final body = json.decode(response.body);
        _error = body['detail'] ?? "Нэвтрэх алдаа гарлаа";
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      _error = "Сүлжээний алдаа эсвэл сервер ажиллахгүй байна.";
      return false;
    }
  }
  void _handleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final username = _userController.text.trim();
    final password = _passController.text.trim();
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
        _error = "Нэр эсвэл нууц үг хоосон байна.";
      });
      return;
    }
    final success = await login(username, password);
    setState(() => _isLoading = false);
    if (success) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: Colors.black.withOpacity(0.65),
            ),
          ),
          //
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "ТА МОНГОЛ ОРНООР АЯЛМААР БАЙНА УУ...",
                    style: TextStyle(
                      color: const Color(0xFF6F9E9C),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      shadows: [
                        Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 4,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  TextField(
                    controller: _userController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: _passController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_error != null)
                    Text(_error!, style: const TextStyle(color: Colors.redAccent)),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Нэвтрэх'),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Шинэ хэрэглэгч? ",
                          style: TextStyle(color: Colors.white)),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/signup'),
                        child: const Text(
                          "Бүртгүүлэх",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}