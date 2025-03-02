import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/core/services/secure_storage_sevice.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/core/utils/failure.dart';
import 'package:flutter_application_3/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:flutter_application_3/features/auth/data/models/sign_up_model.dart';
import 'package:flutter_application_3/features/auth/domain/repositories/auth_repo.dart';

class AuthRepository implements IAuthRepo {
  final RemoteDataSource remoteDataSource;

  AuthRepository({required this.remoteDataSource});

  @override
  Future<Either<String, String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await remoteDataSource.signIn(email: email, password: password);
      uid = response;
    await  getIt<SecureStorageServices>().saveData(key: 'UID', value: response);
      log('uuuuuiiiiddddd=====================$uid');
      return right(response);
    } catch (e) {
      log('errrroooorrrrr');

      return left(e.toString());
    }
  }

  @override
  Future<Either<String, RegisterModel>> signUp({
    required String firstName,
    required String email,
    required String lastName,
    required String password,
    // required String image,
  }) async {
    try {
      final response = await remoteDataSource.register(
          firstName: firstName,
          email: email,
          password: password,
          // image: image,
          lastName: lastName);
      userModel = response;
      return right(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, RegisterModel>> getUserProfile({required uid}) async {
    try {
      // final cachedData=await localDataSource.getUserData();
      // // print(cachedData.image);
      // if(cachedData.image!=null){
      //   return right(cachedData);
      // }
      final response = await remoteDataSource.getUserData(uid: uid);
      userModel = response;
      return right(response);
    } catch (e) {
      return left(e.toString());
    }
  }
    @override

  Future<Either<String, void>> addUserPinCode({
    required String pin
  }) async {
    try {
      final response = await remoteDataSource.addUserPinCode(
         pin: pin);
    
      return right(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> resetPassword( BuildContext context) async {
  log("===============");
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: "abdoalfy140@gmail.com");
    // Optionally, show a success message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset email sent!')),
    );
  } on FirebaseAuthException catch (e) {
    // Handle errors, such as:
    // - User not found
    // - Invalid email format
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message}')),
    );
  }
}

Future<void> sendEmailVerification(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user != null) {
      print(user.uid);
    }
  });
  if (user != null && !user.emailVerified) {
    try {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification email sent!')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  } else if (user == null){
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user is currently logged in.')),
      );
  }
  else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email is already verified.')),
    );
  }
}
  
}
