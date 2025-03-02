import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';

import '../models/user_model.dart';

abstract class ProfileDataSource { 
  Future<void> fillUserProfile({required UserModel profileModel});
  Future<void> addChildData({required ChildModel childModel,required bool isAdd});
  Future<List<dynamic>> getUserChildren() ;
 }

 class ProfileRemoteDataSource implements ProfileDataSource {
  @override
Future<void> fillUserProfile({required UserModel profileModel}) async {
  CollectionReference profileCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("profile");
   QuerySnapshot profileSnapshot = await profileCollection.get();
  // Check if pinCode is not empty
  if (profileModel.pinCode!=null) {
    if (profileSnapshot.docs.isNotEmpty) {
      // If a document exists, update the pinCode in the first document found
      await profileCollection.doc(profileSnapshot.docs.first.id).update({
        "pinCode": profileModel.pinCode,
      });
    } else {
      // If no document exists, create a new one with only the pinCode
      await profileCollection.doc("pinCode").set({"pinCode": profileModel.pinCode});
    }
    return;
  }
  if (profileSnapshot.docs.isNotEmpty) {
      await profileCollection.doc(profileSnapshot.docs.first.id).update(profileModel.toMap());
    }else{
  await profileCollection.add(profileModel.toMap());
    }

}
  @override

Future<void> addChildData({required ChildModel childModel,required bool isAdd}) async {
  log("==============isAdd==============$isAdd===============$isAddChild");
  CollectionReference profileCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("children");
  QuerySnapshot querySnapshot = await profileCollection
      .where(FieldPath.documentId, isEqualTo: childModel.docId)
      .get();

  if (querySnapshot.docs.isNotEmpty&&!isAddChild) {
    String existingDocId = querySnapshot.docs.first.id;
    await profileCollection.doc(existingDocId).update(childModel.toMap());
    print("✅ Child updated successfully!");
  } else {
        DocumentReference newChildRef = profileCollection.doc(); // Auto-generate ID
    String newDocId = newChildRef.id;
    childModel.docId = newDocId;
    await profileCollection.doc(childModel.docId).set(childModel.toMap());
    print("✅ New child added successfully!");
  }
}

  @override

Future<List<dynamic>> getUserChildren() async {
  CollectionReference profileCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("children");
    return await profileCollection.get().then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}


 }

