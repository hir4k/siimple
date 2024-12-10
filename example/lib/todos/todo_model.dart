// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoModel {
  final String id;
  final String text;
  TodoModel({
    required this.id,
    required this.text,
  });

  TodoModel copyWith({
    String? id,
    String? text,
  }) {
    return TodoModel(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TodoModel(id: $id, text: $text)';

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.text == text;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode;
}
