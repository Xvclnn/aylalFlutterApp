import 'package:flutter/material.dart';
// We need to import home to reuse the 'TravelCardBig' widget style if you want,
// OR we can just build a simple list tile. Let's build a nice list item here.

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  // THE GLOBAL STORAGE FOR FAVORITES
  // Static means it belongs to the class, not a specific instance.
  // It stays alive as long as the app is running.
  static final List<Map<String, String>> favoriteItems = [];

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEBE6),
      body: SafeArea(
        child: Column(
          children: [
            // Top "Back" button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate back if needed (or do nothing if it's the main tab)
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.keyboard_backspace, color: Color(0xFF6B2F99), size: 20),
                        SizedBox(width: 5),
                        Text(
                          "Буцах",
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Title in the center-right context
                  const Text(
                    "Хадгалсан",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),

            // CONTENT LOGIC
            Expanded(
              child: FavoriteScreen.favoriteItems.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 60, color: Colors.grey[400]),
                    const SizedBox(height: 20),
                    Text(
                      "Одоогоор хадгалагдсан газар байхгүй байна",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: FavoriteScreen.favoriteItems.length,
                itemBuilder: (context, index) {
                  final data = FavoriteScreen.favoriteItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Small Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            data['image']!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Text Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                data['location']!,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Remove Button
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              FavoriteScreen.favoriteItems.removeAt(index);
                            });
                          },
                        ),
                      ],
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