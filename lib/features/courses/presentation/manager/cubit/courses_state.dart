part of 'courses_cubit.dart';

abstract class CoursesState  {
  const CoursesState();

  // @override
  // List<Object> get props => [];
}

class CoursesInitial extends CoursesState {}
class CoursesSuccess extends CoursesState {
  final List<CoursesModel> courses;

  CoursesSuccess({required this.courses});
}
class CoursesFailure extends CoursesState {
  final String message;

  CoursesFailure({required this.message});
}
