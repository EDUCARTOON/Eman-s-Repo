class CoursesModel {
  final String age;
  final String category;
  final String name;
  final String timestamp;
  final String type;
  final String url;
  CoursesModel({
    required this.age,
    required this.category,
    required this.name,
    required this.timestamp,
    required this.type,
    required this.url,

  });

  factory CoursesModel.fromMap(Map<dynamic, dynamic> map) {
    return CoursesModel(
      age: map['age'] ?? '',
      category: map['category'] ?? '',
      name: map['name'] ?? '',
      timestamp: map['timestamp'] ?? '',
      type: map['type'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
