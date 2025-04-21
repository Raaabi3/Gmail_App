// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmailModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmailModelAdapter extends TypeAdapter<EmailModel> {
  @override
  final int typeId = 1;

  @override
  EmailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmailModel(
      id: fields[0] as String,
      subject: fields[1] as String,
      sender: fields[2] as String,
      recipient: fields[3] as String,
      body: fields[4] as String,
      labels: (fields[5] as List).cast<String>(),
      receivedAt: fields[6] as DateTime,
      isRead: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EmailModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.sender)
      ..writeByte(3)
      ..write(obj.recipient)
      ..writeByte(4)
      ..write(obj.body)
      ..writeByte(5)
      ..write(obj.labels)
      ..writeByte(6)
      ..write(obj.receivedAt)
      ..writeByte(7)
      ..write(obj.isRead);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
