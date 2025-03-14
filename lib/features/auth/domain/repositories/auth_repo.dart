import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/utils/failure.dart';
import 'package:flutter_application_3/features/auth/data/models/sign_up_model.dart';

abstract class IAuthRepo {
  Future<Either<String, String>> signIn({
    required String email,
    required String password,
  });

  Future<Either<String, RegisterModel>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Either<String, RegisterModel>> getUserProfile({required String uid});
    Future<Either<String, void>> addUserPinCode({
    required String pin
  }) ;
  
Future<bool> isEmailVerified(String email, BuildContext context);
 Future<Either<String, void>> sendEmailVerification(BuildContext context) ;
  Future<Either<String, void>>resetUserPassword(String newPassword, BuildContext context);
Future<Either<String, void>>sendPassResetToEmail(String email);
}

