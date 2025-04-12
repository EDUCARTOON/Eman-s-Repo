// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/courses/data/data_sources/courses_remote_datasources.dart';
import 'package:flutter_application_3/features/courses/data/repositories/courses_repo_impl.dart';
import 'package:flutter_application_3/features/popular_courses/presentation/pages/popular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/course_model.dart';
import '../manager/cubit/courses_cubit.dart';

void main() {
  runApp(
    const CoursesScreenApp(),
  );
}
class CoursesScreenApp extends StatelessWidget {
  const CoursesScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoursesScreen(),
    );
  }
}


class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  bool isCompleted = true;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesCubit(
        CoursesRepoImpl(
          coursesRemoteDataSource: CoursesRemoteDataSource(),
        ),
      )..fetchCourses(),
      child: Scaffold(
      backgroundColor: const Color(0xFFB0C4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Courses Screen',
          style:
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for ...',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search, color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isCompleted = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isCompleted ? Colors.green : Colors.grey[300],
                      ),
                      child: const Text("Completed",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isCompleted = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isCompleted ? Colors.grey[300] : Colors.green,
                      ),
                      child: const Text("Ongoing",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CoursesCubit, CoursesState>(
              builder: (context, state) {
                if (state is CoursesSuccess) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(
                          isCompleted: isCompleted, course: state.courses[index]);
                    },
                  );
                } else if (state is CoursesFailure) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    ),
);
  }
}

class CourseCard extends StatelessWidget {
  final bool isCompleted;
  final CourseModel course;
  const CourseCard(
      {super.key, required this.isCompleted, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl:course.url, // Replace with your actual image URL
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 50,
              height: 50,
              color: Colors.grey[300],
              child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            errorWidget: (context, url, error) => Container(
              width: 50,
              height: 50,
              color: Colors.grey,
              child: const Icon(Icons.error, color: Colors.red),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Course Name",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text("Instructor Name",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text("4.5", style: TextStyle(fontSize: 14)),
                    SizedBox(width: 10),
                    Text("2 Hrs 30 Mins",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                if (!isCompleted)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class CourseCard extends StatelessWidget {
//   final bool isCompleted;
//   const CourseCard({super.key, required this.isCompleted});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             color: Colors.black,
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text("Course Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const Text("Instructor Name", style: TextStyle(fontSize: 14, color: Colors.grey)),
//                 const SizedBox(height: 4),
//                 const Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.amber, size: 16),
//                     SizedBox(width: 4),
//                     Text("4.5", style: TextStyle(fontSize: 14)),
//                     SizedBox(width: 10),
//                     Text("2 Hrs 30 Mins", style: TextStyle(fontSize: 14, color: Colors.grey)),
//                   ],
//                 ),
//                 if (!isCompleted)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: LinearProgressIndicator(
//                       value: 0.7,
//                       backgroundColor: Colors.grey[300],
//                       color: Colors.green,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
