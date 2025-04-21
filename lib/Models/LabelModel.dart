import 'package:hive/hive.dart';
part 'LabelModel.g.dart';

@HiveType(typeId: 2)
class LabelModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String color;

  LabelModel({
    required this.id,
    required this.name,
    required this.color,
  });
}
