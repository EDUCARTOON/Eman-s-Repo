import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
            print(errMessage);
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

  Future<void>updateProfile({ // email to find the user
    required String newEmail, // new email to update
    required Map<String, dynamic> childData,
  })async{
    final usersRef = FirebaseFirestore.instance.collection('users');

    try {
      // Step 1: Find user by old email
      final querySnapshot = await usersRef.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        print('No user found with email: $email');
        return;
      }

      final userDoc = querySnapshot.docs.first;
      final userId = userDoc.id;

      // Step 2: Update user email
      await usersRef.doc(userId).update({'email': newEmail});
      print('User email updated to $newEmail');

      // Step 3: Update child data
      await usersRef
          .doc(userId)
          .collection('children')
          .doc(childModel!.docId)
          .update(childData);
      final childDoc = await usersRef
          .doc(userId)
          .collection('children')
          .doc(childModel!.docId)
          .get();
      childModel = ChildModel.fromMap(childDoc.data()!);
      emit(UpdateSuccess());
      print('Child data updated successfully!');
    } catch (e) {
      emit(UpdateFailure());
      print('Error updating data: $e');
    }
  }
}
