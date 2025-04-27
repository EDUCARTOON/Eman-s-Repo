import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  // قائمة الفئات
  final List<Map<String, String>> categories = [
    {"title": "Education", "imagePath": "assets/img/v__16_-removebg-preview (1).png"},
    {"title": "Religion", "imagePath": "assets/img/v__18_-removebg-preview 1.png"},
    {"title": "Technology", "imagePath": "assets/img/v__14_-removebg-preview 1.png"},
    {"title": "Civilization", "imagePath": "assets/img/v__15_-removebg-preview (1).png"},
    {"title": "Behavior", "imagePath": "assets/img/v__13_-removebg-preview (1).png"},
    {"title": "Entertainment", "imagePath": "assets/img/v__17_-removebg-preview 1.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF), // لون الخلفية
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'All Category',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // مربع البحث
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search for..',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // عرض الفئات
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: categories
                    .where((category) => category["title"]!.toLowerCase().contains(searchQuery))
                    .map((category) => CategoryCard(
                          title: category["title"]!,
                          imagePath: category["imagePath"]!,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// عنصر الفئة الفردي
class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryCard({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 90, height:90), // حذف الإطار
        const SizedBox(height:10),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}

