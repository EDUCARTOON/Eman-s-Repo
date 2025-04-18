import 'dart:developer';

import 'package:flutter_application_3/features/courses/data/models/course_model.dart';
import 'package:flutter_application_3/features/courses/data/repositories/courses_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/course_model.dart';
import '../../../data/repositories/courses_repo_impl.dart';

part 'courses_state.dart';

class PopularCoursesCubit extends Cubit<PopularCoursesState> {
  PopularCoursesCubit(this.popularCoursesRepoImpl) : super(PopularCoursesInitial());
  static PopularCoursesCubit get(context) => BlocProvider.of(context);
  final PopularCoursesRepoImpl popularCoursesRepoImpl;
  List<CourseModel>courses = [];
  Future<void> fetchCourses()async{
    final response = await popularCoursesRepoImpl.fetchCourses();
    response.fold(
        (l) {
          emit(PopularCoursesFailure(message: l));

        },
        (r) {
          emit(PopularCoursesSuccess(courses: r));
          courses = r;
          print(r[0].videoUrl1.length);
          log(r.toString());
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
        print(e);
        return null ;
      }
  }
}
