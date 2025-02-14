// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterModelAdapter extends TypeAdapter<RegisterModel> {
  @override
  final int typeId = 0;

  @override
  RegisterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterModel(
      firstName: fields[0] as String?,
      email: fields[1] as String?,
      uId: fields[2] as String,
      lastName: fields[3] as String?,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.uId)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
