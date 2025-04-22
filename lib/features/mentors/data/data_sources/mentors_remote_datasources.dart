import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

abstract class MentorsDataSource{

  Future<Map<dynamic, dynamic>?>fetchMentors();

}
class MentorsRemoteDataSource implements MentorsDataSource{
final DatabaseReference ref = FirebaseDatabase.instance.ref().child('mentors');
@override
Future<Map<dynamic, dynamic>?> fetchMentors() async{
      //Map<dynamic,dynamic>? data;
      final DatabaseEvent event = await ref.once();
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      // ref.onValue.listen((event) {
      //   final fetchData = event.snapshot.value as Map<dynamic, dynamic>?;
      //   data = fetchData;
      //   log(fetchData.toString());
      // },);
      //log(data.toString());
return data;

}



}