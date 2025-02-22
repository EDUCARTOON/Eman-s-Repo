class UserModel {
  final String? name;
  final int? year;
  final String? country;
  final String? phoneNumber;
  final String? image;
  final String? pinCode;
  final String? uid;

  UserModel({
     this.name,
     this.year,
     this.country,
     this.phoneNumber,
     this.image,
     this.pinCode,
     this.uid,
  });

  // Convert a UserModel object to a Map (for storage or API calls)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'year': year,
      'country': country,
      'phoneNumber': phoneNumber,
      'image': image,
      'pinCode': pinCode,
    };
  }

  // Create a UserModel object from a Map (for retrieving from storage or API)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      year: map['year'],
      country: map['country'],
      phoneNumber: map['phoneNumber'],
      image: map['image'],
      pinCode: map['pinCode'],
    );
  }
}
