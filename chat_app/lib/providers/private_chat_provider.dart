import 'package:chat_app/model/private_message_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allUsersProvider = StreamProvider<List<UserModel>>((ref) {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) return Stream.value([]);
  
  return FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .where((doc) => doc.id != currentUser.uid)
        .map((doc) {
      final data = doc.data();
      return UserModel.fromMap({
        'uid': doc.id,
        'username': data['username'],
        'email': data['email'],
      });
    }).toList();
  });
});

final privateMessagesProvider = StreamProvider.family<List<PrivateMessageModel>, String>((ref, chatId) {
  return FirebaseFirestore.instance
      .collection('private_chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return PrivateMessageModel.fromMap(doc.data());
    }).toList();
  });
});

final privateMessageControllerProvider = NotifierProvider<PrivateMessageNotifier, PrivateMessageState>(() {
  return PrivateMessageNotifier();
});

class PrivateMessageState {
  final String text;
  final bool isLoading;

  const PrivateMessageState({
    this.text = '',
    this.isLoading = false,
  });

  PrivateMessageState copyWith({
    String? text,
    bool? isLoading,
  }) {
    return PrivateMessageState(
      text: text ?? this.text,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PrivateMessageNotifier extends Notifier<PrivateMessageState> {
  @override
  PrivateMessageState build() {
    return const PrivateMessageState();
  }

  void updateText(String text) {
    state = state.copyWith(text: text);
  }

  String _generateChatId(String userId1, String userId2) {
    final users = [userId1, userId2]..sort();
    return users.join('_');
  }

  Future<String?> sendPrivateMessage(UserModel receiver) async {
    final text = state.text.trim();
    if (text.isEmpty) return 'Message cannot be empty';

    state = state.copyWith(isLoading: true);

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      state = state.copyWith(isLoading: false);
      return 'User not authenticated';
    }

    try {
      final senderDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final senderData = senderDoc.data();
      if (senderData == null) {
        state = state.copyWith(isLoading: false);
        return 'Sender data not found';
      }

      final chatId = _generateChatId(currentUser.uid, receiver.uid);
      
      final message = PrivateMessageModel(
        text: text,
        senderId: currentUser.uid,
        senderUsername: senderData['username'],
        receiverId: receiver.uid,
        receiverUsername: receiver.username,
      );

      await FirebaseFirestore.instance
          .collection('private_chats')
          .doc(chatId)
          .set({
        'participants': [currentUser.uid, receiver.uid],
        'participantNames': [senderData['username'], receiver.username],
        'lastMessage': text,
        'lastMessageTime': FieldValue.serverTimestamp(),
        'lastMessageSender': currentUser.uid,
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('private_chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toMap());
      
      state = state.copyWith(text: '', isLoading: false);
      return null;
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return 'Failed to send message: $error';
    }
  }
}

final userChatsProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final currentUser = FirebaseAuth.instance.currentUser;
  
  if (currentUser == null) {
    return Stream.value([]);
  }
  
  return FirebaseFirestore.instance
      .collection('private_chats')
      .where('participants', arrayContains: currentUser.uid)
      .snapshots()
      .map((snapshot) {
    final chats = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'chatId': doc.id,
        'participants': data['participants'] as List<dynamic>,
        'participantNames': data['participantNames'] as List<dynamic>,
        'lastMessage': data['lastMessage'] ?? '',
        'lastMessageTime': data['lastMessageTime'] as Timestamp?,
        'lastMessageSender': data['lastMessageSender'] ?? '',
      };
    }).toList();
    return chats;
  });
});