import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
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
      print('uuuuuiiiiddddd$uid');
      return right(response);
    } catch (e) {
      print('errrroooorrrrr');

      return left(e.toString());
    }
  }

  @override
  Future<Either<String, RegisterModel>> signUp({
    required String firstName,
    required String email,
    required String lastName,
    required String password,
    required String image,
  }) async {
    try {
      final response = await remoteDataSource.register(
          firstName: firstName,
          email: email,
          password: password,
          image: image,
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
}
