// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VMCHistoryModel {
  final String id;
  final String action;
  final int pointsEarned;
  final DateTime? dateCreated;

  VMCHistoryModel({
    required this.id,
    required this.action,
    required this.pointsEarned,
    this.dateCreated,
  });

  VMCHistoryModel copyWith({
    String? id,
    String? action,
    int? pointsEarned,
    DateTime? dateCreated,
  }) {
    return VMCHistoryModel(
      id: id ?? this.id,
      action: action ?? this.action,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'action': action,
      'pointsEarned': pointsEarned,
      'dateCreated': dateCreated?.toIso8601String(),
    };
  }

  factory VMCHistoryModel.fromMap(Map<String, dynamic> map) {
    try {
      return VMCHistoryModel(
          id: map['id'] as String,
          action: map['action'] as String,
          pointsEarned: map['pointsEarned'] as int,
          dateCreated: DateTime.tryParse(map['dateCreated'] ?? ''));
    } catch (e, st) {
      print("$e, $st");
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory VMCHistoryModel.fromJson(String source) =>
      VMCHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VMCHistoryModel(id: $id, action: $action, pointsEarned: $pointsEarned, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(covariant VMCHistoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.action == action &&
        other.pointsEarned == pointsEarned &&
        other.dateCreated == dateCreated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        action.hashCode ^
        pointsEarned.hashCode ^
        dateCreated.hashCode;
  }
}
