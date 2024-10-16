// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:todolist/src/domain/entities/entities.dart';

class TaskModel extends Task {
  @override
  String? title;
  @override
  String content;
  @override
  int id;

  TaskModel({
    this.title,
    required this.content,
    required this.id,
  });

  TaskModel copyWith({
    String? title,
    String? content,
    int? id,
  }) {
    return TaskModel(
      title: title ?? this.title,
      content: content ?? this.content,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'id': id,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TaskModel(title: $title, content: $content, id: $id)';

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.content == content && other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ id.hashCode;
}
