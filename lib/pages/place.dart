import 'package:flutter/material.dart';
import 'favorite.dart';

class PlaceScreen extends StatefulWidget {
  final Map<String, String> placeData;

  const PlaceScreen({super.key, required this.placeData});

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    // Check if this place is already in the static favorites list
    isFavorited = FavoriteScreen.favoriteItems.any((item) => item['name'] == widget.placeData['name']);
  }

  void _toggleFavorite() {
    setState(() {
      if (isFavorited) {
        // Remove from favorites
        FavoriteScreen.favoriteItems.removeWhere((item) => item['name'] == widget.placeData['name']);
        isFavorited = false;
      } else {
        // Add to favorites
        FavoriteScreen.favoriteItems.add(widget.placeData);
        isFavorited = true;
      }
    });
  }

  // Helper to get description based on name (Since your Home list didn't have descriptions yet)
  String _getDescription(String name) {
    if (name.contains("Цонжин")) {
      return "Энд дэлхийн хамгийн өндөр морьт хөшөө болох Чингис хаан морьт хөшөө (30 м өндөр) оршдог.\n\nХөшөөний доод хэсэгт Чингис хаан болон XIII зууны түүхэн музей бий.\n\nГадаа талбайд XIII зууны үеийн жуулчны цогцолбор.\n\nЧингис хаан энэ газраас Алтан шарга морийг олсон гэдэг тул энэхүү газар 'Цонжин Болдог' хэмээн нэрлэгджээ.";
    } else if (name.contains("Мэлхий")) {
      return "Төв аймгийн Эрдэнэ сумын нутагт, Улаанбаатараас ~70 км зай байрлах байгалийн өвөрмөц тогтоцтой хад.\n\nДээрээс нь харахад яг л аварга том мэлхий шиг.\n\nОйр орчимд аялал жуулчлалын гэрүүд, амрах талбай, гэрэл зураг авах боломж элбэг.\n\nДомогт өгүүлснээр энэ мэлхий хэлбэртэй хад, муу ёрын зүйлээс хамгаалдаг сахиус гэж үздэг.";
    } else if (name.contains("Тайхар")) {
      return "Архангай аймгийн Их тамир сумын нутагт, Тамир голын эрэг дээр байрладаг. 18 метр орчим өндөр чулууны гадаргуу дээр эртний олон төрлийн бичээс, дүрс, тамга тэмдэг байдаг.";
    } else if (name.contains("Хорго")) {
      return "Архангай аймгийн Тариат суманд байрлах галт уулын тогооны хэлбэртэй асар том хонхор.\n\nОйролцоогоор 8-10 мянган жилийн өмнө өрнөсөн галт уулын дэлбэрэлтээс үүссэн.";
    } else if (name.contains("Улаан")) {
      return "Архангай аймгийн Батцэнгэл сумын нутагт байрлах Монголын хамгийн үзэсгэлэнт усан хүрхрээ.\n\n24 метр өндөр цутгалантай, хурдан урсгалтай.";
    }
    return "Дэлгэрэнгүй мэдээлэл одоогоор байхгүй байна.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Full Screen Background Image
          Positioned.fill(
            child: Image.asset(
              widget.placeData['image']!,
              fit: BoxFit.cover,
            ),
          ),

          // 2. Dark Gradient Overlay (To make white text readable if needed, or just aesthetic)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),

          // 3. Top Navigation (Back Button and Heart)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                // Favorite Heart Button
                GestureDetector(
                  onTap: _toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 4. Bottom Info Card (The White Area)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45, // Takes up bottom 45%
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.placeData['name']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.grey, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.placeData['location']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Divider
                    Divider(color: Colors.grey[200]),
                    const SizedBox(height: 20),
                    // Description Text
                    Text(
                      _getDescription(widget.placeData['name']!),
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6, // Line height for readability
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}