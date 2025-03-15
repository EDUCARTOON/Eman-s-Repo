import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/core/utils/failure.dart';
import 'package:flutter_application_3/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:flutter_application_3/features/auth/data/models/sign_up_model.dart';
import 'package:flutter_application_3/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_application_3/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';
import 'package:flutter_application_3/features/profile/data/models/user_model.dart';
import 'package:flutter_application_3/features/profile/domain/repositories/profile_repo.dart';

class ProfileRepoImpl implements ProfileBaseRepo {
  final ProfileDataSource profileRemoteDataSource;

  ProfileRepoImpl({required this.profileRemoteDataSource});

 

  // @override
  // Future<Either<String, RegisterModel>> getUserProfile({required uid}) async {
  //   try {
  //     // final cachedData=await localDataSource.getUserData();
  //     // // print(cachedData.image);
  //     // if(cachedData.image!=null){
  //     //   return right(cachedData);
  //     // }
  //     final response = await remoteDataSource.getUserData(uid: uid);
  //     userModel = response;
  //     return right(response);
  //   } catch (e) {
  //     return left(e.toString());
  //   }
  // }

  @override
  Future<Either<String, void>> fillUserProfile({required UserModel profileModel})async {
     try {
      final response =
          await profileRemoteDataSource.fillUserProfile(profileModel: profileModel  );
      return right(response);
    } catch (e) {

      return left(e.toString());
    }
  }
  
  @override
  Future<Either<String, RegisterModel>> getUserProfile({required String uid}) => throw UnimplementedError();

  @override
  Future<Either<String, void>> addChildData({required ChildModel childModel,required bool isAdd}) async{
   try {
      final response =
          await profileRemoteDataSource.addChildData(childModel: childModel, isAdd: isAdd  );
      return right(response);
    } catch (e) {

      return left(e.toString());
    }
  }

    @override
  Future<Either<String, List<ChildModel>>> getUserChildren() async{
   try {
      final response =
          await profileRemoteDataSource.getUserChildren();
        final List<ChildModel> children = response.map((e) => ChildModel.fromMap(e)).toList();

      return right(children);
    } catch (e) {

      return left(e.toString());
    }
  }
}
