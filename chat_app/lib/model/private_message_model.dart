import 'package:cloud_firestore/cloud_firestore.dart';

class PrivateMessageModel {
  final String text;
  final String senderId;
  final String senderUsername;
  final String receiverId;
  final String receiverUsername;
  final Timestamp? createdAt;
  final bool isRead;

  const PrivateMessageModel({
    required this.text,
    required this.senderId,
    required this.senderUsername,
    required this.receiverId,
    required this.receiverUsername,
    this.createdAt,
    this.isRead = false,
  });

  PrivateMessageModel copyWith({
    String? text,
    String? senderId,
    String? senderUsername,
    String? receiverId,
    String? receiverUsername,
    Timestamp? createdAt,
    bool? isRead,
  }) {
    return PrivateMessageModel(
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      senderUsername: senderUsername ?? this.senderUsername,
      receiverId: receiverId ?? this.receiverId,
      receiverUsername: receiverUsername ?? this.receiverUsername,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'senderUsername': senderUsername,
      'receiverId': receiverId,
      'receiverUsername': receiverUsername,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'isRead': isRead,
    };
  }

  factory PrivateMessageModel.fromMap(Map<String, dynamic> map) {
    return PrivateMessageModel(
      text: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      senderUsername: map['senderUsername'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverUsername: map['receiverUsername'] ?? '',
      createdAt: map['createdAt'] as Timestamp?,
      isRead: map['isRead'] ?? false,
    );
  }
}