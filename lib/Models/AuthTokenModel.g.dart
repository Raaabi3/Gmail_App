// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthTokenModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthTokenModelAdapter extends TypeAdapter<AuthTokenModel> {
  @override
  final int typeId = 3;

  @override
  AuthTokenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthTokenModel(
      accessToken: fields[0] as String,
      refreshToken: fields[1] as String,
      expiry: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AuthTokenModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.refreshToken)
      ..writeByte(2)
      ..write(obj.expiry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthTokenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
