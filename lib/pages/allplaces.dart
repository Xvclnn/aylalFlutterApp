import 'package:flutter/material.dart';
import 'home.dart';
import 'place.dart';

class AllPlacesScreen extends StatelessWidget {
  const AllPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEBE6),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
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

            // Title
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Бүх газрууд",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                itemCount: HomeScreen.places.length,
                itemBuilder: (context, index) {
                  final data = HomeScreen.places[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaceScreen(placeData: data),
                          ),
                        );
                      },
                      child: TravelCardBig(
                        name: data['name']!,
                        location: data['location']!,
                        imagePath: data['image']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TravelCardBig extends StatelessWidget {
  final String name;
  final String location;
  final String imagePath;

  const TravelCardBig({
    required this.name,
    required this.location,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}