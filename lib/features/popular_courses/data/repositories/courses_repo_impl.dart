import 'package:dartz/dartz.dart';

import 'package:flutter_application_3/features/courses/data/models/course_model.dart';

import '../../domain/repositories/courses_repo.dart';
import '../data_sources/courses_remote_datasources.dart';

class PopularCoursesRepoImpl implements PopularCourseRepo {
  final PopularCoursesRemoteDataSource popularCoursesRemoteDataSource;

  PopularCoursesRepoImpl({required this.popularCoursesRemoteDataSource});

  @override
  Future <Either<String, List<CourseModel>>> fetchCourses() async{
    try {
      final courses = await popularCoursesRemoteDataSource.fetchCourses();
      // List<CourseModel> coursesList = [];
      // if (courses != null) {
      //   courses.forEach((key, value) {
      //     coursesList.add(CourseModel.fromMap(value));
      //   });
      // }
      // return right(coursesList);

      return right(courses!.entries.map((entry) {
        return CourseModel.fromMap(entry.value);
      }).toList());
    } catch (e) {
      return left(e.toString());
    }
  }
}
