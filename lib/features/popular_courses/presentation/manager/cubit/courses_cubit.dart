import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/course_model.dart';
import '../../../data/repositories/courses_repo_impl.dart';

part 'courses_state.dart';

class PopularCoursesCubit extends Cubit<PopularCoursesState> {
  PopularCoursesCubit(this.popularCoursesRepoImpl) : super(PopularCoursesInitial());
  static PopularCoursesCubit get(context) => BlocProvider.of(context);
  final PopularCoursesRepoImpl popularCoursesRepoImpl;
  List<CourseModel>courses = [];
  Future<void> fetchCourses({required String path})async{
    print("process2");
    final response = await popularCoursesRepoImpl.fetchCourses(path: path);
    response.fold(
        (l) {
          emit(PopularCoursesFailure(message: l));

        },
        (r) {
          emit(PopularCoursesSuccess(courses: r));
          courses = r;
        },);
  }
  String urlImg({required String cat, required String age,}){
    try {
      final matchingCourse =  courses.firstWhere(
                (element) => element.category == cat && element.age == age,
          );
      //emit(Founded());
      return  matchingCourse.url;


    } catch (e) {
      //emit(NotFounded());
      return"";
    }
  }
  CourseModel? course({required String cat, required String age,}){
      try {
        final matchingCourse =  courses.firstWhere(
                    (element) => element.category == cat && element.age == age,
              );
        //emit(Founded());
        return  matchingCourse;
      } catch (e) {
        return null ;
      }
  }
}
