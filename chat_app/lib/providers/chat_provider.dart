// ignore_for_file: avoid_print

import 'package:chat_app/models/chat_message_model.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/chat_state_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final chatProvider =
    StateNotifierProvider.family<ChatProvider, ChatStateModel, String>(
      (ref, receiverId) => ChatProvider(receiverId),
    );
// GET USERNAME USING UID
final userNameProvider = FutureProvider.family<String, String>((
  ref,
  uid,
) async {
  final doc = await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .get();

  if (!doc.exists) return "Unknown User";

  return doc.data()!["userName"] ?? "Unknown User";
});

// GET CHAT LIST USING UID
final chatListProvider = StreamProvider<List<ChatRoom>>((ref) {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  return FirebaseFirestore.instance
      .collection("chatRooms")
      .where("participants", arrayContains: uid)
      .orderBy("lastMessageTime", descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs
            .map((doc) => ChatRoom.fromMap(doc.id, doc.data()))
            .toList();
      });
});

class ChatProvider extends StateNotifier<ChatStateModel> {
  final String receiverId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatProvider(this.receiverId) : super(const ChatStateModel()) {
    _loadMessages();
  }

  String get currentUserId => _auth.currentUser?.uid ?? '';

// GET CHAT ROOM ID USING CURRENT USER ID AND RECEIVER ID
  String get chatRoomId {
    final users = [currentUserId, receiverId];
    users.sort();
    return users.join('_');
  }

// LOAD MESSAGES USING CHAT ROOM ID
  void _loadMessages() {
    state = state.copyWith(isLoading: true);
    _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
          final messages = snapshot.docs
              .map((doc) => ChatMessageModel.fromMap(doc.data()))
              .toList();

          state = state.copyWith(messages: messages, isLoading: false);
        });
  }

  void updateCurrentMessage(String msg) {
    state = state.copyWith(currentMessage: msg);
  }

// SEND MESSAGE USING CHAT ROOM ID
  Future<void> sendMessage() async {
    if (state.currentMessage.trim().isEmpty || state.isSending) return;

    state = state.copyWith(isSending: true);

    try {
      final messageId = _firestore.collection('chatRooms').doc().id;

      final message = ChatMessageModel(
        id: messageId,
        senderId: currentUserId,
        receiverId: receiverId,
        message: state.currentMessage.trim(),
        timestamp: DateTime.now(),
        isRead: false,
      );

      await _firestore.collection('chatRooms').doc(chatRoomId).set({
        'participants': [currentUserId, receiverId],
        'lastMessage': message.message,
        'lastMessageTime': message.timestamp,
        'lastMessageSender': currentUserId,
      }, SetOptions(merge: true));
                        
      await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());

      state = state.copyWith(currentMessage: '');
    } catch (e) {
      print("Error sending : $e");
    } finally {
      state = state.copyWith(isSending: false);
    }
  }
}
