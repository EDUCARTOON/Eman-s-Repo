import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Categories.dart';
import 'package:flutter_application_3/core/app_constant.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/features/mentors/data/data_sources/mentors_remote_datasources.dart';
import 'package:flutter_application_3/features/mentors/data/models/mentors_model.dart';
import 'package:flutter_application_3/features/mentors/data/repositories/mentors_repo_impl.dart';
import 'package:flutter_application_3/features/mentors/presentation/manager/cubit/mentors_cubit.dart';
import 'package:flutter_application_3/features/popular_courses/Special%20Stars%20Zone/EducationSpe.dart';
import 'package:flutter_application_3/features/popular_courses/Special%20Stars%20Zone/ReligionSpe.dart';
import 'package:flutter_application_3/features/popular_courses/Special%20Stars%20Zone/SpecialStarsZone.dart';
import 'package:flutter_application_3/features/popular_courses/presentation/pages/SpecialCourses.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter_application_3/features/mentors/presentation/pages/top.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../popular_courses/presentation/pages/popular.dart';

class EducartoonScreen extends StatelessWidget {
  const EducartoonScreen({super.key, required course, required String courseTitle});

  @override
  Widget build(BuildContext context) {
    log("${childModel?.fullName}");

    final List<String> categories = [
      'Education', 'Religion', 'Behavior', 'Technology', 'Civilization', 'Entertainment',
    ];

    final List<Map<String, dynamic>> courses = [
      {
        'title': 'Bright Stars Zone',
        'rating': 4.2,
        'students': 7830,
        'instructor': 'Instructor Name',
        'img': 'assets/img/Education 5-8.jpeg.jpg'
      },
      {
        'title': 'Special Stars Zone',
        'rating': 4.1,
        'students': 3980,
        'instructor': 'Instructor Name',
        'img': 'assets/img/Behavior 3-5.jpeg.jpg'
      },
    ];

    return BlocProvider(
      create: (context) => MentorsCubit(
          MentorsRepoImpl(mentorsRemoteDataSource: MentorsRemoteDataSource()))..fetchMentors(),
      child: Scaffold(
        backgroundColor: const Color(0xFF93AACF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Hi, ${childModel?.fullName ?? "Educartoon"}',
            style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeNotifier.value == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                color: Colors.black,
              ),
              onPressed: () {
                themeNotifier.value = themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What Would you like to learn Today?\nSearch Below.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for..',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.tune),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    'assets/img/Hello-Dribbble--unscreen.gif',
                    height: 200,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Categories()),
                        );
                      },
                      child: const Text('SEE ALL', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories
                        .map((category) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CategoryCard(title: category),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Popular Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        // Add navigation to popular courses if needed
                      },
                      child: const Text('', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return GestureDetector(
                        onTap: () {
                          if (course['title'] == 'Bright Stars Zone') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Popular()),
                            );
                          } else if (course['title'] == 'Special Stars Zone') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SpecialStarsZone(course: Course.fromMap(course), courseModel: null,)),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: CourseCard(
                            title: course['title'],
                            rating: course['rating'],
                            students: course['students'],
                            instructor: course['instructor'],
                            img: course['img'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Top Mentor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TopScoreScreen()),
                        );
                      },
                      child: const Text('SEE ALL', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                BlocBuilder<MentorsCubit, MentorsState>(
                  builder: (context, state) {
                    if (state is MentorsSuccess) {
                      return SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.mentors.length,
                          itemBuilder: (context, index) {
                            return MentorCircle(mentor: state.mentors[index]);
                          },
                        ),
                      );
                    } else if (state is MentorsFailure) {
                      return const Center(child: Text('No Data yet..'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  const CategoryCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final double rating;
  final int students;
  final String instructor;
  final String img;

  const CourseCard({
    super.key,
    required this.title,
    required this.rating,
    required this.students,
    required this.instructor,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(instructor, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text('$rating'),
                    const SizedBox(width: 8),
                    const Text('|'),
                    const SizedBox(width: 8),
                    Text('$students Std'),
                    const Spacer(),
                    const Icon(Icons.bookmark_border),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MentorCircle extends StatelessWidget {
  const MentorCircle({super.key, required this.mentor});
  final MentorsModel mentor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: AppConstant.convertGoogleDriveUrl(mentor.img),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(mentor.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}