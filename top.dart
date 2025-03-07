import 'package:flutter/material.dart';
import 'package:flutter_application_3/Educartoon.dart';

void main() {
  runApp(const TopScreen());
}

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopScoreScreen(),
    );
  }
}

class TopScoreScreen extends StatefulWidget {
  const TopScoreScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TopScoreScreenState createState() => _TopScoreScreenState();
}

class _TopScoreScreenState extends State<TopScoreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> categories = [
    'Education',
    'Religion',
    'Technology',
    'Civilization',
    'Behavior',
    'Entertainment',
  ];
  
  List<String> filteredCategories = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    filteredCategories = categories;
  }

  void _filterCategories(String query) {
    setState(() {
      filteredCategories = categories
          .where((category) => category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF89A1C0), // لون الخلفية الأزرق
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Educartoon()),
            );
          },
        ),
        title: isSearching
            ? TextField(
                controller: _searchController,
                onChanged: _filterCategories,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black, fontSize: 18),
              )
            : const Row(
                children: [
                  Text(
                    "Top score",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.emoji_events, color: Colors.amber, size: 28), // رمز النجمة
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search, color: Colors.black),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  _searchController.clear();
                  filteredCategories = categories;
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredCategories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25, // حجم الدائرة السوداء
                ),
                title: Text(
                  "name",
                  style: TextStyle(
                    fontSize: 14,
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                subtitle: Text(
                  filteredCategories[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(
                color: Colors.black, // الخط الفاصل بين العناصر
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'MY COURSES'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'INBOX'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
        ],
      ),
    );
  }
}
