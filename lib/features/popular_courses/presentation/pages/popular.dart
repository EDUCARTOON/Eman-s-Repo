import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/CivilizationCourses.dart';
import 'package:flutter_application_3/EntertainmentCourses.dart';
import 'package:flutter_application_3/ReligionCourses.dart';
import 'package:flutter_application_3/StartCourses.dart';
import 'package:flutter_application_3/TechnologyCourses.dart';
import 'package:flutter_application_3/BehaviorCourses.dart'; // تأكد من أن لديك ملف BehaviorCourses.dart
import 'package:flutter_application_3/educartoon_screen.dart';
import 'package:flutter_application_3/features/popular_courses/data/repositories/courses_repo_impl.dart';
import 'package:flutter_application_3/features/popular_courses/presentation/manager/cubit/courses_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: Popular(courseTitle: '', course: null,),
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
  const Popular({super.key, required String courseTitle, required course});

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
    // أضف المزيد من الدورات حسب الحاجة
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
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () => setCategory(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == category ? Colors.black : Colors.white,
          foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
        ),
        child: Text(category, style: const TextStyle(fontSize: 12)), // تقليل حجم النص
      ),
    );
  }

  // void _navigateToCourseDetail(Course course) {
  //   Map<String, Widget> coursePages = {
  //     //"Education": StartCoursesApp(course: course),
  //     "Religion": ReligionCoursesApp(course: course),
  //     "Civilization": CivilizationCoursesApp(course: course),
  //     "Technology": TechnologyCoursesApp(course: course),
  //     "Entertainment": EntertainmentCoursesPage(course: course),
  //     "Behavior": BehaviorCoursesApp(course: course),
  //   };
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => coursePages[course.category] ?? BehaviorCoursesApp(course: course),
  //     ),
  //   );
  // }
  String convertGoogleDriveUrl(String url) {
    final regex = RegExp(r'd/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    } else {
      return"";
    }
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EducartoonScreen(
                  courseTitle: "Default Title", // حط عنوان مناسب هنا
                  course: null, // أو حط كائن حقيقي لو متوفر
                ),
              ),
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                if (state is NotFounded){
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    var course = filteredCourses[index];
                    var course1 =PopularCoursesCubit.get(context);
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: SizedBox(
                          width: 80,
                          height:100,
                          child: CachedNetworkImage(
                            imageUrl: convertGoogleDriveUrl(course1.urlImg(age: course.ageGroup,cat: course.category)),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[300],
                              child: const Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2)),
                            ),
                            errorWidget: (context, url, error) =>
                                Container(
                                  color: Colors.grey,
                                  child: const Icon(Icons.error,
                                      color: Colors.red),
                                ),
                          ),
                        ),
                        title: Text("${course.title} (${course.ageGroup})"),
                        subtitle: Text(
                            "⭐ ${course.rating} | ${course.students} Students"),
                        trailing: IconButton(
                          icon: Icon(
                            course.isFavorite
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: course.isFavorite
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () => toggleFavorite(course),
                        ),
                        onTap: () =>Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartCoursesApp(course: courses[index], courseModel: course1.courses[index],)
                          ),
                        ) ,//_navigateToCourseDetail(course),
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
