import 'package:intl/intl.dart';

class WorkEntity {
  int id;
  DateTime createdTime;
  int type;
  String title;
  String content;
  DateTime scheduleTime;

  WorkEntity({
    required this.id,
    required this.createdTime,
    required this.type,
    required this.title,
    required this.content,
    required this.scheduleTime,
  });

  factory WorkEntity.fromJson(Map<String, dynamic> json) {
    return WorkEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      type: json['type'],
      title: json['title'],
      content: json['content'],
      scheduleTime: DateTime.parse(json['scheduleTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'type': type,
      'title': title,
      'content': content,
      'scheduleTime': scheduleTime.toIso8601String(),
    };
  }

  String get createdTimeStr {
    return DateFormat('yyyy-MM-dd').format(createdTime);
  }

  String get scheduleTimeStr {
    return DateFormat('yyyy-MM-dd HH:mm').format(scheduleTime);
  }
}