part of 'courses_cubit.dart';

abstract class PopularCoursesState  {
  const PopularCoursesState();

  // @override
  // List<Object> get props => [];
}

class PopularCoursesInitial extends PopularCoursesState {}
class PopularCoursesSuccess extends PopularCoursesState {
  final List<CourseModel> courses;

  PopularCoursesSuccess({required this.courses});
}
class PopularCoursesFailure extends PopularCoursesState {
  final String message;

  PopularCoursesFailure({required this.message});
}
class Founded extends PopularCoursesState {}
class NotFounded extends PopularCoursesState {}