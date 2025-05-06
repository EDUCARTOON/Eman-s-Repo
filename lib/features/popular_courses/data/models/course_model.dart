
import 'package:firebase_database/firebase_database.dart';

class CourseModel {
  final String age;
  final String category;
  final String name;
  final String timestamp;
  final String type;
  final String url;
  final List<VideoInfo> videoUrl1;

  CourseModel({
    required this.age,
    required this.category,
    required this.name,
    required this.timestamp,
    required this.type,
    required this.url,
    required this.videoUrl1,

  });

  // Factory method to parse data from Firebase (cast to Map<String, dynamic>)
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      age: json['age'] ?? '',
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      timestamp: json['timestamp']??"",
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      videoUrl1: (json['videoUrl1'] != null)
          ? (json['videoUrl1'] is List
          ? (json['videoUrl1'] as List)
          .whereType<Map>() // only keep maps
          .map((e) => VideoInfo.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          : (json['videoUrl1'] as Map).values
          .whereType<Map>() // only keep maps
          .map((e) => VideoInfo.fromJson(Map<String, dynamic>.from(e)))
          .toList())
          : [],



    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'category': category,
      'name': name,
      'timestamp': timestamp,
      'type': type,
      'url': url,
      'videoUrl1': videoUrl1.map((e) => e.toJson()).toList(),

    };
  }
}

class VideoInfo {
  final int time;
  final String url;
  final String name;
  final String thumbnail;
  final List<Part2> part2;

  VideoInfo({
    required this.time,
    required this.url,
    required this.name,
    required this.thumbnail,
    required this.part2,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      time: json['time'] ?? 0,
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      part2: (json['part2'] != null)
          ? (json['part2'] is List
          ? (json['part2'] as List)
          .whereType<Map>() // only keep maps
          .map((e) => Part2.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          : (json['part2'] as Map).values
          .whereType<Map>() // only keep maps
          .map((e) => Part2.fromJson(Map<String, dynamic>.from(e)))
          .toList())
          : [],


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'url': url,
      'name': name,
      'thumbnail': thumbnail,
      'part2': part2.map((e) => e.toJson()).toList(), // ✅ Added this line
    };
  }
}

class Part2 {
  final int time;
  final String url;
  final String name;
  final String thumbnail;

  Part2({
    required this.time,
    required this.url,
    required this.name,
    required this.thumbnail,

  });

  factory Part2.fromJson(Map<String, dynamic> json) {
    return Part2(
      time: json['time'] ?? 0,
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      thumbnail: json['thumbnail']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'url': url,
      'name': name,
    };
  }
}

// Fetch data from Firebase
// Future<void> fetchCourseData() async {
//   DatabaseReference reference = FirebaseDatabase.instance.reference().child('courses');
//
//   DataSnapshot snapshot = await reference.child("ONG9-oeMRIaCEFMSuk0").once();
//
//   if (snapshot.exists) {
//     // Ensure that the data is cast to Map<String, dynamic>
//     Map<String, dynamic> courseJson = Map<String, dynamic>.from(snapshot.value as Map);
//     CourseModel course = CourseModel.fromJson(courseJson);
//     print(course.name);  // Example: '9477.jpg'
//     print(course.videoUrl1[0].name);  // Example: 'Hello Song'
//   } else {
//     print("Course data not found");
//   }
// }
