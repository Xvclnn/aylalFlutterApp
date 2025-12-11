// signup.dart
import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:http/http.dart' as http; // New import for networking
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// --- CONFIGURATION ---
// IMPORTANT: Replace with your actual FastAPI server URL.
// Use '10.0.2.2' for Android emulator to access 'localhost' on your host machine.
const String _baseUrl = 'http://10.0.2.2:8000';
// --- CONFIGURATION ---

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> signup(String username, String password) async {
    final url = Uri.parse('$_baseUrl/signup');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        // Successful signup
        return;
      } else {
        // Signup failed (e.g., user already exists)
        final body = json.decode(response.body);
        throw Exception(body['detail'] ?? "Бүртгүүлэхэд алдаа гарлаа.");
      }
    } catch (e) {
      // Network or other unexpected error
      print('Signup error: $e');
      throw Exception("Сүлжээний алдаа эсвэл сервер ажиллахгүй байна.");
    }
  }

  void _handleSignup() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final username = _userController.text.trim();
    final password = _passController.text.trim();

    // Simple client-side validation
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
        _error = "Нэр эсвэл нууц үг хоосон байна.";
      });
      return;
    }

    try {
      await signup(username, password);
      if (!mounted) return;
      // On success, navigate to the main app screen
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // e.toString() will include the 'Exception: ' prefix, so we clean it up
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      setState(() => _error = errorMessage);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ... Background Image and Blur (No change)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.65),
            ),
          ),

          // SIGNUP UI (No major change)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "FITNESS ТӨЛӨВЛӨГӨӨ",
                    style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,),
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
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Бүртгүүлэх'),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Бүртгэлтэй юу? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Нэвтрэх",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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