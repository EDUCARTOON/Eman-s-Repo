import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Popular(),
    );
  }
}

class Course {
  final String title;
  final String category;
  final double rating;
  final int students;
  final String ageGroup;
  bool isFavorite;

  Course({
    required this.title,
    required this.category,
    required this.rating,
    required this.students,
    required this.ageGroup,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'rating': rating,
      'students': students,
      'ageGroup': ageGroup,
      'isFavorite': isFavorite,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      title: map['title'],
      category: map['category'],
      rating: map['rating'],
      students: map['students'],
      ageGroup: map['ageGroup'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  List<Course> favoriteCourses = [];
  List<Course> courses = [
    Course(title: "Education", category: "Education", rating: 3.5, students: 3000, ageGroup: "3-5"),
    Course(title: "Education", category: "Education", rating: 4.2, students: 3500, ageGroup: "5-8"),
    Course(title: "Education", category: "Education", rating: 4.2, students: 3500, ageGroup: "8-12"),
    Course(title: "Religion", category: "Religion", rating: 3.9, students: 2800, ageGroup: "3-5"),
    Course(title: "Religion", category: "Religion", rating: 4.1, students: 3200, ageGroup: "5-8"),
    Course(title: "Religion", category: "Religion", rating: 4.1, students: 3200, ageGroup: "8-12"),
    Course(title: "Technology", category: "Technology", rating: 4.2, students: 4000, ageGroup: "3-5"),
    Course(title: "Technology", category: "Technology", rating: 4.5, students: 4500, ageGroup: "5-8"),
    Course(title: "Technology", category: "Technology", rating: 4.5, students: 4500, ageGroup: "8-12"),
    Course(title: "Civilization", category: "Civilization", rating: 4.9, students: 5000, ageGroup: "3-5"),
    Course(title: "Civilization", category: "Civilization", rating: 4.7, students: 5200, ageGroup: "5-8"),
    Course(title: "Civilization", category: "Civilization", rating: 4.7, students: 5200, ageGroup: "8-12"),
    Course(title: "Entertainment", category: "Entertainment", rating: 4.0, students: 3500, ageGroup: "3-5"),
    Course(title: "Entertainment", category: "Entertainment", rating: 4.3, students: 3800, ageGroup: "5-8"),
    Course(title: "Entertainment", category: "Entertainment", rating: 4.3, students: 3800, ageGroup: "8-12"),
  ];

  String selectedCategory = "All";
  String searchQuery = "";
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteData = prefs.getStringList('favorites') ?? [];
    if (mounted) {
      setState(() {
        for (var course in courses) {
          if (favoriteData.contains(course.title)) {
            course.isFavorite = true;
            if (!favoriteCourses.contains(course)) {
              favoriteCourses.add(course);
            }
          }
        }
      });
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteTitles = favoriteCourses.map((c) => c.title).toList();
    await prefs.setStringList('favorites', favoriteTitles);
  }

  List<Course> get filteredCourses {
    List<Course> filtered = selectedCategory == "All"
        ? courses
        : selectedCategory == "Favorite Courses"
            ? favoriteCourses
            : courses.where((course) => course.category == selectedCategory).toList();
    return filtered.where((course) => course.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  void toggleFavorite(Course course) {
    setState(() {
      course.isFavorite = !course.isFavorite;
      if (course.isFavorite) {
        if (!favoriteCourses.contains(course)) {
          favoriteCourses.add(course);
        }
      } else {
        favoriteCourses.removeWhere((c) => c.title == course.title);
      }
      saveFavorites();
    });
  }

  void setCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _filterCategories(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  Widget _buildFilterButton(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () => setCategory(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == category ? Colors.black : Colors.white,
          foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
        ),
        child: Text(category),
      ),
    );
  }

  void _navigateToCourseDetail(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailPage(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF93AACF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
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
            : const Text("Popular Courses", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search, color: Colors.black),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  _searchController.clear();
                  searchQuery = "";
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFilterButton("All"),
                  if (favoriteCourses.isNotEmpty) _buildFilterButton("Favorite Courses"),
                  _buildFilterButton("Education"),
                  _buildFilterButton("Religion"),
                  _buildFilterButton("Technology"),
                  _buildFilterButton("Civilization"),
                  _buildFilterButton("Entertainment"),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                var course = filteredCourses[index];
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    title: Text("${course.title} (${course.ageGroup})"),             
                    subtitle: Text("⭐ ${course.rating} | ${course.students} Students"),
                    trailing: IconButton(
                      icon: Icon(
                        course.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                        color: course.isFavorite ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => toggleFavorite(course),
                    ),
                    onTap: () => _navigateToCourseDetail(course), // إضافة الدالة هنا
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Category: ${course.category}"),
            Text("Rating: ${course.rating} ⭐"),
            Text("Students: ${course.students}"),
            Text("Age Group: ${course.ageGroup}"),
            SizedBox(height: 20),
            Text("Course Details go here..."),
          ],
        ),
      ),
    );
  }
}

