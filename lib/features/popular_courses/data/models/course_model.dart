class CourseModel {
  final String age;
  final String category;
  final String name;
  final String timestamp;
  final String type;
  final String url;
  final List<String>? videoUrl;
  final List<String>? videoUrl2;

  CourseModel({
    required this.age,
    required this.category,
    required this.name,
    required this.timestamp,
    required this.type,
    required this.url,
    required this.videoUrl,
    required this.videoUrl2,
  });

  factory CourseModel.fromMap(Map<dynamic, dynamic> map) {
    List<String>? parseVideoUrl(dynamic value) {
      if (value == null) return [];
      if (value is String) return [value]; // wrap string in list
      if (value is List) return value.whereType<String>().toList();
      return null;
    }
    return CourseModel(
      age: map['age'] ?? '',
      category: map['category'] ?? '',
      name: map['name'] ?? '',
      timestamp: map['timestamp'] ?? '',
      type: map['type'] ?? '',
      url: map['url'] ?? '',
      videoUrl:parseVideoUrl(map['videoUrl']),
      videoUrl2:parseVideoUrl(map['videoUrl2']),
    );
  }

}
