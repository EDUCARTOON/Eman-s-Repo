import 'package:dartz/dartz.dart';
import 'package:flutter_application_3/features/courses/data/models/course_model.dart';

abstract class CourseRepo {
 Future <Either<String, List<CourseModel>>> fetchCourses();
}