class MentorsModel {
  final String name;
  final String img;
  final String cat;

  MentorsModel({
    required this.name,
    required this.img,
    required this.cat,
  });

  factory MentorsModel.fromMap(Map<dynamic, dynamic> map) {
    return MentorsModel(
      name: map['name'] ?? '',
      img: map['imgUrl'] ?? '',
      cat:map['cat'] ?? ''
    );
  }
}
