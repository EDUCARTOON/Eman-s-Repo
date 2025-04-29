import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseFile {
  static final dbRef = FirebaseDatabase.instance.ref();
  static const String parentId = "uploads";
  //............................................................
  //to add a value into child of uploads

  static void add1({required String childId}) {
    final path = dbRef.child("$parentId/$childId");
    path.update({
      "thumbnail":
          "https://your-thumbnail-url.com/image.jpg" //put value and key like this
    });
  }

  //............................................................
//to add a video with info
  void add2({required String childId, required String videoId}) {
    final path = dbRef.child("$parentId/$childId/$videoId");
    path.push().set({
      "name": "", //video name
      "time": 0, // video time
      "url": "", // video url
      "thumbnail": "" // video thumbnail
    });
  }

//............................................................
//to add a value in video
  static void addFeedback({required String note}) {
    final path = dbRef.child("feedback");
    path.push().set({
      "feedbackNote": note,
    });
  }

  static Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(clientId: '373074661731-hvs5uf5fkaga8b2etd04t5nfkl1qkiqb.apps.googleusercontent.com',).signIn();
      final GoogleSignInAuthentication gAuth = await googleUser!.authentication;
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
