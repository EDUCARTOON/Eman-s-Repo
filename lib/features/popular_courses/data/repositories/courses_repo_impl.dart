import 'package:dartz/dartz.dart';

import 'package:flutter_application_3/features/courses/data/models/course_model.dart';

import '../../domain/repositories/courses_repo.dart';
import '../data_sources/courses_remote_datasources.dart';
import '../models/course_model.dart';

class PopularCoursesRepoImpl implements PopularCourseRepo {
  final PopularCoursesRemoteDataSource popularCoursesRemoteDataSource;

  PopularCoursesRepoImpl({required this.popularCoursesRemoteDataSource});

  @override
  Future <Either<String, List<CourseModel>>> fetchCourses() async{
    try {
      print("process started");
      final courses = await popularCoursesRemoteDataSource.fetchCourses();
      // List<CourseModel> coursesList = [];
      // if (courses != null) {
      //   courses.forEach((key, value) {
      //     coursesList.add(CourseModel.fromMap(value));
      //   });
      // }
      // return right(coursesList);
      if (courses == null)return right([]);
      return right(courses.entries.map((entry) {
        final itemMap = entry.value as Map<dynamic, dynamic> ;
        return CourseModel.fromJson(itemMap);
      }).toList());
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }
}
