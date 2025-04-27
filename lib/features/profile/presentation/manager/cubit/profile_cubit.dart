import 'dart:developer';

import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/features/auth/data/models/sign_up_model.dart';
import 'package:flutter_application_3/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';
import 'package:flutter_application_3/features/profile/data/models/user_model.dart';
import 'package:flutter_application_3/features/profile/domain/repositories/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepository}) : super(AuthInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  final  ProfileBaseRepo profileRepository;


  Future<void>fillUserProfile({required UserModel profileModel})async {
        emit(FillUserDataLoadingState());

      final response = await profileRepository.fillUserProfile(profileModel: profileModel);
    response.fold(
        (errMessage){
          if(!isClosed) {
            emit(FillUserDataErrorState(errMessage: errMessage));
          }},
        (userData){if(!isClosed) {
          if(profileModel.pinCode!=null){
            emit(FillUserPinCodeSuccessState());
            return;
          }
           emit(FillUserDataSuccessState());
           
           }});

  }

  Future<void> setFeedback({required String note})async{
    try {
      profileRepository.setFeedback(note: note);
      emit(FeedbackSuccess());
    } catch (e) {
      emit(FeedbackFailure());
    }
  }

  Future<void>addChid({required ChildModel childModel,required bool isAdd})async {
    emit(FillChildDataLoadingState());
      final response = await profileRepository.addChildData(childModel: childModel, isAdd: isAdd);
    response.fold(
        (errMessage){
          if(!isClosed) {
            emit(FillChildDataErrorState(errMessage: errMessage));
          }},
        (userData)async{if(!isClosed) {
          // if(ch.pinCode!=null){
          //   emit(FillUserPinCodeSuccessState());
          //   return;
          // }
       await   getUserChildren();
           emit(FillChildDataSuccessState());
           
           }});

  }

  Future<void>getUserChildren()async {
    log("=====================================");
      if(!isClosed) {
    emit(GetUserChildrenLoadingState());}
      final response = await profileRepository.getUserChildren();
    response.fold(
        (errMessage){
          if(!isClosed) {
            emit(GetUserChildrenErrorState(errMessage: errMessage));
          }},
        (data){if(!isClosed) {
        
           emit(GetUserChildrenSuccessState(children: data));
           
           }});

  }

  // Future<void> getUserData({required String uid}) async {
  //   emit(GetUserDataLoadingState());
  //   final response = await authRepository.getUserProfile(uid: uid);
  //   response.fold(
  //       (errMessage){
  //         if(!isClosed) {
  //           emit(GetUserDataErrorState(errMessage: errMessage));
  //         }},
  //       (userData){if(!isClosed) { emit(GetUserDataSuccessState(userData: userData));}});
  // }
}
