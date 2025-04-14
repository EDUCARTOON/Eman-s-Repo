class CourseModel {

  final String age;
  final String category;
  final String name;
  final DateTime timestamp;
  final String type;
  final String url;
  final List<VideoInfo> videoUrl1;
  final List<VideoInfo> videoUrl2;

  CourseModel({

    required this.age,
    required this.category,
    required this.name,
    required this.timestamp,
    required this.type,
    required this.url,
    required this.videoUrl1,
    required this.videoUrl2,
  });

  factory CourseModel.fromJson( Map<dynamic, dynamic> json) {
    return CourseModel(

      age: json['age'],
      category: json['category'],
      name: json['name'],
      timestamp: DateTime.parse(json['timestamp']),
      type: json['type'],
      url: json['url'],
      videoUrl1: json['videoUrl1']== null? [] :(json['videoUrl1'] as List<dynamic>)
          .map((e) => VideoInfo.fromJson(e))
          .toList(),
      videoUrl2: json['videoUrl2']== null? [] :(json['videoUrl2'] as List<dynamic>)
          .map((e) => VideoInfo.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'category': category,
      'name': name,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
      'url': url,
      'videoUrl1': videoUrl1.map((e) => e.toJson()).toList(),
      'videoUrl2': videoUrl2.map((e) => e.toJson()).toList(),
    };
  }
}

class VideoInfo {
  final String time;
  final String url;
  final String name;
  VideoInfo( {
    required this.time,
    required this.url,
    required this.name
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      time: json['time'],
      url: json['url'],
      name:json['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'url': url,
    };
  }
}
