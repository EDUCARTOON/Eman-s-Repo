part of 'mentors_cubit.dart';

abstract class MentorsState  {
  const MentorsState();

  // @override
  // List<Object> get props => [];
}

class MentorsInitial extends MentorsState {}
class MentorsSuccess extends MentorsState {
  final List<MentorsModel> mentors;

  MentorsSuccess({required this.mentors});
}
class MentorsFailure extends MentorsState {
  final String message;

  MentorsFailure({required this.message});
}
