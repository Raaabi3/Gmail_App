import 'package:hive/hive.dart';
part 'AuthTokenModel.g.dart';

@HiveType(typeId: 3)
class AuthTokenModel extends HiveObject {
  @HiveField(0)
  String accessToken;

  @HiveField(1)
  String refreshToken;

  @HiveField(2)
  DateTime expiry;

  AuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiry,
  });
}
