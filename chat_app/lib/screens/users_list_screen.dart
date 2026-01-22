import 'package:chat_app/providers/private_chat_provider.dart';
import 'package:chat_app/screens/private_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Start New Chat'),
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
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Consumer(
          builder: (context, ref, child) {
            final usersAsync = ref.watch(allUsersProvider);

            return usersAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load users',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref.refresh(allUsersProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (users) {
                if (users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.people_outline,
                            size: 48,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No users found',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Be the first to start chatting!',
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
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
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
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    PrivateChatScreen(user: user),
                              ),
                            );
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.1),
                                  child: Text(
                                    user.username.substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.username,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: screenWidth * 0.045,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        user.email,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: screenWidth * 0.035,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.chat_bubble_outline,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
