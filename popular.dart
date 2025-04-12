// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Educartoon.dart';

void main() {
  runApp(const Popular());
}

class Popular extends StatelessWidget {
  const Popular({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopularCoursesScreen(),
    );
  }
}

class PopularCoursesScreen extends StatefulWidget {
  const PopularCoursesScreen({super.key});

  @override
  _PopularCoursesScreenState createState() => _PopularCoursesScreenState();
}

class _PopularCoursesScreenState extends State<PopularCoursesScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  String searchQuery = "";

  final List<Map<String, dynamic>> courses = [
    {'title': 'Education', 'rating': 4.2, 'students': 7830},
    {'title': 'Religion', 'rating': 3.9, 'students': 12680},
    {'title': 'Technology', 'rating': 4.2, 'students': 990},
    {'title': 'Civilization', 'rating': 4.9, 'students': 14580},
    {'title': 'Entertainment', 'rating': 4.5, 'students': 7500},
  ];

  List<Map<String, dynamic>> filteredCourses = [];

  @override
  void initState() {
    super.initState();
    filteredCourses = courses;
  }

  void _filterCourses(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredCourses = courses.where((course) {
        return course['title'].toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0C4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                onChanged: _filterCourses,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search for courses...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black, fontSize: 18),
              )
            : const Text(
                "Popular Courses",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search, color: Colors.black),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  _searchController.clear();
                  filteredCourses = courses;
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Favorite', true),
                _buildCategoryButton('All', false),
                _buildCategoryButton('Education', false),
                _buildCategoryButton('Religion', false),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                return _buildCourseCard(filteredCourses[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'MY COURSES'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'INBOX'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Container(
          width: 50,
          height: 50,
          color: Colors.black,
        ),
        title: Text(
          course['title'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 5),
            Text('${course['rating']}'),
            const SizedBox(width: 10),
            Text('${course['students']} Std'),
          ],
        ),
        trailing: const Icon(Icons.bookmark, color: Colors.green),
      ),
    );
  }
}




