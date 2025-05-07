import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseFile {
  static final dbRef = FirebaseDatabase.instance.ref();
  static const String parentId = "uploads";
  //............................................................
  //to add a value into child of uploads

  static void add1({required String childId}) {
    final path = dbRef.child("$parentId/$childId/videoUrl1/0");
    path.push().set([
      {
        "name": "الادوات التكنولوجيا الجزء الاول1",
        "time": 126,
        "url":
            "https://drive.google.com/file/d/1r1ErB6EOvSLlaSULyxnGWs1XPu127E2O/view?usp=sharing",
        "thumbnail": "",
        'part2': [
          {
            "name": "الادوات التكنولوجيا الجزء الاول2",
            "time": 92,
            "url":
                "https://drive.google.com/file/d/1666agjVrNbeFiJSlHtFrk5zNRgBBZBQT/view?usp=sharing",
            "thumbnail": "",
          }
        ]
        //put value and key like this
      },
      {
        "name": "الادوات التكنولوجيا الجزء الثاني1",
        "time": 146,
        "url":
        "https://drive.google.com/file/d/1NauvQaDH8_NE7-6EvoKqFFM5tPUvSdxQ/view?usp=sharing",
        "thumbnail": "",
        'part2': [
          {
            "name": "الادوات التكنولوجيا الجزء الثاني2",
            "time": 114,
            "url":
            "https://drive.google.com/file/d/1-Thenj9CdY2suDZm3cpzPBl8MbQLzBsf/view?usp=sharing",
            "thumbnail": "",
          }
        ]
        //put value and key like this
      },
      {
        "name": "الادوات التكنولوجيا الجزء الثالث1",
        "time": 132,
        "url":
        "https://drive.google.com/file/d/1PzgL-9aHQaakIqn_aSDwnqte7Yt_rKl5/view?usp=sharing",
        "thumbnail": "",
        'part2': [
          {
            "name": "الادوات التكنولوجيا الجزء الثالث2",
            "time": 117,
            "url":
            "https://drive.google.com/file/d/1ct2zTB4Ab772hDwo1wWW7Ku8taYKC4YZ/view?usp=sharing",
            "thumbnail": "",
          }
        ]
        //put value and key like this
      }
    ]);
  }

  //............................................................
//to add a video with info
//   static void add2({required String childId, required String videoId}) {
//     final path = dbRef.child("$parentId/$childId/$videoId");
//     path.push().set({
//       "name": "", //video name
//       "time": 0, // video time
//       "url": "", // video url
//       "thumbnail": "" // video thumbnail
//     });
//   }

//............................................................
//to add a value in videourl1

  static void addVideoToList({
    required String childId,
  }) async {
    final databaseReference = FirebaseDatabase.instance.ref();

    // Define the path to the list (videoUrl1)
    final path = databaseReference.child("$parentId/$childId/videoUrl1");

    // Fetch the current list from Firebase
    final snapshot = await path.once();
    List<dynamic> videoUrl1List = [];

    if (snapshot.snapshot.value != null) {
      // If the list exists, cast it to a List<dynamic>
      videoUrl1List = List<dynamic>.from(snapshot.snapshot.value as Iterable);
    }

    // Create the new video item
    final newVideo =  {
      "name": "الذكاء الاصطناعي (1)",
      "time": 48,
      "url":
      "https://drive.google.com/file/d/1SEI8etfjFWXnb4QWVeqbfBzutSj0wa_v/view?usp=sharing",
      "thumbnail": "",
      'part2': [
        {
          "name": "الذكاء الاصطناعي (2)",
          "time": 38,
          "url":
          "https://drive.google.com/file/d/15b68dcYHyiPdqIE7caU99UTEwPnnh7U7/view?usp=sharing",
          "thumbnail": "",
        }
      ]
      //put value and key like this
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

    // Create the list of video maps for "part2"
    // final List<Map<String, dynamic>> part2Videos = [
    //   {
    //     "name": "Lesson 1",
    //     "time": 0,
    //     "url": "https://example.com/video1.mp4",
    //     "thumbnail": "https://example.com/thumb1.jpg",
    //   },
    //   {
    //     "name": "Lesson 2",
    //     "time": 0,
    //     "url": "https://example.com/video2.mp4",
    //     "thumbnail": "https://example.com/thumb2.jpg",
    //   },
    // ];

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

  static void addFeedback({required String note}) {
    final path = dbRef.child("feedback");
    path.push().set({
      "feedbackNote": note,
    });
  }

  //.......................................................................
  static Future<void> copyUploadData(String fromId, String toId) async {
    final db = FirebaseDatabase.instance;
    final sourceRef = db.ref('uploads/$fromId');
    final destRef = db.ref('uploads/$toId');

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
