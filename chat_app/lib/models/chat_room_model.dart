import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String roomId;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;

  ChatRoom({
    required this.roomId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatRoom.fromMap(String roomId, Map<String, dynamic> map) {
    return ChatRoom(
      roomId: roomId,
      participants: List<String>.from(map['participants']),
      lastMessage: map['lastMessage'] ?? "",
      lastMessageTime: (map['lastMessageTime'] as Timestamp).toDate(),
    );
  }
}
