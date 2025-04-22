import 'package:dartz/dartz.dart';


import '../../domain/repositories/courses_repo.dart';
import '../data_sources/courses_remote_datasources.dart';
import '../models/course_model.dart';

class PopularCoursesRepoImpl implements PopularCourseRepo {
  final PopularCoursesRemoteDataSource popularCoursesRemoteDataSource;

  PopularCoursesRepoImpl({required this.popularCoursesRemoteDataSource});

  @override
  Future<Either<String, List<CourseModel>>> fetchCourses() async {
    try {
      final courses = await popularCoursesRemoteDataSource.fetchCourses();

      if (courses == null) {
        return right([]);
      }

      // Properly handle the casting for each course entry
      return right(
        courses.entries.map((entry) {
          // Ensure that the data is properly cast to Map<String, dynamic>
          final itemMap = Map<String, dynamic>.from(entry.value as Map);
          return CourseModel.fromJson(itemMap);
        }).toList(),
      );
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

}
