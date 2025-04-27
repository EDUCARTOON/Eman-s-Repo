import 'package:dartz/dartz.dart';

import '../../data/models/course_model.dart';

abstract class PopularCourseRepo {
 Future <Either<String, List<CourseModel>>> fetchCourses({required String path});
}