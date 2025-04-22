class MentorsModel {
  final String name;
  final String img;

  MentorsModel({
    required this.name,
    required this.img,
  });

  factory MentorsModel.fromMap(Map<dynamic, dynamic> map) {
    return MentorsModel(
      name: map['name'] ?? '',
      img: map['imgUrl'] ?? '',
    );
  }
}
