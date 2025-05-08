import 'package:dartz/dartz.dart';
import 'package:flutter_application_3/core/utils/failure.dart';
import 'package:flutter_application_3/features/auth/data/models/sign_up_model.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';
import 'package:flutter_application_3/features/profile/data/models/user_model.dart';

import '../../presentation/pages/WRITE A REVIEWS.dart';

abstract class ProfileBaseRepo {
  Future<Either<String, void>> fillUserProfile({
    required UserModel profileModel,
  });

  Future<Either<String, RegisterModel>> getUserProfile({required String uid});
   Future<Either<String, void>> addChildData({required ChildModel childModel,required bool isAdd});
     Future<Either<String, List<ChildModel>>> getUserChildren();
    Future<void> setFeedback({required Review review});
  Future<Either<String, List<Review>>>fetchFeedbacks();
}

