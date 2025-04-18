part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class IsObsecurePassState extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {
  final String uid;
  RegisterSuccessState({required this.uid});
}
class RegisterErrorState extends AuthState {
    final String errMessage;
  RegisterErrorState({required this.errMessage});
}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
    final String uid;
  LoginSuccessState({required this.uid});
}
class LoginErrorState extends AuthState {
  final String errMessage;
  LoginErrorState({required this.errMessage});
}

class GetUserDataLoadingState extends AuthState {}
class GetUserDataSuccessState extends AuthState {
   final RegisterModel userData;
   GetUserDataSuccessState({required this.userData});
}
class GetUserDataErrorState extends AuthState {
   final String errMessage;
  GetUserDataErrorState({required this.errMessage});
}

class AddUserPinLoadingState extends AuthState {}
class AddUserPinSuccessState extends AuthState {}
class AddUserPinErrorState extends AuthState {
   final String errMessage;
  AddUserPinErrorState({required this.errMessage});
}


class SendVerifyLoadingState extends AuthState {}
class SendVerifySuccessState extends AuthState {}
class SendVerifyErrorState extends AuthState {
   final String errMessage;
  SendVerifyErrorState({required this.errMessage});
}


class ResetPassLoadingState extends AuthState {}
class ResetPassSuccessState extends AuthState {}
class ResetPassErrorState extends AuthState {
   final String errMessage;
  ResetPassErrorState({required this.errMessage});
}
class SendResetPassLoadingState extends AuthState {}
class SendResetPassSuccessState extends AuthState {}
class SendResetPassErrorState extends AuthState {
   final String errMessage;
  SendResetPassErrorState({required this.errMessage});
}


// class GetUserDataLoadingState extends AuthState {}
// class GetUserDataSuccessState extends AuthState {
//    final RegisterModel userData;
//    GetUserDataSuccessState({required this.userData});
// }
// class GetUserDataErrorState extends AuthState {
//    final String errMessage;
//   GetUserDataErrorState({required this.errMessage});
// }
