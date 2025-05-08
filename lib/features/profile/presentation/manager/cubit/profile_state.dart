part of 'profile_cubit.dart';

sealed class ProfileState {}

final class AuthInitial extends ProfileState {}


class GetUserDataLoadingState extends ProfileState {}
class GetUserDataSuccessState extends ProfileState {
   final RegisterModel userData;
   GetUserDataSuccessState({required this.userData});
}
class GetUserDataErrorState extends ProfileState {
   final String errMessage;
  GetUserDataErrorState({required this.errMessage});
}

class FillUserDataLoadingState extends ProfileState {}
class FillUserDataSuccessState extends ProfileState {
   FillUserDataSuccessState();
}
class FillUserPinCodeSuccessState extends ProfileState {
   FillUserPinCodeSuccessState();
}
class FillUserDataErrorState extends ProfileState {
   final String errMessage;
  FillUserDataErrorState({required this.errMessage});
}

class FillChildDataLoadingState extends ProfileState {}
class FillChildDataSuccessState extends ProfileState {
}

class FillChildDataErrorState extends ProfileState {
   final String errMessage;
  FillChildDataErrorState({required this.errMessage});
}

class GetUserChildrenLoadingState extends ProfileState {}
class GetUserChildrenSuccessState extends ProfileState {
     final List<ChildModel> children;
  GetUserChildrenSuccessState({required this.children});
}

class GetUserChildrenErrorState extends ProfileState {
   final String errMessage;
  GetUserChildrenErrorState({required this.errMessage});
}
class FeedbackSuccess extends ProfileState{}
class FeedbackFailure extends ProfileState{}

class UpdateSuccess extends ProfileState{}
class UpdateFailure extends ProfileState{}
class GetFeedbacksLoadingState extends ProfileState {}
class GetFeedbacksSuccessState extends ProfileState {
}

class GetFeedbacksErrorState extends ProfileState {
}