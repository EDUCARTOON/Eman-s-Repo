import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

abstract class PopularCoursesDataSource{

  Future<Map<dynamic, dynamic>?>fetchCourses();

}
class PopularCoursesRemoteDataSource implements PopularCoursesDataSource{
final DatabaseReference ref = FirebaseDatabase.instance.ref().child('uploads');
@override
Future<Map<dynamic, dynamic>?> fetchCourses() async{

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