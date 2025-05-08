import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/WRITE%20A%20REVIEWS.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseFile {
  static final dbRef = FirebaseDatabase.instance.ref();
  static const String parentId = "uploads";
  //............................................................


  static Future<void> addResult(String email, String title, String age, String result, String QuizTitle) async {
    final firestore = FirebaseFirestore.instance;

    // Get user document by email
    final userQuery = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (userQuery.docs.isEmpty) {
      print(' No user found with email $email');
      return;
    }

    final userDoc = userQuery.docs.first.reference;
    final docRef = userDoc.collection('QuizResult').doc('$title$age');

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final existingData = docSnapshot.data();
      final List<dynamic> quizList = existingData?['quiz'] ?? [];

      bool updated = false;

      // Modify existing quiz result if QuizTitle matches
      for (var item in quizList) {
        if (item['QuizTitle'] == QuizTitle) {
          item['Result'] = result; // update result
          updated = true;
          break;
        }
      }

      // If QuizTitle not found, add a new one
      if (!updated) {
        quizList.add({
          'QuizTitle': QuizTitle,
          'Result': result,
        });
      }

      await docRef.update({'quiz': quizList});
      print(updated
          ? '✅ Existing quiz result updated.'
          : '✅ New quiz result added to existing document.');
    } else {
      // Document doesn't exist, create new one
      await docRef.set({
        'quiz': [
          {
            'QuizTitle': QuizTitle,
            'Result': result,
          }
        ]
      });
      print('✅ New document created and quiz result added.');
    }
  }


  //............................................................
  //to add a value into child of uploads

  static void add1({required String childId}) {
    final path = dbRef.child("$parentId/$childId/videoUrl1/0");
    path.push().set([
    ]);
  }

  static void addVideoToList({
    required String childId,
  }) async {
    final databaseReference = FirebaseDatabase.instance.ref();

    // Define the path to the list (videoUrl1)
    final path = databaseReference.child("esheDeaf/$childId/videoUrl1");

    // Fetch the current list from Firebase
    final snapshot = await path.once();
    List<dynamic> videoUrl1List = [];

    if (snapshot.snapshot.value != null) {
      // If the list exists, cast it to a List<dynamic>
      videoUrl1List = List<dynamic>.from(snapshot.snapshot.value as Iterable);
    }

    // Create the new video item
    final newVideo =    {
      "name": "Ai",
      "thumbnail": "https://drive.google.com/file/d/1Ln1mL0MI6pd43qX7l7qR3JU6thk2tCY6/view?usp=sharing",
      "time":128,
      "url": "https://drive.google.com/file/d/1X1wVvb1mDRq1iOpqzOWNUr2dsn_Ew-NM/view?usp=sharing"
    };

    // Add the new video item to the list
    videoUrl1List.add(newVideo);

    // Save the updated list back to Firebase (without keys)
    await path.set(videoUrl1List);

    print("New video added to the list.");
  }
  //................................................

  static void addVideoPartToList({
    required String videoId,
    required String childId,
    required List<Map<String, dynamic>> part2Videos,
  }) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    final path = databaseReference.child("$parentId/$childId/$videoId");

    // Fetch the current list from Firebase
    final snapshot = await path.once();
    List<dynamic> existingList = [];

    if (snapshot.snapshot.value != null) {
      existingList = List<dynamic>.from(snapshot.snapshot.value as List);
    }


    // Create the map for part2
    final Map<String, dynamic> part2Entry = {
      "part2": part2Videos,
    };

    // Insert it at index 0
    existingList.insert(2, part2Entry);

    // Save the updated list back to Firebase
    await path.set(existingList);

    print("Part2 videos added to the list at index 0.");
  }

  static void addFeedback({required Review review}) {
    final path = dbRef.child("feedback");
    path.push().set(review.toJson());
  }

  //.......................................................................
  static Future<void> copyUploadData(String fromId, String toId) async {
    final db = FirebaseDatabase.instance;
    final sourceRef = db.ref('uploads/$fromId');
    final destRef = db.ref('downloads/$toId');

    try {
      final snapshot = await sourceRef.get();
      if (snapshot.exists) {
        await destRef.set(snapshot.value);
        print('Data copied from $fromId to $toId successfully.');
      } else {
        print('No data found at uploads/$fromId');
      }
    } catch (e) {
      print('Error copying upload data: $e');
    }
  }

//....................................................................
  static Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('Google sign-in was cancelled by the user.');
        return;
      }
      final GoogleSignInAuthentication gAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (onError) {
      print(onError.toString());
    }
  }
}
