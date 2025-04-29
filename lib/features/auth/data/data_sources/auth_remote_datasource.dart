import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_3/core/app_constant.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/core/services/cache_helper.dart';
import 'package:flutter_application_3/core/services/secure_storage_sevice.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/features/auth/data/models/sign_up_model.dart';

import '../../../../core/services/firebase_services.dart';

abstract class IAuthDatasource {
  Future<String> signIn({required email, required password});
  Future<RegisterModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    // required String image,
  });
  Future<RegisterModel> getUserData({required String uid});
   Future<void> addUserPinCode({required String pin});
  Future<RegisterModel?> googleLogin();
}

class RemoteDataSource implements IAuthDatasource {
  final user = FirebaseAuth.instance;

  @override
  Future<String> signIn({required email, required password}) async {
    log("email $email password $password");
    String? token;
    await user
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      token = value.user?.uid;
      //  CacheHelper.saveData(key: 'UID', value:value.user?.uid);
    });
    return token ?? '';
  }

  @override
  Future<RegisterModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    RegisterModel? registerModel;
    await user
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async{
      log('user id --------------${value.user?.uid}');
      await  getIt<SecureStorageServices>().saveData(key: 'UID', value: value.user?.uid??" ");
    
      registerModel = RegisterModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          uId: uid,
          );
      uid = value.user?.uid ?? '';
      if(uid!=''){
            await  getIt<SecureStorageServices>().saveData(key: 'UID', value:uid);
      }
      createUser(
        uId: value.user?.uid ?? '',
        registerModel: registerModel!,
      );
    });
    return registerModel!;
  }

  void createUser(
      {required String uId, required RegisterModel registerModel}) async {
        log('uid $uId  ---- $registerModel -- -- ${registerModel}');
    await FirebaseFirestore.instance
        .collection(AppConstant.kUsers)
        .doc(uId)
        .set(registerModel.toMap());

  }
  
  @override
 Future<void> addUserPinCode({required String pin})async {
  log("=============$pin=====================");
       await FirebaseFirestore.instance
        .collection(AppConstant.kUsers)
        .doc(uid)
        .update({'pin': pin});
  }

  @override
  Future<RegisterModel> getUserData({required uid}) async {
    RegisterModel? userData;
    await FirebaseFirestore.instance
        .collection(AppConstant.kUsers)
        .doc(uid)
        .get()
        .then((value) {
      userData = RegisterModel.fromJson(json: value.data());
      userImage = userData?.image ?? '';
    });
    return userData!;
  }

  @override
  Future<RegisterModel?> googleLogin() async{
    RegisterModel? registerModel;
    await FirebaseFile.signInWithGoogle().then((onValue) async {
      User user = onValue.user;
      await newAccount(onValue, user);
      registerModel = await getUserDataFunction(uid: onValue.user.uid);
      await  getIt<SecureStorageServices>().saveData(key: 'UID', value:user.uid);
      return registerModel!;
    });
    return registerModel;
  }
  Future<void> newAccount(onValue, User user) async {
    if (onValue.additionalUserInfo!.isNewUser) {
      RegisterModel registerModel = RegisterModel(firstName: user.displayName, lastName: '', email: user.email, uId: user.uid
          );
      // CustomerModel customerModel = await createCustomer(
      //   registerModel: registerModel,
      // );
       createUser(uId: user.uid, registerModel: registerModel);
    }
  }
  Future<RegisterModel> getUserDataFunction({required uid}) async{
    RegisterModel? registerModel;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      registerModel = RegisterModel.fromJson(json:value.data());
      return  registerModel;
    });
    return  registerModel!;
  }
}
