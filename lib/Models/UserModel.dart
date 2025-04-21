import 'package:hive/hive.dart';
part 'UserModel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String avatarUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });
}
