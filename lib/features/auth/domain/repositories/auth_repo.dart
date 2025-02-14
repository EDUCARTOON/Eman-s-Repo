import 'package:dartz/dartz.dart';
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
    required String image,
  });

  Future<Either<String, RegisterModel>> getUserProfile({required String uid});
}
