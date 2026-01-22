// ignore_for_file: deprecated_member_use

import 'package:chat_app/model/private_message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrivateMessageBubble extends StatelessWidget {
  const PrivateMessageBubble.first({
    super.key,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  const PrivateMessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = false;

  final bool isFirstInSequence;
  final PrivateMessageModel message;
  final bool isMe;

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      return DateFormat('hh:mm').format(dateTime);
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday ${DateFormat('hh:mm').format(dateTime)}';
    } else {
      return DateFormat('MMM dd, HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: 2,
      ),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe && isFirstInSequence) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              child: Text(
                message.senderUsername.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ] else if (!isMe) ...[
            const SizedBox(width: 40),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (isFirstInSequence) const SizedBox(height: 8),
                if (!isMe && isFirstInSequence)
                  Container(
                    margin: const EdgeInsets.only(left: 12, bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.senderUsername,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                        fontSize: 11,
                      ),
                    ),
                  ),

                Container(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.75,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.03,
                    horizontal: screenWidth * 0.04,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    gradient: isMe
                        ? LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primary.withValues(alpha: 0.8),
                            ],
                          )
                        : LinearGradient(
                            colors: [
                              Colors.grey[100]!,
                              Colors.grey[50]!,
                            ],
                          ),
                    borderRadius: BorderRadius.only(
                      topLeft: !isMe && isFirstInSequence
                          ? const Radius.circular(4)
                          : const Radius.circular(18),
                      topRight: isMe && isFirstInSequence
                          ? const Radius.circular(4)
                          : const Radius.circular(18),
                      bottomLeft: const Radius.circular(18),
                      bottomRight: const Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        softWrap: true,
                        style: TextStyle(
                          height: 1.4,
                          fontSize: screenWidth * 0.04,
                          color: isMe ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (message.createdAt != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _formatTime(message.createdAt!.toDate()),
                          style: TextStyle(
                            fontSize: screenWidth * 0.025,
                            color: isMe 
                                ? Colors.white.withValues(alpha: 0.7) 
                                : Colors.grey[600],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          if (isMe && isFirstInSequence) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 16,
              ),
            ),
          ] else if (isMe) ...[
            const SizedBox(width: 40),
          ],
        ],
      ),
    );
  }
}