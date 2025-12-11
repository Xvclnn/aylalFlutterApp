import 'package:flutter/material.dart';
import 'place.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const List<Map<String, String>> places = [
    {
      "name": "Цонжин болдог",
      "location": "Ulaanbaatar, ND-5 Khoroo",
      "image": "assets/images/slide1.png",
    },
    {
      "name": "Мэлхий Хад",
      "location": "Ulaanbaatar, ND-6 Khoroo",
      "image": "assets/images/slide2.png",
    },
    {
      "name": "Тайхар Чулуу",
      "location": "Arkhangai, Ih tamir",
      "image": "assets/images/slide3.png",
    },
    {
      "name": "Хорго тогоо",
      "location": "Arkhangai, Tariat sum",
      "image": "assets/images/slide4.png",
    },
    {
      "name": "Улаан Цутгалан",
      "location": "Uwurkhangai, Bat-Ulzii",
      "image": "assets/images/slide5.png",
    },
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE3F2FD),
                  Color(0xFFF3E5F5),
                  Colors.white,
                ],
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Хаашаа аялах вэ?",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.search, color: Colors.black87),
                        suffixIcon: const Icon(Icons.more_horiz, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Санал болгож буй газрууд",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9F7BF6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Илүү",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 380,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: HomeScreen.places.length,
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    itemBuilder: (context, index) {
                      final data = HomeScreen.places[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaceScreen(placeData: data),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: TravelCard(
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
        ],
      ),
    );
  }
}

class TravelCard extends StatelessWidget {
  final String name;
  final String location;
  final String imagePath;

  const TravelCard({
    required this.name,
    required this.location,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, color: Colors.grey),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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