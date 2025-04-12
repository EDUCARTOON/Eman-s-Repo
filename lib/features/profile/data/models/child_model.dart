class ChildModel {
  final String image;
  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
   List<int> favoriteTopicsIndexes;
   String? docId;
  

  ChildModel({
    required this.image,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.favoriteTopicsIndexes,
    this.docId
  });

  // Convert Profile to JSON
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'favoriteTopicsIndexes': favoriteTopicsIndexes,
      'docId': docId
    };
  }

  // Create Profile from JSON
  factory ChildModel.fromMap(Map<String, dynamic> json) {
    return ChildModel(
      image: json['image'],
      fullName: json['fullName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      favoriteTopicsIndexes: List<int>.from(json['favoriteTopicsIndexes']),
            docId: json['docId'],
    );
  }
}
