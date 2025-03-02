import 'dart:developer';

import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/features/auth/data/models/sign_up_model.dart';
import 'package:flutter_application_3/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  final AuthRepository authRepository;

  String? passwordRegisValidator(value) {
    if (value!.isEmpty) {
      return 'Please enter your Email';
    } else if (value!.length < 8 ||
        !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])').hasMatch(value)) {
      return 'Password must be at least 8 characters with a mix of uppercase, lowercase, and numbers';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value!.isEmpty) {
      return 'Please enter your Email';
    } else if (!RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  bool isPassword = true;
  void passvisibility() {
    isPassword = !isPassword;
    emit(IsObsecurePassState());
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
        log("cubit email $email password $password");

    final response =
        await authRepository.signIn(email: email, password: password);
    response.fold((errMessage) {
      emit(LoginErrorState(errMessage: errMessage));
    }, (uid) {
      if(!isClosed) {
        emit(LoginSuccessState(uid: uid));
      }
    });
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String image,
  }) async {
    emit(RegisterLoadingState());
    final response = await authRepository.signUp(
      firstName: firstName,
      email: email,
      password: password,
      
      lastName: lastName,
    );
    response.fold(
      (errMessage){
        log("============error====${errMessage}");
        if(!isClosed) { emit(RegisterErrorState(errMessage: errMessage));}},
      (r) {

        if(!isClosed) {
        emit(RegisterSuccessState(uid: uid));}
      },
    );
  }

  Future<void> getUserData({required String uid}) async {
    emit(GetUserDataLoadingState());
    final response = await authRepository.getUserProfile(uid: uid);
    response.fold(
        (errMessage){
          if(!isClosed) {
            emit(GetUserDataErrorState(errMessage: errMessage));
          }},
        (userData){if(!isClosed) { emit(GetUserDataSuccessState(userData: userData));}});
  }

    Future<void> addUserPinCode({required String pin}) async {
      if(!isClosed) {
    emit(AddUserPinLoadingState());}
    final response = await authRepository.addUserPinCode(pin: pin);
    response.fold(
        (errMessage){
          if(!isClosed) {
            emit(AddUserPinErrorState(errMessage: errMessage));
          }},
        (userData){if(!isClosed) { emit(AddUserPinSuccessState());}});
  }
}
