// ignore_for_file: deprecated_member_use

import 'package:chat_app/providers/private_chat_provider.dart';
import 'package:chat_app/widgets/private_message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivateChatMessage extends StatelessWidget {
  final String chatId;

  const PrivateChatMessage({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer(
      builder: (context, ref, child) {
        final messagesAsync = ref.watch(privateMessagesProvider(chatId));
        
        return messagesAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Something went wrong...',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          ),
          data: (messages) {
            if (messages.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No messages yet',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start your private conversation!',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.02,
                left: 8,
                right: 8,
                top: 16,
              ),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final currentMessage = messages[index];
                final nextMessage = index + 1 < messages.length
                    ? messages[index + 1]
                    : null;

                final currentSenderId = currentMessage.senderId;
                final nextSenderId = nextMessage?.senderId;

                final isMe = authUser?.uid == currentSenderId;
                final isSameUser = nextSenderId == currentSenderId;

                if (isSameUser) {
                  return PrivateMessageBubble.next(
                    message: currentMessage,
                    isMe: isMe,
                  );
                }

                return PrivateMessageBubble.first(
                  message: currentMessage,
                  isMe: isMe,
                );
              },
            );
          },
        );
      },
    );
  }
}