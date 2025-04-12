import 'dart:developer';

import 'package:flutter_application_3/features/courses/data/models/course_model.dart';
import 'package:flutter_application_3/features/courses/data/repositories/courses_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit(this.coursesRepoImpl) : super(CoursesInitial());
  static CoursesCubit get(context) => BlocProvider.of(context);
  final CoursesRepoImpl coursesRepoImpl;
  Future<void> fetchCourses()async{
    final response = await coursesRepoImpl.fetchCourses();
    response.fold(
        (l) {
          emit(CoursesFailure(message: l));

        },
        (r) {
          emit(CoursesSuccess(courses: r));
          log(r.toString());
        },);
  }
}
