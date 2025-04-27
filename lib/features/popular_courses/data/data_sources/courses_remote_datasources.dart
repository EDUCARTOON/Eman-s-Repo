import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

abstract class PopularCoursesDataSource{

  Future<Map<dynamic, dynamic>?>fetchCourses({required String path});
  Future<Map<dynamic, dynamic>?>fetchSpecialCourses();

}
class PopularCoursesRemoteDataSource implements PopularCoursesDataSource{
final DatabaseReference ref = FirebaseDatabase.instance.ref();
@override
Future<Map<dynamic, dynamic>?> fetchCourses({required String path}) async{

      //Map<dynamic,dynamic>? data;
      final DatabaseEvent event = await ref.child(path).once();
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      // ref.onValue.listen((event) {
      //   final fetchData = event.snapshot.value as Map<dynamic, dynamic>?;
      //   data = fetchData;
      //   log(fetchData.toString());
      // },);
      //log(data.toString());

return data;


}

  @override
  Future<Map?> fetchSpecialCourses() async{
    //Map<dynamic,dynamic>? data;
    final DatabaseEvent event = await ref.child('downloads').once();
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