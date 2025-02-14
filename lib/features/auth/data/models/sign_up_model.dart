import 'package:hive/hive.dart';
part 'sign_up_model.g.dart';

@HiveType(typeId: 0)
class RegisterModel {
  @HiveField(0)
  final String? firstName;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String uId;
  @HiveField(3)
  final String? lastName;
  @HiveField(4)
  final String? image;

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uId,
    this.image,
  });

  factory RegisterModel.fromJson({required Map<String, dynamic>? json}) {
    return RegisterModel(
      firstName: json?['firstName'] ?? '',
      lastName: json?['lastName'] ?? '',
      email: json?['email'] ?? '',
      uId: json?['uid'] ?? "",
      image: json?['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'uid': uId,
      'image': image,
    };
  }
}
