// import statements
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/CivilizationCourses.dart';
import 'package:flutter_application_3/EntertainmentCourses.dart';
import 'package:flutter_application_3/ReligionCourses.dart';
import 'package:flutter_application_3/StartCourses.dart';
import 'package:flutter_application_3/TechnologyCourses.dart';
import 'package:flutter_application_3/BehaviorCourses.dart';
import 'package:flutter_application_3/core/app_constant.dart';
import 'package:flutter_application_3/features/popular_courses/data/repositories/courses_repo_impl.dart';
import 'package:flutter_application_3/features/popular_courses/presentation/manager/cubit/courses_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/routing/routes.dart';
import '../../../layout/layout_body.dart';
import '../../data/data_sources/courses_remote_datasources.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Popular(),
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
      title: map['title'] ?? '', // التأكد من عدم وجود null هنا
      category: map['category'] ?? '',
      rating: map['rating'] ?? 0.0,
      students: map['students'] ?? 0,
      ageGroup: map['ageGroup'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}

class Popular extends StatefulWidget {
  const Popular({super.key});
  @override
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
    Course(title: "Behavior", category: "Behavior", rating: 3.8, students: 3100, ageGroup: "3-5"),
    Course(title: "Behavior", category: "Behavior", rating: 4.0, students: 3400, ageGroup: "5-8"),
    Course(title: "Behavior", category: "Behavior", rating: 4.3, students: 3700, ageGroup: "8-12"),
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
    return filtered
        .where((course) => course.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
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
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () => setCategory(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == category ? Colors.black : Colors.white,
          foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
        ),
        child: Text(category, style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularCoursesCubit(
        PopularCoursesRepoImpl(
          popularCoursesRemoteDataSource: PopularCoursesRemoteDataSource(),
        ),
      )..fetchCourses(),
      child: Scaffold(
        backgroundColor: const Color(0xFF93AACF),
        appBar: AppBar(
          backgroundColor: const Color(0xFF93AACF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.pushReplacement(Routes.layoutScreen);
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
                  style: const TextStyle(color: Colors.black, fontSize: 16),
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
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterButton("All"),
                    if (favoriteCourses.isNotEmpty) _buildFilterButton("Favorite Courses"),
                    _buildFilterButton("Education"),
                    _buildFilterButton("Religion"),
                    _buildFilterButton("Civilization"),
                    _buildFilterButton("Technology"),
                    _buildFilterButton("Entertainment"),
                    _buildFilterButton("Behavior"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<PopularCoursesCubit, PopularCoursesState>(
                builder: (context, state) {
                  if (state is NotFounded) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      var course = filteredCourses[index];
                      var course1 = PopularCoursesCubit.get(context);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 3), // ✅ بوردر أسود للكارت كله
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartCoursesApp(
                                    course: courses[index],
                                    courseModel: course1.course(
                                      age: course.ageGroup,
                                      cat: course.category,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 3), // ✅ بوردر أسود للصورة
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl: AppConstant.convertGoogleDriveUrl(
                                          course1.urlImg(age: course.ageGroup, cat: course.category),
                                        ), // التأكد من وجود قيمة URL للصورة
                                        width: 90,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          color: Colors.grey[300],
                                          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          color: Colors.grey[300],
                                          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${course.title} (${course.ageGroup})",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 8),
                                        Text("⭐ ${course.rating} | ${course.students} Students",
                                            style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            icon: Icon(
                                              course.isFavorite
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: course.isFavorite ? Colors.green : Colors.grey,
                                            ),
                                            onPressed: () => toggleFavorite(course),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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

