import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/home.dart';
import 'pages/allplaces.dart';
import 'pages/favorite.dart';
import 'pages/user.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aylal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const MainEntryPage(),
      },
    );
  }
}

class MainEntryPage extends StatefulWidget {
  const MainEntryPage({super.key});

  @override
  State<MainEntryPage> createState() => _MainEntryPageState();
}

class _MainEntryPageState extends State<MainEntryPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const AllPlacesScreen(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildCustomBottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNavBar() {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_filled, 0),
          _buildNavItem(Icons.favorite_border, 1),
          _buildNavItem(Icons.location_on_outlined, 2),
          _buildNavItem(Icons.person_outline, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: isSelected
            ? const BoxDecoration(
          color: Color(0xFF8B5CF6),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x408B5CF6),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        )
            : null,
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}