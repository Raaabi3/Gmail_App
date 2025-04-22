import 'package:hive/hive.dart';
part 'EmailModel.g.dart';

@HiveType(typeId: 1)
class EmailModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String subject;

  @HiveField(2)
  String sender;

  @HiveField(3)
  String recipient;

  @HiveField(4)
  String body; // Changed to full body

  @HiveField(5)
  List<String> labels;

  @HiveField(6)
  DateTime receivedAt;

  @HiveField(7)
  bool isRead;

  @HiveField(8)
  String threadId;

  @HiveField(9)
  List<String>? attachments;

  EmailModel({
    required this.id,
    required this.subject,
    required this.sender,
    required this.recipient,
    required this.body,
    required this.labels,
    required this.receivedAt,
    this.isRead = false,
    this.threadId = '',
    this.attachments,
  });
}
