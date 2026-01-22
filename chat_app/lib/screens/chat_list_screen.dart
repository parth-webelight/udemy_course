import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/private_chat_provider.dart';
import 'package:chat_app/screens/private_chat_screen.dart';
import 'package:chat_app/screens/users_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      return DateFormat('hh:mm').format(dateTime);
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else if (now.difference(dateTime).inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('MMM dd').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref.read(authStateProvider.notifier).signOut();
                },
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
              );
            },
          ),
        ],
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
        child: Consumer(
          builder: (context, ref, child) {
            final chatsAsync = ref.watch(userChatsProvider);
            
            return chatsAsync.when(
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
                      'Failed to load chats',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref.refresh(userChatsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (chats) {
                if (chats.isEmpty) {
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
                          'No chats yet',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the + button to start a new chat!',
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
                  padding: const EdgeInsets.all(16),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final participants = chat['participants'] as List<dynamic>;
                    final participantNames = chat['participantNames'] as List<dynamic>;
                    final lastMessage = chat['lastMessage'] as String;
                    final lastMessageTime = chat['lastMessageTime'];
                    final lastMessageSender = chat['lastMessageSender'] as String;
                    
                    final otherUserId = participants.firstWhere(
                      (id) => id != currentUser?.uid,
                      orElse: () => '',
                    );
                    final otherUserName = participantNames.firstWhere(
                      (name) => participants[participantNames.indexOf(name)] != currentUser?.uid,
                      orElse: () => 'Unknown User',
                    );

                    return _buildChatCard(
                      context,
                      chat['chatId'],
                      otherUserId,
                      otherUserName,
                      lastMessage,
                      lastMessageTime,
                      lastMessageSender == currentUser?.uid,
                      screenWidth,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UsersListScreen(),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildChatCard(
    BuildContext context,
    String chatId,
    String otherUserId,
    String otherUserName,
    String lastMessage,
    dynamic lastMessageTime,
    bool isMyLastMessage,
    double screenWidth,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final otherUser = UserModel(
              uid: otherUserId,
              username: otherUserName,
              email: '',
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PrivateChatScreen(user: otherUser),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  child: Text(
                    otherUserName.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            otherUserName,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.045,
                              color: Colors.black87,
                            ),
                          ),
                          if (lastMessageTime != null)
                            Text(
                              _formatTime(lastMessageTime.toDate()),
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: screenWidth * 0.03,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (isMyLastMessage)
                            Icon(
                              Icons.done,
                              size: 16,
                              color: Colors.grey[500],
                            ),
                          if (isMyLastMessage) const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              lastMessage.isEmpty ? 'No messages yet' : lastMessage,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: screenWidth * 0.035,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}