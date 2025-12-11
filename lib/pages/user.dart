import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEBE6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.keyboard_backspace, color: Color(0xFF6B2F99), size: 20),
                          SizedBox(width: 5),
                          Text("Буцах", style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/avatar_placeholder.png"),
                child: Icon(Icons.person, size: 40, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                "Username",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "@user1234",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E4DF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.person_outline, size: 28),
                    const SizedBox(height: 20),
                    _buildInfoRow("Хэрэглэгчийн нэр:", "Username"),
                    const SizedBox(height: 15),
                    _buildInfoRow("@user:", "@user1234"),
                    const SizedBox(height: 15),
                    _buildInfoRow("Нууц үг:", "********"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildSettingsButton("Privacy Policy", Icons.lock_outline),
              _buildSettingsButton("Settings", Icons.settings_outlined),

              _buildSettingsButton(
                  "Logout",
                  Icons.logout,
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label ",
          style: TextStyle(fontSize: 13, color: Colors.black87.withOpacity(0.7)),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
  Widget _buildSettingsButton(String text, IconData icon, {VoidCallback? onTap}) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC48B72),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        onPressed: onTap ?? () {},
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}