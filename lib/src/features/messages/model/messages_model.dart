// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);

import 'dart:convert';

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));

String messagesToJson(Messages data) => json.encode(data.toJson());

class Messages {
  int? id;
  String? senderName;
  String? text;
  dynamic attachment;
  DateTime? createdAt;
  bool? read;
  bool? deleted;
  int? sender;

  Messages({
    required this.id,
    required this.senderName,
    required this.text,
    this.attachment,
    required this.createdAt,
    required this.read,
    required this.deleted,
    required this.sender,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        id: json["id"],
        senderName: json["sender_name"],
        text: json["text"],
        attachment: json["attachment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        read: json["read"],
        deleted: json["deleted"],
        sender: json["sender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_name": senderName,
        "text": text,
        "attachment": attachment,
        "created_at": createdAt!.toIso8601String(),
        "read": read,
        "deleted": deleted,
        "sender": sender,
      };
}
