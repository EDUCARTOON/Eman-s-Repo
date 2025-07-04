import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/popular_courses/presentation/pages/popular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Down5-15Ente/BabyAndCat.dart';
import '../../../../Down5-15Ente/HalloweenBusTrip.dart';
import '../../../../Down5-15Ente/SnackChoice.dart';
import '../../../../Down5-15be/CaringForAnimals.dart';
import '../../../../Down5-15be/PlayingWithFriends.dart';
import '../../../../Down5-15be/UnderstandingEmotion.dart';
import '../../../../Down5-15cilv/AncientEgypt.dart';
import '../../../../Down5-15cilv/TimeTravelEgypt.dart';
import '../../../../Down5-15edu/Englishletterd.dart';
import '../../../../Down5-15edu/HealthyFoodsd.dart';
import '../../../../Down5-15edu/dayofweekd.dart';
import '../../../../Down5-15relig/AllahYaranad.dart';
import '../../../../Down5-15relig/ArkanImand.dart';
import '../../../../Down5-15relig/ArkanIslamd.dart';
import '../../../../Down5-15tecn/InternetandFiles.dart';
import '../../../../Down5-15tecn/MoreTechTools.dart';
import '../../../../Down5-15tecn/Technologytool.dart';
import '../../../../StartCourses.dart';
import '../../../../core/app_constant.dart';
import '../../data/data_sources/courses_remote_datasources.dart';
import '../../data/repositories/courses_repo_impl.dart';
import '../manager/cubit/courses_cubit.dart';

class Downsyndrome extends StatefulWidget {
  final Course? course;
  final dynamic courseModel;

  const Downsyndrome({super.key, this.course, this.courseModel});

  @override
  _DownSyndromeState createState() => _DownSyndromeState();
}

class _DownSyndromeState extends State<Downsyndrome> {
  String selectedCategory = "All";
  String searchQuery = "";
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  // ignore: unused_field
  bool _isFavoriteSelected = false;

  final List<String> _filtersBase = [
    'All',
    'Education',
    'Religion',
    'Civilization',
    'Technology',
    'Entertainment',
    'Behavior'
  ];

  List<String> get _filters {
    List<String> filters =
        ['All'] + _filtersBase.where((f) => f != 'All').toList();
    if (_courses.any((course) => course.isFavorite)) {
      filters.insert(1, 'Favorites Courses');
    }
    return filters;
  }

  final List<CourseItem> _courses = [
    CourseItem(
        title: 'Education',
        ageGroup: '5-15',
        rating: 3.5,
        students: 3000,
        quiz: [
          HealthyFoodsd(),
          Dayofweek(),
          Englishletterd()
        ]),
    // CourseItem(title: 'Education Down', ageGroup: '5-15', rating: 4.2, students: 3500),
    //  CourseItem(title: 'Education Down', ageGroup: '5-15', rating: 4.2, students: 3500),
    CourseItem(
        title: 'Religion',
        ageGroup: '5-15',
        rating: 3.9,
        students: 2800,
        quiz: [
          ArkanIslamQuiz(),
          AllahYaranad(),
          ArkanImand()
        ]),
    // CourseItem(title: 'Religion Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    // CourseItem(title: 'Religion Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    CourseItem(
        title: 'Technology',
        ageGroup: '5-15',
        rating: 3.9,
        students: 2800,
        quiz: [
          Technologytool(),
          InternetandFiles(),
          MoreTechTools()

        ]),
    // CourseItem(title: 'Technology Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    // CourseItem(title: 'Technology Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    CourseItem(
        title: 'Civilization',
        ageGroup: '5-15',
        rating: 3.9,
        students: 2800,
        quiz: [
          AncientEgypt(),
          TimeTravelEgypt()
        ]),
    //  CourseItem(title: 'Civilization Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    // CourseItem(title: 'Civilization Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    CourseItem(
        title: 'Entertainment',
        ageGroup: '5-15',
        rating: 3.9,
        students: 2800,
        quiz: [
          HalloweenBusTripQuizApp(),
          SnackChoicesQuizApp(),
          BabyAndCatQuizApp()
        ]),
    // CourseItem(title: 'Entertainment Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    // CourseItem(title: 'Entertainment Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    CourseItem(
        title: 'Behavior',
        ageGroup: '5-15',
        rating: 3.9,
        students: 2800,
        quiz: [
          PlayingWithFriendsQuizApp(),
          CaringForAnimalsQuizApp(),
          UnderstandingEmotionsQuizApp()
        ]),
    // CourseItem(title: 'Behavior Down', ageGroup: '5-15', rating: 4.1, students: 3200),
    // CourseItem(title: 'Behavior Down', ageGroup: '5-15', rating: 4.1, students: 3200),
  ];

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
        for (var course in _courses) {
          if (favoriteData.contains(course.title)) {
            course.isFavorite = true;
          }
        }
      });
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteTitles =
        _courses.where((c) => c.isFavorite).map((c) => c.title).toList();
    await prefs.setStringList('favorites', favoriteTitles);
  }

  List<CourseItem> get filteredCourses {
    if (selectedCategory == "All") {
      return _courses
          .where((course) =>
              course.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else if (selectedCategory == "Favorites Courses") {
      return _courses
          .where((course) =>
              course.isFavorite &&
              course.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else {
      return _courses
          .where((course) =>
              course.title
                  .toLowerCase()
                  .contains(selectedCategory.toLowerCase()) &&
              course.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  void toggleFavorite(CourseItem course) {
    setState(() {
      course.isFavorite = !course.isFavorite;
      saveFavorites();
    });
  }

  void setCategory(String category) {
    setState(() {
      selectedCategory = category;
      _isFavoriteSelected = category == 'Favorites Courses';
    });
  }

  void _filterCategories(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  Widget _buildFilterButton(String category) {
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () => setCategory(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.black : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
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
      )..fetchCourses(path: "downloads"),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF93AACF),
          elevation: 0,
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
              : const Text("Down Syndrome",
                  style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search,
                  color: Colors.black),
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
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters
                      .map((filter) => _buildFilterButton(filter))
                      .toList(),
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
                      // var course = filteredCourses[index];
                      var course1 = PopularCoursesCubit.get(context);
                      final course = filteredCourses[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.black,
                                width: 3), // ✅ بوردر أسود للكارت كله
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartCoursesPage(
                                    //course: courses[index],
                                    courseItem: _courses[index],
                                    courseModel: course1.course(
                                      age: course.ageGroup,
                                      cat: course.title,
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
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 3), // ✅ بوردر أسود للصورة
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            AppConstant.convertGoogleDriveUrl(
                                          course1.urlImg(
                                              age: course.ageGroup,
                                              cat: course.title),
                                        ), // التأكد من وجود قيمة URL للصورة
                                        width: 90,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.grey[300],
                                          child: const Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2)),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: Colors.grey[300],
                                          child: const Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${course.title} (${course.ageGroup})",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 8),
                                        Text(
                                            "⭐ ${course.rating} | ${course.students} Students",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            icon: Icon(
                                              course.isFavorite
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: course.isFavorite
                                                  ? Colors.green
                                                  : Colors.grey,
                                            ),
                                            onPressed: () =>
                                                toggleFavorite(course),
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

class CourseItem {
  final String title;
  final String ageGroup;
  final double rating;
  final int students;
  bool isFavorite;
  List<Widget> quiz;
  CourseItem({
    required this.title,
    required this.quiz,
    required this.ageGroup,
    required this.rating,
    required this.students,
    this.isFavorite = false,
  });
}
