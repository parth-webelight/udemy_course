// ignore_for_file: deprecated_member_use

import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/widgets/private_chat_message.dart';
import 'package:chat_app/widgets/private_new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrivateChatScreen extends StatelessWidget {
  final UserModel user;

  const PrivateChatScreen({super.key, required this.user});

  String _generateChatId(String userId1, String userId2) {
    final users = [userId1, userId2]..sort();
    return users.join('_');
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('User not authenticated')),
      );
    }

    final chatId = _generateChatId(currentUser.uid, user.uid);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              child: Text(
                user.username.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.1),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[50]!,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Private chat with ${user.username}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PrivateChatMessage(chatId: chatId),
            ),
            PrivateNewMessage(receiver: user),
          ],
        ),
      ),
    );
  }
}